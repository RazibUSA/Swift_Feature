//
//  AVPlayerViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/1/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class AVPlayerViewController: UIViewController  {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = URL(string: "https://ia902508.us.archive.org/5/items/testmp3testfile/mpthreetest.mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
//        let playerLayer=AVPlayerLayer(player: player!)
//        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
//        self.view.layer.addSublayer(playerLayer)
        
        playButton = UIButton(type: UIButtonType.system) as UIButton
        let xPostion:CGFloat = 50
        let yPostion:CGFloat = 100
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        
        playButton!.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
        playButton!.backgroundColor = UIColor.lightGray
        playButton!.setTitle("Play", for: UIControlState.normal)
        playButton!.tintColor = UIColor.black
        //playButton!.addTarget(self, action: Selector("playButtonTapped:"), for: .touchUpInside)
        playButton!.addTarget(self, action: #selector(AVPlayerViewController.playButtonTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(playButton!)
        
        //showLoadingView(inViewController: UIViewController, turning: Bool)
        Helper.showLoadingView(inViewController: self, turning: true)
        // Add playback slider
        
//        let playbackSlider = UISlider(frame:CGRect(x:10, y:300, width:300, height:20))
//        playbackSlider.minimumValue = 0
//
//
//        let duration : CMTime = playerItem.asset.duration
//        let seconds : Float64 = CMTimeGetSeconds(duration)
//
//        playbackSlider.maximumValue = Float(seconds)
//        playbackSlider.isContinuous = true
//        playbackSlider.tintColor = UIColor.green
//
//        playbackSlider.addTarget(self, action: #selector(AVPlayerViewController.playbackSliderValueChanged(_:)), for: .valueChanged)
//        // playbackSlider.addTarget(self, action: "playbackSliderValueChanged:", forControlEvents: .ValueChanged)
//        self.view.addSubview(playbackSlider)
//
         NotificationCenter.default.addObserver(self,selector: #selector(AVPlayerViewController.restartVideoFromBeginning),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: nil)
        
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        
        
        
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    
    
    
   
    
    @objc func restartVideoFromBeginning()  {
        print("playing")
        let seconds : Int64 = 0
        let preferredTimeScale : Int32 = 1
        let seekTime : CMTime = CMTimeMake(seconds, preferredTimeScale)
        player?.seek(to: seekTime)
        player?.play()
    }
    
    
    
    
    @objc func playButtonTapped(_ sender:UIButton)
    {
        Helper.showLoadingView(inViewController: self, turning: false)
        if player?.rate == 0
        {
            player!.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            playButton!.setTitle("Pause", for: UIControlState.normal)
        } else {
            player!.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            playButton!.setTitle("Play", for: UIControlState.normal)
        }
    }
    
}


class Helper {
    
    
    static func showLoadingView(inViewController: UIViewController, turning: Bool){
        if(turning){
            let activityIndicator = UIActivityIndicatorView()
           let alertView = UIView(frame: CGRect(x: activityIndicator.frame.origin.x, y: activityIndicator.frame.origin.y , width: 35, height: 35))
            alertView.restorationIdentifier = "myalert"
            
            alertView.backgroundColor = UIColor(displayP3Red: 230, green: 230, blue: 230, alpha: 0.8)
            alertView.layer.cornerRadius = 5
            activityIndicator.center = alertView.center
            inViewController.view.addSubview(alertView)
            activityIndicator.activityIndicatorViewStyle = .gray
            activityIndicator.startAnimating()
            alertView.alpha = 0
            activityIndicator.backgroundColor = UIColor.lightGray
            alertView.center = inViewController.view.center
            
            alertView.addSubview(activityIndicator)
            alertView.transform = CGAffineTransform.init(scaleX: 1.3,y: 1.3)
            UIView.animate(withDuration: 0.4) {
                alertView.alpha = 1
                alertView.transform = CGAffineTransform.identity
            }
        }
            ///////
        else {
            
            for view in inViewController.view.subviews {
                if (view.restorationIdentifier == "myalert") {
                    print("I FIND IT");
                    (view as! UIView).removeFromSuperview();
                }
            }
            
        }
    }
    
}

