//
//  rstaurantCustomRow.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/21/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class restaurantCustomRow: UITableViewCell {
    
  
    @IBOutlet weak var crRestaurantName: UILabel!
    @IBOutlet weak var crRankStatus: UILabel!
    @IBOutlet weak var crRestaurantThumbnail: UIImageView!
   // @IBOutlet weak var crRestaurantRateImage: UIImageView!
    @IBOutlet weak var crRestaurantRank: CosmosView!
    
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
