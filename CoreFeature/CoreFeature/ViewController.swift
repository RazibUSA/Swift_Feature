//
//  ViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 3/12/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{
    
    var tableArray:[String]?
    
    var list:[Feature] = [
        Feature(title: "Social Media", description: "Login with FB, Twitter & Google"),
        Feature(title: "Mapkit", description: "Test Map from google"),
        Feature(title: "Json Test", description: "Json model testing"),
        Feature(title: "Photo Lib", description: "Test photo album"),
        Feature(title: "Audio", description: "Record voice"),
        Feature(title: "Test", description: "Various... "),
        Feature(title: "Page", description: "Test... "),
        Feature(title: "PDF", description: "web... "),
        Feature(title: "AVPlayer", description: "Test seek... "),
        Feature(title: "Table", description: "Test seek... "),
        Feature(title: "Pull to refresh", description: "Search seek... "),
        Feature(title: "Search", description: "Search seek... "),
        Feature(title: "Text Field", description: "Search seek... "),
        Feature(title: "Progress", description: "Progress Menu View... "),
        Feature(title: "Picker Test", description: "Picker View... ")
    ]
    
    var isMore:Bool = true
    var totalSteps: Int = 2 {
        didSet {
            
            tableView.reloadData()
            
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        print(myIndex)
    }

    override func viewWillAppear(_ animated: Bool) {
        print(myIndex)
 

       // self.getGithubUsers()
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
        
        cell?.indentationLevel = indexPath.row
        cell?.indentationWidth = 5.0
        
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
        } else if indexPath.item == 5 {
            
            
            let storyboard = UIStoryboard(name: "test", bundle: nil)
            let mapVC:TestViewController = storyboard.instantiateViewController(withIdentifier: "TestViewController_ID") as! TestViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
        } else if indexPath.item == 6 {
            let pvc = PageViewController()
            let naviController = UINavigationController(rootViewController: pvc)
            self.present(naviController, animated: true, completion: nil)
        } else if indexPath.item == 7 {
            
            let storyboard = UIStoryboard(name: "pdf", bundle: nil)
            let mapVC:PdfViewController = storyboard.instantiateViewController(withIdentifier: "PdfViewController_ID") as! PdfViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
        } else if indexPath.item == 8{
            let storyboard = UIStoryboard(name: "audio", bundle: nil)
            let mapVC:AVPlayerViewController = storyboard.instantiateViewController(withIdentifier: "AVPlayerViewController_ID") as! AVPlayerViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
        }
        else if indexPath.item == 9{
            let storyboard = UIStoryboard(name: "table", bundle: nil)
            let mapVC:BasicTableViewController = storyboard.instantiateViewController(withIdentifier: "BasicTableViewController_ID") as! BasicTableViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
        }else if indexPath.item == 10{
            let storyboard = UIStoryboard(name: "search", bundle: nil)
            let mapVC:RefreshViewController = storyboard.instantiateViewController(withIdentifier: "RefreshViewController_ID") as! RefreshViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
        } else if indexPath.item == 11{
            let storyboard = UIStoryboard(name: "search", bundle: nil)
            let mapVC:SearchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController_ID") as! SearchViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
        } else if indexPath.item == 12 {
            let storyboard = UIStoryboard(name: "form", bundle: nil)
            let mapVC:ValidatorTestViewController = storyboard.instantiateViewController(withIdentifier: "ValidatorTestViewController_ID") as! ValidatorTestViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
        } else if indexPath.item == 13 {
            let storyboard = UIStoryboard(name: "progress", bundle: nil)
            let mapVC:ProgressViewController = storyboard.instantiateViewController(withIdentifier: "ProgressViewController_ID") as! ProgressViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
        } else if indexPath.item == 14 {
            let storyboard = UIStoryboard(name: "picker", bundle: nil)
            let mapVC:PickerTableViewController = storyboard.instantiateViewController(withIdentifier: "PickerTableViewController_ID") as! PickerTableViewController
            let naviController = UINavigationController(rootViewController: mapVC)
            self.present(naviController, animated: true, completion: nil)
        }
        
    }
    
//    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
//        print((indexPath.row % 9) * 10)
//        return (indexPath.row % 9) * 10
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//       print(indexPath.row)
//
//        if indexPath.row == totalSteps - 1 {
//            print("RRRRR")
//            isMore = !isMore
//            if(isMore) {
//                self.totalSteps = self.totalSteps + 2
//            }
//
//        }
//
//    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("I'm scrolling!")
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
//        
//        cell.CellView.layer.cornerRadius = cell.CellView.frame.height / 2
//        cell.Label.text = Dwarves[indexPath.row]
//        cell.CharcterImage.image = UIImage(named: imagess[indexPath.row])
//        cell.CharcterImage.layer.cornerRadius = cell.CharcterImage.frame.height / 2
//        
//        cell.indentationLevel = indexPath.row
//        cell.indentationWidth = 5.0
//        
//        return cell
//    }
    
    
}
