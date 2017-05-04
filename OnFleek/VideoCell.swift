//
//  VideoCell.swift
//  OnFleek
//
//  Created by Kev1 on 4/26/17.
//  Copyright © 2017 Kev1. All rights reserved.
//

import UIKit


class VideoCell: BaseCell {
    //
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
    //Cell Image View
    
    var video : Video? {
        didSet{
            //setting the current video
            titleLabel.text = video?.title //setting the current title for the video cell now correct title will show 
            
            
            setupThumNailImage() // this for the aPI
            
            //thumbnailImageView.image = UIImage(named :(video?.thumbNailImageName)!) // now the image amd name is set
            //getting rid of the bang
//            if let thumbnailImageName = video?.thumbNailImageName {
//                thumbnailImageView.image = UIImage(named: thumbnailImageName)
//            }

            
            
            //subTitleTextView.text = video?.subTitle
            //getting rid of the bang!
            
            //userProfileImageView.image = UIImage(named :(video?.channel?.profileImageName)!)
            
            setupProfileImage()
//            if let profileImageName = video?.channel?.profileImageName {
//                userProfileImageView.image = UIImage(named: profileImageName)
//            }
            
            //String interpolation
            //let subtitleText = "\(video?.channel?.name) • \(video?.numberOfViews) • 2 years ago"
            //subTitleTextView.text = subtitleText
            //getting rid of the optionals
            
            //getting the commas
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views {
                //get the optonal removed
                if let formattedNumber = numberFormatter.string(from: numberOfViews) {
                    subTitleTextView.text = "\(channelName) • \(formattedNumber) • 2 years ago"
                }
                
            }
            
            //
            
            
            
            //measure the title text
            if let videoTitle = video?.title {
                
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                
                //gives us the estimated rect of the size of the entire text
                let estimatedRect = NSString(string: videoTitle).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 16)], context: nil)
                //print(estimatedRect.size.height)
                
                
                if estimatedRect.size.height > 20 {
                    titleHeightConstraint?.constant = 44
                   // print("set to 44")
                } else {
                    titleHeightConstraint?.constant = 20
                   // print("set to 20")
                }
                
            }
            
            
        }
        
    }//Model
    
    func setupProfileImage() {
        if let profileImageURL = video?.channel?.profile_image_name {
            
           userProfileImageView.loadImageUsingURLString(URLString: profileImageURL)
            //redundancy
            
        }
        
    }
    
    
    
    func setupThumNailImage() {
        if let thumbnailImageURL = video?.thumbnail_image_name {
            thumbnailImageView.loadImageUsingURLString(URLString: thumbnailImageURL)
            
            //redundancy
                     
        }
        
    }

    
    
    
    
    let thumbnailImageView : CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Music Video-50")
        //imageView.contentMode = .scaleAspectFill
        //imageView.backgroundColor = .blue
        
        return imageView
        
    }()
    
    let separatorView : UIView = {
        let sv = UIView()
        //sv.backgroundColor = .black
        sv.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let userProfileImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 22
        iv.layer.masksToBounds = true //makes the circle
        iv.clipsToBounds = true //stops the imge from growing too big
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "taylor-swift-profile")
        //iv.backgroundColor = .green
        
        return iv
    }()
    
    //Title Lable
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift . Blank Space"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        //label.backgroundColor = .red
        return label
    }()
    
    let subTitleTextView : UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        let bulletPoint: String = "\u{2022}"
        tv.text = "TaylorSwiftVEVO • 1,684,607 views • 2 years ago • Very popular"
        //tv.backgroundColor = .purple
        //line up textView with the label. Text iew has an inherant 4 pix offset
        tv.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        tv.textColor = .lightGray
        return tv
    }()
    
    
    var titleHeightConstraint : NSLayoutConstraint?
    var subtitleHeightConstraint : NSLayoutConstraint?
    
    override func setupViews(){
        // backgroundColor = .blue
        self.addSubview(thumbnailImageView)
        self.addSubview(separatorView)
        self.addSubview(userProfileImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleTextView)
        
        //thumbnailImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        //x,y,width,height
        thumbnailImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32).isActive = true
        //thumbnailImageView.bottomAnchor.constraint(equalTo: self.userProfileImageView.topAnchor, constant: -8).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -84).isActive = true
        
        
        //x,ywidth,height
        separatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        separatorView.centerYAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        userProfileImageView.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor).isActive = true
        userProfileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //
        titleLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 4).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -84).isActive = true
        //
        titleHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 20)
        titleHeightConstraint?.isActive = true
        
        
        //////////////
        
        subTitleTextView.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        subTitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        subTitleTextView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -84).isActive = true
        //
        subtitleHeightConstraint = subTitleTextView.heightAnchor.constraint(equalToConstant: 30)
        subtitleHeightConstraint?.isActive = true
    }
    
    
    
    }



