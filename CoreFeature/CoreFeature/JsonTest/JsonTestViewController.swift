//
//  JsonTestViewController.swift
//  CoreFeature
//
//  Created by Razib Mollick on 3/17/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit
import AVFoundation
import HealthKit
import HealthKitUI

class JsonTestViewController: UIViewController {
    
    @IBOutlet weak var playBtn: UIButton!
    var songPlayer = AVAudioPlayer()
  //  var player = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()

    //  makePostCall()
        
        playBtn.isEnabled = false
        playBtn.setImage(UIImage.init(named:"car_top"), for: .disabled)
        playBtn.tintColor = UIColor.blue
        
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
        
   //tailtoddle_lo4.mp3")
  //player.play()
//        getExerciseTime(){ time in
//            print(time)
//
//        }
        
        loadM4a()
    }
    
   
    
    
    
    func loadM4a(){
        if let audioUrl = URL(string: "http://soundexpert.org/documents/10179/13123/se_ref4warp_FULL_08.m4a") {
            
            downloadSound(url: audioUrl)
            //then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            
            //let url = Bundle.main.url(forResource: destinationUrl, withExtension: "mp3")!
    //        print(destinationUrl.path)
            do {
//                let audioPlayer = try AVAudioPlayer(contentsOf: destinationUrl)
//                 player = audioPlayer
//                player.prepareToPlay()
               
            } catch let error {
                print(error.localizedDescription)
            }
        }

    }
    
    @IBAction func playdownload(_ sender: Any) {
        

            //Bundle.main.url(forResource: "tailtoddle_lo4", withExtension: "mp3")!
         //  let musicPath =  Bundle.main.path(forResource: "tailtoddle_lo4.mp3", ofType: nil)
            
        
            
      songPlayer.play()
        
       // }
    }
    
    var player = AVAudioPlayer()
    func downloadSound(url:URL){
        let docUrl:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let desURL = docUrl.appendingPathComponent("tmpsong.m4a")
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URLData, response, error) -> Void in
            do{
                let isFileFound:Bool? = FileManager.default.fileExists(atPath: desURL.path)
                if isFileFound == true{
                      print(desURL) //delete tmpsong.m4a & copy
                } else {
                    try FileManager.default.copyItem(at: URLData!, to: desURL)
                }
                let sPlayer = try AVAudioPlayer(contentsOf: desURL)
                self?.player = sPlayer
                self?.player.prepareToPlay()
                self?.player.play()

            }catch let err {
                print(err.localizedDescription)
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
    
    //    DispatchQueue.global().async {
    
    
//    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//    let documentDirectoryPath:String = path[0]
//    let fileManager = FileManager()
//    let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath.appendingFormat("/song.mp3"))
//
//    // then lets create your document folder url
//    let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//    // lets create your destination file url
//    let destinationUrl = documentsDirectoryURL.appendingPathComponent((URL1?.lastPathComponent)!)
//    print(destinationUrl)
//
//    if fileManager.fileExists(atPath: destinationUrl.path){
//    self?.showFileWithPath(url: destinationUrl)
//    print(destinationUrl.path)
//    }
//    else{
//    do {
//    try FileManager.default.moveItem(at: URL1!, to: destinationUrl)
//    // show file
//    self?.showFileWithPath(url: destinationUrl)
//    }catch let error{
//    print("An error occurred while moving file to destination url", error.localizedDescription)
//    }
//    }
    
//    let renameURL = URLData?
//        .deletingPathExtension()
//        .appendingPathExtension("m4a")
//    print(renameURL)
    
    
}



extension JsonTestViewController : XMLParserDelegate {
    
}
