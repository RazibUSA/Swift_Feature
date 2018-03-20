//
//  JsonTestViewController.swift
//  CoreFeature
//
//  Created by Razib Mollick on 3/17/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit
import AVFoundation

class JsonTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func runBtnClicked(_ sender: Any) {
        
        let urlStr = URL(string: "http://radio.spainmedia.es/wp-content/uploads/2015/12/tailtoddle_lo4.mp3")
        
        downloadSound(url: urlStr!)
        
    }
    
    func downloadSound(url:URL){
        
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URL1, response, error) -> Void in
            print("The url is \(URL1)")
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print("Successfully downloaded. Status code: \(statusCode)")
            }
            DispatchQueue.global().async {
                
                
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                let documentDirectoryPath:String = path[0]
                let fileManager = FileManager()
                let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath.appendingFormat("/song.mp3"))
                
                if fileManager.fileExists(atPath: destinationURLForFile.path){
                    self?.showFileWithPath(url: destinationURLForFile)
                    print(destinationURLForFile.path)
                }
                else{
                    do {
                        try fileManager.moveItem(at: URL1!, to: destinationURLForFile)
                        // show file
                        self?.showFileWithPath(url: destinationURLForFile)
                    }catch{
                        print("An error occurred while moving file to destination url")
                    }
                }
                
                
                
                
                
                
            }
            
        })
        downloadTask.resume()
    }
    
    func showFileWithPath(url:URL){
        let isFileFound:Bool? = FileManager.default.fileExists(atPath: url.path)
        if isFileFound == true{
            self.playSound(url: url)
        }
        
    }
    
    
    func playSound(url:URL) {
        print("The url is \(url.isFileURL)")
        
       
    
        
        do {
             let playerItem = AVPlayerItem(url: url)
                
            
            let player = try AVPlayer(playerItem: playerItem)
        
        player.play()
        } catch let err {
            print("Error Play", err.localizedDescription)
        }
    }
    
   
    
    
}
