//
//  TestViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 3/16/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btn1_clicked(_ sender: Any) {
    }
    
    @IBAction func btn2_clicked(_ sender: Any) {
    }
    
    var anim:CABasicAnimation?
    
//    func one(icon: UIImage) {
//        CATransaction.begin()
//        
//        anim = CABasicAnimation(keyPath: "opacity")
//        anim?.duration = 1
//        anim?.fromValue = 1
//        anim?.toValue = 0
//        anim?.fillMode = kCAFillModeForwards
//        anim?.isRemovedOnCompletion = false
//        
//        CATransaction.setCompletionBlock {
//            self.setImage(icon, for: .normal)
//            self.imageView?.contentMode = .scaleAspectFit
//            self.imageView?.alpha = 0
//            
//            UIButton.animate(withDuration: 1, animations: {
//                self.imageView?.alpha = 1
//            })
//        }
//        
//        (self.layer.sublayers![1] as! CAShapeLayer).add(anim, forKey: "remove")
//        CATransaction.commit()
//    }
//    
//    
//    
//    func two() {
//        CATransaction.begin()
//        
//        anim.fromValue = 0
//        anim.toValue = 1
//        anim.fillMode = kCAFillModeForwards
//        anim.isRemovedOnCompletion = false
//        
//        CATransaction.setCompletionBlock {
//            UIButton.animate(withDuration: 1, animations: {
//                self.imageView?.alpha = 0
//            })
//        }
//        
//        (self.layer.sublayers![1] as! CAShapeLayer).add(anim, forKey: "remove")
//        CATransaction.commit()
//    }
//
//    func setImage
    
}
