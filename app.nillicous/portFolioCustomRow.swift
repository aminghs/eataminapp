//
//  portFolioCustomRow.swift
//  com.eatamin
//
//  Created by Ali Ghayeni on 8/13/17.
//  Copyright © 2017 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit

class portFolioCustomRow: UITableViewCell {
    
//    @IBOutlet weak var newsImage: UIImageView!
//    
//    @IBOutlet weak var newsTitle: UILabel!
//    
//    @IBOutlet weak var newsBody: UILabel!
//    
//    @IBOutlet weak var newsDate: UILabel!
//    
//    @IBOutlet weak var moreData: UILabel!
//    @IBOutlet weak var newsBodyConstraint: NSLayoutConstraint!

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var more: UILabel!
    @IBOutlet weak var pfImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        date?.layer.cornerRadius = 5
        date?.layer.masksToBounds = true
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // print(selected)
        // Configure the view for the selected state
    }
    
}
