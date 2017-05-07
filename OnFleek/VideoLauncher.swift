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
    
    var player : AVPlayer?
    
    let spinner : UIActivityIndicatorView = {
        let sp = UIActivityIndicatorView()
        sp.translatesAutoresizingMaskIntoConstraints = false
        sp.startAnimating()
        
      return sp
    }()
    let controlsContainerView : UIView = {
        let ccv = UIView()
        //ccv.translatesAutoresizingMaskIntoConstraints = false //position not set with constraints
        ccv.backgroundColor = UIColor(white: 0, alpha: 1.0)
        
        return ccv
    }()
    lazy var pausePlayButton:UIButton = {
        let button = UIButton(type: .system)
        //set imge on a uibuton
        let image = UIImage(named: "Pause Filled-50")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    let videoLengthLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont .boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        
      return label
    }()
    
    let currentTimeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont .boldSystemFont(ofSize: 13)
        //label.textAlignment = .right
        
        return label
    }()

    
    
    
   lazy var videoSlider : UISlider = {
        let sl = UISlider()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.minimumTrackTintColor = .red
        sl.maximumTrackTintColor = .white
        sl.setThumbImage(UIImage(named:"New Moon Filled-50"), for: .normal)
    sl.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
     return sl
    }()
    
    
    func handleSliderChange(){
       // print(videoSlider.value)
        //SCRUBBER
        if  let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completionSeek) in
                //
            })
        }
        //
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerView() // this view is now under the controls view
        
        //Adding a Gradient to this view.
        setupGradientLayer()
        
        controlsContainerView.frame = frame ////position not set with constraints 
        addSubview(controlsContainerView)
        addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        //spinner.widthAnchor.constraint(equalToConstant: 40).isActive = true
        //spinner.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        videoSlider.widthAnchor.constraint(equalToConstant: self.frame.width - 136).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        currentTimeLabel.rightAnchor.constraint(equalTo: videoSlider.leftAnchor, constant: -8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        
        
        
        
        backgroundColor = .black
        //"http://techslides.com/demos/sample-videos/small.mp4"
        
    }//
    
    
    
    private func setupPlayerView(){
        
        //https://dwknz3zfy9iu1.cloudfront.net/uscenes_h-264_hd_test.mp4
        
        let urlString = "https://dwknz3zfy9iu1.cloudfront.net/uscenes_h-264_hd_test.mp4"
        
        if let url = NSURL(string: urlString){
            player = AVPlayer(url: url as URL)
            // make the video render - show
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            
            //attach an observer to know when the player starts to play
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            
            //Adding a progress monitor onto the playerview
            //track player progress
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progress) in
                //progress time
                let seconds = CMTimeGetSeconds(progress)
                let arg = seconds.truncatingRemainder(dividingBy: 60)
                let secondsString = String(format: "%02d", Int(arg))
                let minutesString = String(format: "%02d", Int(seconds / 60))
                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                //MOVE THE SLIDER THUMB - GOES FROM 0 - 1 = PERCENTAGE OF WHAT IS PLAYED - currentPlayTime / duration
                
                if let duration = self.player?.currentItem?.duration {
                    //CMTime
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds / durationSeconds)

                }
                
                
                
            })
            
        }
        
    }
    
    /*
     /Users/kev1/Desktop/OnFleek/OnFleek/VideoLauncher.swift:173:34: '%' is unavailable: Use truncatingRemainder instead
 
 */
    //METHOD NEEDED FOR OBSERVER
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //This is when the player is ready and redering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            //print("Change is:", change ?? "")
            spinner.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            // Play state
            isPlaying = true
            //
            //readyForPlayback here
            //LENGTH OF THE VIDEO
            if  let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration) //this is how long the track is.
                
                
                let arg = seconds.truncatingRemainder(dividingBy: 60)
                
                
                let secondsText = String(format: "%02d",Int( arg))
                
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
                
            }
            
        }
    }
    var isPlaying = false //player State flag
    
    func handlePause(){
        //print("Pausing player")
        if isPlaying {
            player?.pause()
            //
            // playButton.isHidden = true
            let image = UIImage(named: "Play Filled-50")
            pausePlayButton.setImage(image, for: .normal)
        } else {
            player?.play()
        }
        
                      // Play state
        isPlaying = !isPlaying
        
        
    }
    
    //MARK:- Gradient
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds //Where the gradient layer starts and ends
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
        
        
    }

    
    
    
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
