//
//  ProgressViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/14/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let progressView = ProgressMenuView(frame: self.view.frame)
        self.view.addSubview(progressView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
