import Foundation

struct WikipediaPage {
    let title: String
    let text: String
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
    
    // tedious parsing part
    static func parseJSON(json: NSDictionary) -> WikipediaPage {
        guard let title = json.valueForKey("parse")?.valueForKey("title") as? String,
              let text = json.valueForKey("parse")?.valueForKey("text")?.valueForKey("*") as? String else {
            return WikipediaPage(title: "", text: "")
        }
        
        return WikipediaPage(title: title, text: text)
    }
}