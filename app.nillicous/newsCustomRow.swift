//
//  customRow.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/15/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit

class newsCustomRow: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsTitle: UILabel!
    
    @IBOutlet weak var newsBody: UILabel!
    
    @IBOutlet weak var newsDate: UILabel!
    
    @IBOutlet weak var moreData: UILabel!
    @IBOutlet weak var newsBodyConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        newsDate?.layer.cornerRadius = 5
        newsDate?.layer.masksToBounds = true

        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       // print(selected)
        // Configure the view for the selected state
    }

}
