//
//  Video.swift
//  OnFleek
//
//  Created by Kev1 on 4/27/17.
//  Copyright © 2017 Kev1. All rights reserved.
//
//  Model object representing an entire cell. telssthe cell view what to rendered

//  // Its A dictionary. lets contruct the video object from the json file

//[ means its an array fron json pretty print] http://jsonprettyprint.com
/*
 (
 {
 channel =         {
 name = "Taylor Fan Forever";
 "profile_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_fan_forever_profile.jpg";
 };
 duration = 210;
 "number_of_views" = 319644991;
 "thumbnail_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_swift_i_knew_you_were_trouble.jpg";
 title = "Taylor Swift - I Knew You Were Trouble (Exclusive)";
 },
 {
 channel =         {
 name = "Rihanna's Channel";
 "profile_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/rihanna_profile.jpg";
 };
 duration = 189;
 "number_of_views" = 92839921;
 "thumbnail_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/rihanna_work.jpg";
 title = "Rihanna Work featuring Drake";
 },
 {
 channel =         {
 name = "Taylor Fan Forever";
 "profile_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/beyonce_profile.jpg";
 };
 duration = 410;
 "number_of_views" = 52321223;
 "thumbnail_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/beyonce_put_a_ring_on_it.jpg";
 title = "Beyonce - Put A Ring On It";
 },
 {
 channel =         {
 name = KanyeLover;
 "profile_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/kanye_profile2.jpeg";
 };
 duration = 80;
 "number_of_views" = 9999999999999;
 "thumbnail_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/kanye-interupts-taylor-zoom.jpg";
 title = "Kanye Interrupts Taylor Embarrassing Video";
 },
 {
 channel =         {
 name = "Rebecca Black's Awesome";
 "profile_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/rebecca_black_profile.jpeg";
 };
 duration = 232;
 "number_of_views" = 12312344;
 "thumbnail_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/rebecca_black_friday.jpg";
 title = "Rebecca Black - Friday";
 },
 {
 channel =         {
 name = JohnTheLegend;
 "profile_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/john_legend_profile.jpeg";
 };
 duration = 301;
 "number_of_views" = 334435123;
 "thumbnail_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/john_legend_all_of_me.jpg";
 title = "John Legend - All Of Me";
 }
 )

 
 
 */
/*
 /Users/kev1/Desktop/OnFleek/OnFleek/Video.swift:119:58: Cannot convert value of type 'ClosedRange<String.Index>' (aka 'ClosedRange<String.CharacterView.Index>') to expected argument type 'Range<String.Index>' (aka 'Range<String.CharacterView.Index>')
 
 */
extension String {
    var firstCharacterUppercased: String {
        guard case let c = self.characters,
            let c1 = c.first else { return self }
        return String(c1).uppercased() + String(c.dropFirst())
    }
}



import Foundation
//SUBCLASSING OOPS

class Video: SafeJsonObject {
    var thumbnail_image_name : String? //belongs to the video
    var title : String? //belongs to the video
    
    
    var number_of_views : NSNumber? //belongs to the video
    
    var uploadDate : NSDate? //belongs to the video
    
    var duration : NSNumber?
    
    var channel : Channel? //the video has a relationship with channel is the owner of this video. the video knows which channel it belongs to //belongs to the video
    
    // THIS IS EXECUTED EVERYTIME A VALUE IS SET WITH A KEY/ VALUE
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        if key == "channel" {
            //custom setup
            //let channelDictionary = value as! [String:AnyObject]
            self.channel = Channel()
            
            channel?.setValuesForKeys(value as! [String:AnyObject])
            
            
            //video.channel = channel
         //   self.channel = channel
            
            
        } else {
            //if its any other key
            super.setValue(value, forKey: key)
                      
        }
           }
    
    init(dictionary : [String : Any]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
    
    
}

//Second model object for youtube. tons of channels, each channel has many videos
//SUBCLASSING OOPS
class Channel: SafeJsonObject {
    //channel name
    var name: String? //subtitle text belongs to the channel
    var profile_image_name : String? // profile image name of the channel
    
    
    
}
