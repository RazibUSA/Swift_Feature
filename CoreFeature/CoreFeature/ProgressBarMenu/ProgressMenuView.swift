//
//  ProgressMenuView.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/14/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class ProgressMenuView: UIView {
    
    var colors : [UIColor] = [UIColor.red, UIColor.green,UIColor.red,UIColor.green]
    var values : [CGFloat] = [50, 50, 50, 50]
    var titles : [String] = ["1", "2", "3", "4"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var menuState : Int  = 0
    var width : CGFloat = 0;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(deviceRotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc func deviceRotated() {
        self.width = self.frame.size.width / 4
        
        for subview in self.subviews {
            if subview is UIButton {
                subview.removeFromSuperview()
            }
        }
        self.reload()
    }
    
    func reload() {
        
        self.menuState = 2 // FIXME: CHANGE MENU STATE TO TEST
        
        UIView.animate(withDuration: 1) {
            self.layoutSubviews()
            self.setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createButtons (xPos : CGFloat, yPos: Int,index : Int) {
        self.width = self.frame.size.width / 4
        
        let button = UIButton(frame: CGRect(x: 0, y: yPos, width: 44, height: 44))
        button.center = CGPoint(x: CGFloat(xPos), y: CGFloat(yPos))
        button.setTitle(self.titles[index], for: .normal)
        
        button.layer.cornerRadius = button.bounds.size.width/2
        button.backgroundColor = UIColor.darkGray
        
        self.addSubview(button)
        
        let ctx = UIGraphicsGetCurrentContext()
        var cumulativeValue:CGFloat = 0
        
        for i in 0..<self.titles.count-1 {
            
            if i < menuState {
                ctx!.setFillColor(UIColor.green.withAlphaComponent(0.25).cgColor)
            } else {
                ctx!.setFillColor(UIColor.lightGray.withAlphaComponent(0.25).cgColor)
            }
            
            ctx!.fill(CGRect(x: Int((width/2 + cumulativeValue)), y: yPos, width:Int(self.width), height: 10))
            cumulativeValue += self.width
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        var cumulativeValue:CGFloat = 0
        
        let width : CGFloat = self.bounds.size.width / 4
        let yPos = self.bounds.size.height / 2
        
        for i in 0..<self.values.count {
            let xPoint = (width * CGFloat(i) + cumulativeValue)/2
            self.createButtons(xPos: (xPoint + width + cumulativeValue)/2, yPos: Int(yPos), index: i)
            cumulativeValue += width
        }
    }
}
