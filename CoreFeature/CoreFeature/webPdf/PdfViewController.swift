//
//  PdfViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 3/30/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit
import WebKit

class PdfViewController: UIViewController, WKUIDelegate {
    let videocode = "uuxXHAKA1WY"
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var webviewOld: UIWebView!
    
    var refreshControl:UIRefreshControl?
    
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
        
        
        
        webView.load(data, mimeType: "/csv", characterEncodingName: "", baseURL: (scurl?.deletingLastPathComponent())!)
        
        
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
