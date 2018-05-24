//
//  BasicTableViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/8/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

//class BasicTableViewController: UIViewController {

    
class BasicTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
        
    @IBOutlet weak var tableView: UITableView!
    let sections = ["Autobots","Decepticons"]
        var autobotsNames : [String] = []
        var decepticonsNames : [String] = []
    var allTransformersNames = [["How are you","I am fine","how is going"],["Red", "Green"]]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
//            print(Realm.Configuration.defaultConfiguration.fileURL!)
//            let transformers = Transformers()
//            let transformersData =  transformers.TransformersData()
//
//            for data in transformersData {
//                if data.group == "A" {
//                    autobotsNames.append(data.name)
//                }
//                else {
//                    decepticonsNames.append(data.name)
//                }
//            }
//            allTransformersNames.append(autobotsNames)
//            allTransformersNames.append(decepticonsNames)
//
//            print(autobotsNames)
//            print(decepticonsNames)
//            print(allTransformersNames)
            tableView.reloadData()
        }
        
//        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//            print(sections.count)
//            return sections.count
//        }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        print("work", sections.count)
//        return sections.count
//
//    }
//
//        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//            return sections[section]
//        }
//
//        func tableView(_ tableView: UITableView,  numberOfRowsInSection section: Int) -> Int {
//        //    print(self.allTransformersNames[section].count)
//            return self.allTransformersNames[section].count
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            cell.textLabel?.text = self.allTransformersNames[indexPath.section][indexPath.row]
//
//            return cell
//        }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 4
        }else if  section == 1 {
            return 3
        }else{
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        for var i in (0..<indexPath.count).reversed()
        {
            print("test")
            var myTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 340, height: 40))
            myTextField.placeholder = "Enter Email Address \(i)"
            myTextField.backgroundColor = UIColor.brown
            cell.addSubview(myTextField)
            
        }
        return cell
    }
        
}




