//
//  VideoLauncher.swift
//  OnFleek
//
//  Created by Kev1 on 5/4/17.
//  Copyright © 2017 Kev1. All rights reserved.
//

import UIKit
import AVFoundation
//alot in here so make it a first class citezen
class VideoPlayerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        // Add the player
       // let urlString = ""
       // let player = AVPlayer(url: <#T##URL#>)
    }//
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer(){
        print("Showing video player animation......")
        //Add a view into the key-window of the application with aframe of the entire application
        //get a key window since we are in an nsobject - no views
        //keywindow hold everything inside an application
        //IN ORDER TO ANIMATE IT WE NEED A BEGINFRAME AND AN ENDFRAME
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white //get the keyWindow and the View. add video player view in here
            
            view.frame = CGRect(x: keyWindow.frame.width - 20, y: keyWindow.frame.height - 10, width: 10, height: 10)//bottom right BEGINFRAME
            //what is the frame of the blackView
            
            //16 * 9 is the ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            //Animate it tyo endframe
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                view.frame = keyWindow.frame
                
            }, completion: { (completedAnimation) in
                //maybe we will do something here later
                //hide the status bar
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
                
                
            })
        }
        
        
        
        
    }
    
}
