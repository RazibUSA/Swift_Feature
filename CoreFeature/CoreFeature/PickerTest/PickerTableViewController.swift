//
//  PickerTableViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/22/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class PickerTableViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    @IBOutlet weak var eduField: UITextField!
    var education = ["Middle School Education", "High School Education", "College Education"]
    var eduPicker = UIPickerView()
    
    @IBOutlet weak var associate: UIButton!
    @IBOutlet weak var master: UIButton!
    @IBOutlet weak var greenSwitch: UISwitch!
    @IBOutlet weak var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   eduPicker.delegate = self
    //    eduPicker.dataSource = self
        eduField.inputView = eduPicker
    }
    
    @IBAction func switchColor(_ sender: Any) {
        if (sender as! UISwitch).isOn {
            
        }else{
            colorView.backgroundColor = .black
        }
    }
    
    
    func setUpButton() {
        if eduField.text == "College Education"{
            associate.isHidden = false
            //   bachelor.isHidden = false
            master.isHidden = false
        }
        else{
            associate.isHidden = true
            //   bachelor.isHidden = true
            master.isHidden = true
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpButton()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return education.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eduField.text = education[row]
        eduField.resignFirstResponder()
//        if eduField.text == "College Education"{
//            associate.isHidden = false
//            //   bachelor.isHidden = false
//            master.isHidden = false
//        }
//        else{
//            associate.isHidden = true
//            //   bachelor.isHidden = true
//            master.isHidden = true
//        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return education[row]
    }
}
