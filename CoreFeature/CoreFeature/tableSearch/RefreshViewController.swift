//
//  RefreshViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/7/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit
import WebKit

class RefreshViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var refreshControl:UIRefreshControl?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.refreshControl = UIRefreshControl.init()
        
        self.refreshControl?.tintColor = UIColor.red
        
        refreshControl!.addTarget(self, action:#selector(refreshControlClicked), for: UIControlEvents.valueChanged)
        self.webView.scrollView.addSubview(self.refreshControl!)
        
        self.webView.scrollView.backgroundColor = UIColor.white
        
     //   self.webView.delegate = self
        
        
        let url:URL = URL.init(string:"https://www.google.com")!
        
        self.loadRequestWithUrl(URLRequest.init(url: url))
        
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        NSLog("website loaded")
    }
    
    func loadRequestWithUrl(_ urlRequest : URLRequest?){
        
        if(urlRequest != nil){
            
            self.webView.load(urlRequest!)
        }
    }
    
    @objc func refreshControlClicked(){
        
        let url:URL = URL.init(string:"https://www.facebook.com")!
        
        self.loadRequestWithUrl(URLRequest.init(url: url))
    }
}
