//
//  PdfViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 3/30/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit
import WebKit

class PdfViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    @IBOutlet weak var webViewSB: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let contentController = WKUserContentController()
//
//        let config = WKWebViewConfiguration()
//        config.userContentController = contentController
//
//        webView = WKWebView(frame: self.view.frame, configuration: config)
//        webView.navigationDelegate = self
//        webView.uiDelegate = self
        
        if let url = Bundle.main.url(forResource: "test", withExtension: "html") {
            webViewSB.load(URLRequest(url: URL(string: "https://mit.gsv.dk")!))
        }
     //   self.view.addSubview(webView!)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        print("creates webview with")
        return WKWebView()
    }
}
