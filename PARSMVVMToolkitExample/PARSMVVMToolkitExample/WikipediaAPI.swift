import Foundation
import ReactiveCocoa
import Alamofire

extension String {
    var URLEscaped: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()) ?? ""
    }
}

func apiError(error: String) -> NSError {
    return NSError(domain: "WikipediaAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: error])
}

public let WikipediaParseError = apiError("Error during parsing")

protocol WikipediaAPI {
    func getSearchResults(query: String) -> SignalProducer<[WikipediaSearchResult], NSError>
    func articleContent(searchResult: WikipediaSearchResult) -> SignalProducer<WikipediaPage, NSError>
}

class DefaultWikipediaAPI: WikipediaAPI {
    
    static let sharedAPI = DefaultWikipediaAPI() // Singleton
    
    private init() {}

    private func getJSONSignal(URL: NSURL) -> SignalProducer<AnyObject, NSError> {
        return SignalProducer { observer, disposable in
            Alamofire.request(.GET, URL).responseJSON {
                response in
                if (response.result.error != nil) {
                    observer.sendFailed(response.result.error!)
                } else {
                    observer.sendNext(response.result.value!)
                    observer.sendCompleted()
                }
            }
        }
    }

    func getSearchResults(query: String) -> SignalProducer<[WikipediaSearchResult], NSError> {
        let escapedQuery = query.URLEscaped
        let urlContent = "http://en.wikipedia.org/w/api.php?action=opensearch&search=\(escapedQuery)"
        let url = NSURL(string: urlContent)!
        return getJSONSignal(url).observeOn(QueueScheduler()).filter({ (json) -> Bool in
            guard json is [AnyObject] else {
                return false
            }
            return true
        }).map({ (json) -> [WikipediaSearchResult] in
            let jsonArray = json as! [AnyObject]
            return WikipediaSearchResult.parseJSON(jsonArray)
        }).observeOn(UIScheduler()).flatMapError { error in
            print("Network error occurred: \(error)")
            return SignalProducer.empty
        }
    }
    
    func articleContent(searchResult: WikipediaSearchResult) -> SignalProducer<WikipediaPage, NSError> {
        let escapedPage = searchResult.title.URLEscaped
        guard let url = NSURL(string: "http://en.wikipedia.org/w/api.php?action=parse&page=\(escapedPage)&format=json") else {
            return SignalProducer(error: NSError(domain: "Can't create url", code: -1, userInfo: nil))
        }
        return getJSONSignal(url).observeOn(QueueScheduler()).filter { jsonResult in
            guard jsonResult is NSDictionary else {
                return false
            }
            return true
            }.map { json in
                return WikipediaPage.parseJSON(json as! NSDictionary)
            }.observeOn(UIScheduler()).flatMapError { error in
                print("Network error occurred: \(error)")
                return SignalProducer.empty
        }
    }
}