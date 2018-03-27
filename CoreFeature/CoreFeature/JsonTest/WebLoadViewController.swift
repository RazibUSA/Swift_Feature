//
//  WebLoadViewController.swift
//  CoreFeature
//
//  Created by Razib Mollick on 3/21/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit
import WebKit

class WebLoadViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.google.co.uk")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
