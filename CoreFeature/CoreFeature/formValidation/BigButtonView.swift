//
//  BigButtonView.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/18/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class BigButtonView: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0.8039215686, green: 0.9529411765, blue: 0.9647058824, alpha: 1)
    
    @IBInspectable var gradientColorOne: UIColor = #colorLiteral(red: 0.2588235294, green: 0.8, blue: 0.8352941176, alpha: 1)
    @IBInspectable var gradientColorTwo: UIColor = #colorLiteral(red: 0.3254901961, green: 0.4392156863, blue: 0.8156862745, alpha: 1)
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    let btnImage = UIImage(named: "accepted") as UIImage?
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    
    func setupView(){
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
       // self.setImage(btnImage, for: UIControlState.normal)
       // self.setBackgroundImage(btnImage, for: UIControlState.normal)
       // self.imageView?.image = btnImage
       // self.imageView?.contentMode = .scaleAspectFit
//        self.contentVerticalAlignment = .fill;
//        self.contentHorizontalAlignment = .fill;
        
        self.setTitle("My Button", for: .normal)
        self.titleLabel?.font = UIFont(name: "SFUIDisplay-Regular", size: 22)
        
        self.setImage(UIImage(named: "accepted"), for: .normal)
        self.setImage(UIImage(named: "accepted"), for: .highlighted)
        let imageWidth = self.imageView!.frame.width
        let textWidth = (self.titleLabel?.text as! NSString).size(withAttributes:[NSAttributedStringKey.font:self.titleLabel!.font!]).width
        let width = textWidth + imageWidth + 24
        //24 - the sum of your insets from left and right
      //  self.frame.
        self.layoutIfNeeded()
        
        
        self.layer.masksToBounds = true
        setGradientBackground(colorOne: gradientColorOne, colorTwo: gradientColorTwo)
        
    }
}
