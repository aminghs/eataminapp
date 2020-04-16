//
//  InstagramTab.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/22/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit

class Instagram: BaseAdapter, UIWebViewDelegate{
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        indicatorLoading.startAnimating()
        let url = URL (string: "https://www.instagram.com/nillicious.group/");
        let requestObj = URLRequest(url: url!);
        webView.loadRequest(requestObj);
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        
        
        indicatorLoading.stopAnimating()
        indicatorLoading.alpha = 0

        
    }

    
    
}
