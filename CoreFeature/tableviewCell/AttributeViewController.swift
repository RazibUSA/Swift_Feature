//
//  AttributeViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/4/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class AttributeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      //  let anotheR: anotherView = anotherView(frame: view.bounds)
        let anotheR: anotherView = anotherView(frame:view.bounds)
        view.backgroundColor = UIColor.yellow
        view.addSubview(anotheR)
        anotheR.backgroundColor = UIColor.lightGray
      //  anotheR.boxRect = CGRect(x: 100, y: 300, width: 50, height: 10)
        anotheR.draw(CGRect(x: 100, y: 300, width: 50, height: 10))
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    }
    
    class anotherView: UIView {
        var string = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s." as NSString
       override  func draw(_ rect: CGRect) {
        
        print("MMMM", rect.origin.x)
        
        string.draw(in: CGRect(x: 100, y: 300, width: 50, height: 10), withAttributes:  [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24)])
        super.draw(rect)
        }
        
        func drawString(_ rect: CGRect) {
            let string = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s." as NSString
            string.draw(in: rect, withAttributes:  [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24)])
            
        }
        
        
}





