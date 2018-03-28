//
//  ViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 3/12/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var tableArray:[String]?
    
    var list:[Feature] = [
        Feature(title: "Social Media", description: "Login with FB, Twitter & Google"),
        Feature(title: "Mapkit", description: "Test Map from google"),
        Feature(title: "Json Test", description: "Json model testing"),
        Feature(title: "Photo Lib", description: "Test photo album"),
        Feature(title: "Audio", description: "Record voice")
    ]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        print(myIndex)
    }

    override func viewWillAppear(_ animated: Bool) {
        print(myIndex)
 

        self.getGithubUsers()
    }

    func parseJSON () {
        
        let username = "razibusa"
        let password = "razib1243"
        
        let url = NSURL(string: "https://api.github.com/user")
        let request = NSMutableURLRequest(url: url! as URL)
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            //   println("Response: \(response)")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(String(describing: strData))")
            var _: NSError?
            let json2 = try! JSONSerialization.jsonObject(with: (strData?.data(using: String.Encoding.utf8.rawValue))!, options: .mutableLeaves ) as! NSDictionary
            
            print("json2 :\(json2)")
            
            if((error) != nil) {
                print(error!.localizedDescription)
            }
            else {
                let success = json2["success"] as? Int
                print("Succes: \(String(describing: success))")
            }
        })
        
        task.resume()
    }
    
    func getGithubUsers(){
        let url = URL(string: "https://api.github.com/users")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error ) in
            
            guard error == nil else {
                print("returned error")
                return
            }
            
            guard let content = data else {
                print("No data")
                return
            }
            
             let json = try! JSONSerialization.jsonObject(with: content,
                                                                options: JSONSerialization.ReadingOptions.mutableContainers)
            
            
            print(json)
            
        }
        
        task.resume()
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
        if indexPath.item == 1 {
            let storyboard = UIStoryboard(name: "StoryboardMap", bundle: nil)
            let mapVC:MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController_ID") as! MapViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
            
        } else if indexPath.item == 2 {

                let storyboard = UIStoryboard(name: "Storyboard_json", bundle: nil)
                let mapVC:JsonTestViewController = storyboard.instantiateViewController(withIdentifier: "JsonTestViewController_ID") as! JsonTestViewController
                let naviController = UINavigationController(rootViewController: mapVC)
                self.present(naviController, animated: true, completion: nil)
                
        }else if indexPath.item == 3 {

            let storyboard = UIStoryboard(name: "Storyboard_PH", bundle: nil)
            let mapVC:AlbumsViewController = storyboard.instantiateViewController(withIdentifier: "AlbumsViewController_ID") as! AlbumsViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)

        }
        else if indexPath.item == 4 {
            let storyboard = UIStoryboard(name: "audio", bundle: nil)
            let mapVC:AudioViewController = storyboard.instantiateViewController(withIdentifier: "AudioViewController_ID") as! AudioViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
        }
    }
    
    
}
