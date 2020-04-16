//
//  restaurantsMenuCustomRow.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/30/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit

class restaurantsMenuCustomRow: UITableViewCell {
    
    
  
    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // print(selected)
        // Configure the view for the selected state
        
        
    }
    
}
