//
//  pdfviewtest.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/13/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class PdfViewController1: UIViewController, WKUIDelegate, WKNavigationDelegate {
    let videocode = "uuxXHAKA1WY"
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var webviewOld: UIWebView!
    
    var refreshControl:UIRefreshControl?
    
    var newWebView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        //      let url = URL(string: "http://www.iso.org/iso/annual_report_2009.pdf")
        //        let url = URL(string:"http://mailer.hdfcbank.com/campaign/Asset/hdfcbank_credit-card-rewards-catalogue.pdf?_ga=2.15849718.1539559274.1522467278-2054142928.1522467278")
        let url = URL(string : "https://www.hdfcbank.com/assets/pdf/Rewards_Catalogue.pdf")
        
        
        
        let scurl = URL(string: "http://insight.dev.schoolwires.com/HelpAssets/C2Assets/C2Files/C2ImportFamRelSample.csv")
        let request = URLRequest(url : scurl!)
        //  webView.load(request)
        //  webView.load(URLRequest(url: scurl!))
        let data = try! Data(contentsOf: scurl!)
        
        
        
        //        webView.load(data, mimeType: "/csv", characterEncodingName: "", baseURL: (scurl?.deletingLastPathComponent())!)
        
        let contentController = WKUserContentController()
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        newWebView = WKWebView(frame: self.view.frame, configuration: config)
        
        newWebView?.uiDelegate = self
        newWebView?.navigationDelegate = self
        newWebView?.contentMode = .redraw
        
        self.webView.scrollView.contentSize = self.view.frame.size
        self.webView.frame.size = self.view.frame.size
        
        if let url = Bundle.main.url(forResource: "test", withExtension: "html") {
            newWebView?.load(URLRequest(url: url))
        }
        
        
        self.view.addSubview(newWebView!)
        
        
        //    webviewOld.load(csvData, mimeType: "text/csv", textEncodingName: "", baseURL: csvUrl)
        //   webView.load(csvData, mimeType: "text/csv", characterEncodingName: "UTF-8", baseURL: (csvUrl.deletingLastPathComponent()))
        //   webView.loadFileURL(csvUrl, allowingReadAccessTo: csvUrl)
        
        
        // webView.load(csvData, mimeType: "text/csv", textEncodingName: "", baseURL: csvUrl)
        
        //        let data =
        //        webView.load(data, mimeType: "application/pdf", characterEncodingName: "", baseURL: (desURL.deletingLastPathComponent()))
        
        //        if let pdfURL = Bundle.main.url(forResource: "myPDF", withExtension: "pdf", subdirectory: nil, localization: nil)  {
        //            do {
        //                let data = try Data(contentsOf: pdfURL)
        //                let webView = WKWebView(frame: CGRect(x:20,y:20,width:view.frame.size.width-40, height:view.frame.size.height-40))
        //                webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: pdfURL.deletingLastPathComponent())
        //                view.addSubview(webView)
        //
        //            }
        //            catch {
        //                // catch errors here
        //            }
        // loadPdf(url: url!)
        
        //        fetchOffers(success:{[weak self] (code) in
        //            self?.getVideo(videoCode: code)
        //        }) { (error) in
        //            print(error)
        //        }
    }
    
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        print("creates webview with")
        
        if navigationAction.targetFrame == nil {
            newWebView?.removeFromSuperview()
            let contentController = WKUserContentController()
            let config = WKWebViewConfiguration()
            config.userContentController = contentController
            newWebView = WKWebView(frame: self.view.frame, configuration: config)
            
            newWebView?.uiDelegate = self
            newWebView?.navigationDelegate = self
            newWebView?.contentMode = .redraw
            var tsr = navigationAction.request.url?.absoluteString
            var truncated = tsr?.substring(to: (tsr?.index(before: (tsr?.endIndex)!))!)
            print(truncated)
            
            self.view.addSubview(newWebView!)
            newWebView?.load(URLRequest(url: URL(string: truncated!)! ))
            
            
            //   newWebView?.loadHTMLString(<#T##string: String##String#>, baseURL: navigationAction.request.url)
            
        }
        return   nil   //WKWebView()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    
    
    func addBackButton() {
        let backButton = UIButton()
        backButton.tintColor = .green
        backButton.setTitle("<Back", for: .normal)
        backButton.setTitleColor(.green, for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //   self.navigationController?.navigationBar.back
        
    }
    
    
    
    
    
    
    func fetchOffers(success: @escaping ((_ code: String) -> Void), failure: @escaping ((_ error: Error) -> Void)){
        
        
        success("linkcode")
        
        
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Star loading")
        print(newWebView?.url)
        //  webView.reload()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finish to load")
        
    }
    
    func getVideo(videoCode:String){
        let url = URL(string: "https:/www.youtube.com/embed/\(videoCode)")
        webView.load(URLRequest(url : url!))
    }
    
    
    
    func loadPdf(url: URL){
        let docUrl:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let desURL = docUrl.appendingPathComponent("sample.pdf")
        
        //   let data = Data(contentsOf: url)
        //"  print(data)
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URLData, response, error) -> Void in
            do{
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Success: \(statusCode)")
                }
                
                print(URLData)
                
                let isFileFound:Bool? = FileManager.default.fileExists(atPath: desURL.path)
                if isFileFound == true{
                    print(desURL)
                } else {
                    try FileManager.default.copyItem(at: URLData!, to: desURL)
                }
                //   let request = URLRequest(url : desURL)
                DispatchQueue.main.async {
                    
                    //                    let request = URLRequest(url: fileURL)
                    //                    self?.webView.load(request)
                    do{
                        let data = try!  Data(contentsOf: desURL)
                        self?.webView.load(data, mimeType: "application/pdf", characterEncodingName: "", baseURL: url.deletingLastPathComponent())
                    } catch let err {
                        print(err)
                    }
                    
                    
                    
                }
                
                
            }catch let err {
                print(err.localizedDescription)
            }
        })
        downloadTask.resume()
    }
}

import JavaScriptCore

extension WKWebView {
    //    public func hijackConsoleLog() {
    //        if let context = value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") {
    //            (context as AnyObject).evaluateScript("var console = { log: function(message) { _consoleLog(message) } }")
    //            let consoleLog: @convention(block) (String) -> Void = { message in
    //                print("javascript_log: " + message)
    //            }
    //            context .setObject(unsafeBitCast(consoleLog, AnyObject.self), forKeyedSubscript: "_consoleLog")
    //        }
    //    }
}
