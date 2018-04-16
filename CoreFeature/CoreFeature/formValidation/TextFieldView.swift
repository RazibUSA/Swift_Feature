//
//  TextFieldView.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/12/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

@IBDesignable open class TextFieldView: UIView {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var messageLbl: UILabel!
    
    private var validator: InputValidator?
    private var isValidationPassed = false
    
    @IBInspectable var titleText: String? {
        get {
            return titleLbl.text
        }
        set(text) {
            titleLbl.text = text
        }
    }
    
    @IBInspectable var leftImage : UIImage? {
        didSet {
            if let image = leftImage{
                textField.leftViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 2, y: 0, width: 20, height: 20))
                imageView.image = image
                imageView.tintColor = UIColor.red
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 24, height: 20))
                view.addSubview(imageView)
                textField.leftView = view
            }else {
                textField.leftViewMode = .never
            }
            
        }
    }
    
    @IBInspectable var placeholderText: String? {
        get {
            return textField.placeholder
        }
        set(text) {
            textField.placeholder = text
        }
    }
    
    @IBInspectable var placeholderColor : UIColor? {
        didSet {
            let rawString = textField.attributedPlaceholder?.string != nil ? textField.attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString, attributes: [NSAttributedStringKey.foregroundColor : placeholderColor!])
           textField.attributedPlaceholder = str
        }
    }

    
    @IBInspectable var textFieldText: String? {
        get {
            return textField.text
        }
    }
    
    @IBInspectable var messageText: String {
        get {
            return messageLbl.text ?? ""
        }
        set(text) {
            messageLbl.text = text
        }
    }
    
    @IBInspectable
    public var tfCornerRadius: CGFloat = 0.0 {
        didSet {
            self.textField.layer.cornerRadius = self.tfCornerRadius
        }
    }
    
    @IBInspectable
    public var tfBorderWidth: CGFloat = 0.0 {
        didSet {
            self.textField.layer.borderWidth = self.tfBorderWidth
        }
    }
    
    @IBInspectable
    public var tfBorderColor: UIColor = UIColor.gray {
        didSet {
            self.textField.layer.borderColor = self.tfBorderColor.cgColor
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TextFieldView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        
         textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        self.addSubview(view)
    }
    
    
    @objc func textFieldDidChange() {
        print("call")
        guard let text = textFieldText else {
            return
        }
        
        guard let validator = validator else {
            print("No validator found")
            return
        }
        
        if  validator.validateInput(with: text, message: &messageText) {
            isValidationPassed = true
            messageLbl.textColor = UIColor.gray
        } else {
            messageLbl.textColor = UIColor.red
            shakeTextField(textfield: textField)
        }
        
    }

    func setValidation(with validationType:ValidationType) {
        validator = validationType.instance
    }
    
    func isValidationPass() -> Bool {
        return isValidationPassed
    }
    
}


extension TextFieldView {
    
    func shakeTextField(textfield : UITextField){
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

