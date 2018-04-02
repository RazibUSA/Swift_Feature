//
//  DomesticViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 3/30/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class DomesticPageViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
