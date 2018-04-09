//
//  TestViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 3/16/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class TestViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var springView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.view.backgroundColor = UIColor(patternImage: backgroundImage!)
        LinkAttributeTest()
        createToolBar()
    }

    func sortList() {
        var myList: [(String, Double)] = [("Name1", 0.1), ("Name2", 0.2), ("Name4", 0.4)]
      
        
        let myNewElement: (String, Double) = ("Name3", 0.3)
        
        if let insertionIndex = myList.index(where: {myNewElement.1 <= $0.1}) {
            
            myList.insert(myNewElement, at: insertionIndex)
        }
        
        // myList = [("Name1", 0.1), ("Name2", 0.2), ("Name3", 0.3), ("Name4", 0.4)]
    }
    
    
     func LinkAttributeTest() {
        
        textView.delegate = self;
        textView.isSelectable = true
        textView.isEditable = false
        textField.delegate = self
        
        let linkAttributes : [NSAttributedStringKey : Any] = [.link: URL(string: "https://exemple.com")!,
            .font:UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.blue,
            .strokeColor : UIColor.black,
            .strokeWidth : -1] ;
            let attributedString  = NSMutableAttributedString(string: "Just click here to do stuff...")
            attributedString.setAttributes(linkAttributes, range:NSMakeRange(5, 10))
            textView.attributedText = attributedString;
        
//        var img = UIImage(named: "bg.png")
//        view.layer.contents = img?.cgImage
        
       let image =  UIImage(named: "car_top")
       springView.layer.contents = image?.cgImage
       springView.contentMode = UIViewContentMode.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("BBBB")
//        let backgroundImage = UIImage(named: "bg")
//        let imageView = UIImageView(frame: UIScreen.main.bounds)
//        imageView.image = backgroundImage
//        imageView.contentMode = .scaleToFill
//        self.view.addSubview(imageView)
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
        guard let videoURL = URL(string: "http://caribbeancinemas.com/img/trailers/6134.mp4") else {
            return
        }
        let videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: [String(kCVPixelBufferPixelFormatTypeKey): NSNumber(value: kCVPixelFormatType_32BGRA)])
        let player = AVPlayer(url: videoURL)
        player.currentItem!.add(videoOutput)
        let controller = AVPlayerViewController()
        controller.player = player
        
        present(controller, animated: true) {
            player.play()
        }
    }
    
    @IBAction func btn2_clicked(_ sender: Any) {
        let menu = Menu(viewcontroler: self)
        menu.show()
    }
    
    let textCountLabel: UILabel = {
        let lb = UILabel()
        lb.text = "0/2000"
        lb.textColor = .lightGray
        lb.sizeToFit()
        return lb
    }()
    
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        var items = [UIBarButtonItem]()
        
////        items.append(
//            UIBarButtonItem(customView: anonymousButton)
//        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        )
        items.append(
            UIBarButtonItem(customView: textCountLabel)
        )
        toolBar.setItems(items, animated: true)
        
        textField.inputAccessoryView = toolBar
    }
    
    
   func textFieldDidChange(textField : UITextField){
        textCountLabel.text = String(describing: textField.text?.characters.count) + "/2000"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        textCountLabel.text =  "11/2000"
        textCountLabel.sizeToFit()
    return true
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
