//
//  ValidatorTestViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/11/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class ValidatorTestViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var passwordView: TextFieldView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

       passwordView.setValidation(with: .passwordValidation)
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    name1.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
//    name2.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
//    name3.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
//    name4.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
//
//
   @objc func textFieldDidChange(textField: UITextField) {
    print("no call")
        if textField.text == ""  {
            shaketextField(textfield: textField)
        } else {
          var  tt = TextField(text: textField.text!, validator: PasswordInputValidator())
            if !tt.validate() {
                shaketextField(textfield: textField)
                label.text = tt.displayMessage
                label.textColor = UIColor.red
            }
        }
    }

}

extension ValidatorTestViewController {
    
    func shaketextField(textfield : UITextField){
        let shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let from_point:CGPoint = CGPoint(x: textfield.center.x - 5, y: textfield.center.y)
        let from_value:NSValue = NSValue(cgPoint: from_point)
        
        let to_point:CGPoint = CGPoint(x: textfield.center.x + 5, y: textfield.center.y)
        let to_value:NSValue = NSValue(cgPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        textfield.layer.add(shake, forKey: "position")
        
        
    }
}




