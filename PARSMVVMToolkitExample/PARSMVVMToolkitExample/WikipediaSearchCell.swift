//
//  WikipediaSearchCell.swift
//  PARSMVVMToolkitExample
//
//  Created by gz on 16/7/20.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation
import UIKit

public class WikipediaSearchCell: UITableViewCell {
    @IBOutlet var titleOutlet: UILabel!
    @IBOutlet var URLOutlet: UILabel!
    @IBOutlet var imagesOutlet: UICollectionView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imagesOutlet.registerNib(UINib(nibName: "WikipediaImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
    }
}