//
//  TrendingCell.swift
//  OnFleek
//
//  Created by Kev1 on 5/3/17.
//  Copyright © 2017 Kev1. All rights reserved.
//

/*
 [
 {
 "title": "Everything Wrong with Zootopia",
 "number_of_views": 319644991,
 "thumbnail_image_name": "https:\/\/s3-us-west-2.amazonaws.com\/youtubeassets\/zootopia.png",
 "channel": {
 "name": "CinemaSins",
 "profile_image_name": "https:\/\/s3-us-west-2.amazonaws.com\/youtubeassets\/taylor_fan_forever_profile.jpg"
 },
 "duration": 210
 },
 {
 "title": "Kanye West Keepin' It Real",
 "number_of_views": 762630652,
 "thumbnail_image_name": "https:\/\/s3-us-west-2.amazonaws.com\/youtubeassets\/kanye-west-ellen-degeneres.jpg",
 "channel": {
 "name": "CinemaSins",
 "profile_image_name": "https:\/\/s3-us-west-2.amazonaws.com\/youtubeassets\/taylor_fan_forever_profile.jpg"
 },
 "duration": 223
 }
 ]
 
 */

import UIKit

class TrendingCell: FeedCell {
    
    //if this method is inclued the one in FeedCell will not be called in item 1 second set. A different feed is now activated
    //getting the trending feed
    override func fetchVideos() {
        //
        ApiService.sharedInstance.fetchTrendingFeed { (videos: [Video]) in
            self.videos = videos //load up from the completion block// this is set inside the feedCell, the super cell. BECVAUSE WHEN YOU SUBCLASS A CLASS YOU GET ALL THE FUNCTIONALITY OF THE ORIGNAL CLASS.(OOP - OBJECT ORIENTED PROGRAMMING - THE ADVANTAGES OF SUBCLASSING - THE MAGIC OF SUBCLASSING)
            self.collectionView.reloadData()
        }
        
    }

   
}
