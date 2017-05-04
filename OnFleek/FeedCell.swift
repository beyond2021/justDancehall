//
//  FeedCell.swift
//  OnFleek
//
//  Created by Kev1 on 5/2/17.
//  Copyright © 2017 Kev1. All rights reserved.
// REPRESENTS (SUPER CLASS OFTRENDINDCEEL, SUSCRIPTIONCELL)EACH ONE OF THE SECTIONS PAGES - WE HAVE 4 OF THEM

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func fetchVideos() {
        //USING THE API SERVICE
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos //load up from the completion block
            self.collectionView.reloadData()
        }
        
        
    }

    
    
    
    let cellId = "cellId"
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        //
        cv.dataSource = self
        cv.delegate = self
        
        return cv
        }()

    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        
                //backgroundColor = .brown
        addSubview(collectionView)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView) //left edge to right edge
//        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView) // top to bottom
        
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        //
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        //collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        //collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    var videos : [Video]?
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 5
        //return videos.count //error because it require non optional int
        /*
         //same as below
         if let count = videos?.count {
         return count
         }
         return 0
         */
        //
        
        return videos?.count ?? 0
        
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.row] // done in videocell
        //cell.backgroundColor = .red // cell being rendered 50 x 50 pixels accross the screen
        return cell
    }
    
    //UICollectionViewDelegateFlowLayout for the cell size methods
    
    // dequeueReusableCell calls initWithFrame - setupviews method
    
    //sizing of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //video sizing on the HD on web 1280 / 720 = 1.7, 16/9, 1920/1080 all = 1.777777777777778
        //so 16/9 is the aspect ratio we want
        let height = (self.frame.width - 16 - 16) * 9 / 16
        //print(height)
        
        return CGSize(width: self.frame.width, height: height + 16 + 88)//16 = 68 is the vertical spacing differencr
    }
    // Line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //MARK:- Video player
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123) //Starting point of video player Launch
        let videoLauncher = VideoLauncher()
       videoLauncher.showVideoPlayer()
    }
    
}
