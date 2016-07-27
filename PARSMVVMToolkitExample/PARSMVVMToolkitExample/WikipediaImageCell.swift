//
//  WikipediaImageCell.swift
//  PARSMVVMToolkitExample
//
//  Created by gz on 16/7/20.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa
import Result

enum DownloadableImage{
    case Content(image: UIImage)
    case OfflinePlaceholder
    
}

public class WikipediaImageCell: UICollectionViewCell {
    @IBOutlet var imageOutlet: UIImageView!
    deinit {
        
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    

}