//
//  SubsscriptionCell.swift
//  OnFleek
//
//  Created by Kev1 on 5/3/17.
//  Copyright © 2017 Kev1. All rights reserved.
//

import UIKit

class SubsscriptionCell: FeedCell {
    
    override func fetchVideos() {
        //
        ApiService.sharedInstance.fetchSubscriptionsFeed{ (videos: [Video]) in
            self.videos = videos //load up from the completion block// this is set inside the feedCell, the super cell. BECVAUSE WHEN YOU SUBCLASS A CLASS YOU GET ALL THE FUNCTIONALITY OF THE ORIGNAL CLASS.(OOP - OBJECT ORIENTED PROGRAMMING - THE ADVANTAGES OF SUBCLASSING - THE MAGIC OF SUBCLASSING)
            self.collectionView.reloadData()
        }

        
    }

   
}
