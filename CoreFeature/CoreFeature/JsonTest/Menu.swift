//
//  Menu.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/2/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import Foundation
import UIKit

class Menu{
    let backView = UIView()
    let menuWidth:CGFloat = 150
    let menuView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    init(viewcontroler: UIViewController){
        if let window = UIApplication.shared.keyWindow{
            backView.frame = window.frame
            backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissHandler)))
            backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissHandler)))
            backView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            backView.alpha = 0
            
            menuView.frame = CGRect(x: -1*menuWidth, y: 0, width: menuWidth, height: window.frame.height)
            viewcontroler.view.addSubview(self.backView)
        }
    }
    
    func show(){
        if let window = UIApplication.shared.keyWindow{
            window.addSubview(backView)
            //window.addSubview(menuView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.backView.alpha = 1
                self.menuView.frame = CGRect(x: 0, y: 0, width: self.menuWidth, height: window.frame.height)
            }, completion: nil)
        }
    }
    
    // @objc func handleTap(_ sender: UITapGestureRecognizer) {
    @objc func dismissHandler(){
        print("XXXXXXXXX")
        if let window = UIApplication.shared.keyWindow{
            UIView.animate(withDuration: 0.5, animations: {
                self.backView.alpha = 0
                self.menuView.frame = CGRect(x: -1*self.menuWidth, y: 0, width: self.menuWidth, height: window.frame.height)
            }){(isSuccess) in
                if(isSuccess){
                    self.backView.removeFromSuperview()
                    self.menuView.removeFromSuperview()
                }
            }
        }
    }
}
