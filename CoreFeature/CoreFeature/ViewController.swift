//
//  ViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 3/12/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var list:[Feature] = [
        Feature(title: "Social Media", description: "Login with FB, Twitter & Google"),
        Feature(title: "Mapkit", description: "Test Map from google")
    ]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBasic")
        cell?.textLabel?.text = list[indexPath.item].title
        cell?.detailTextLabel?.text = list[indexPath.item].description
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let storyboard = UIStoryboard(name: "StoryboardMap", bundle: nil)
            let mapVC:MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController_ID") as! MapViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
            
        }
    }
    
    
}
