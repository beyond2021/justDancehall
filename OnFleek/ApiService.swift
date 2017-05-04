//
//  ApiService.swift
//  OnFleek
//
//  Created by Kev1 on 5/1/17.
//  Copyright © 2017 Kev1. All rights reserved.
//FUNCTION CALL THAT FETCH DATA DOES NOT BELONG IN YOUR CONTROLLER FILE


/*
 
 
 let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
 // print(json) // Its A dictionary. lets contruct the video object from the json file
 //CONSTRUCT THE VIDEO ARRAY HERE
 var videos = [Video]() // adjusted for the completion block
 
 //LOOP THRU THE ENTIRE JSON OBJECT DICTIONARY RECEIVED. MEANS WE ARE DOWNCASTION THE JSON RECEIVED AS AN ARRAY OF DICTIONARIES
 for dictionary in json as! [[String : AnyObject]] {
 //get title of dictionaries
 //print(dictionary["title"] ?? "No Titles")
 //NOW LETS CONSTUCT OUR VIDEO OBJECT IN THIS LOOP
 
 let video = Video() //new video object
 video.title = dictionary["title"] as! String?
 video.thumbNailImageName = dictionary["thumbnail_image_name"] as! String?
 
 //SETUP A CHANNEL DICTIONARY
 let channelDictionary = dictionary["channel"] as! [String:AnyObject]
 let channel = Channel()
 channel.name = channelDictionary["name"] as? String
 channel.profileImageName = channelDictionary["profile_image_name"] as? String
 
 video.channel = channel
 
 
 //self.videos?.append(video) // now we have the entire video array
 videos.append(video)
 
 }
 
 DispatchQueue.main.async( execute: {
 //after looping thru everything call reload data
 // self.collectionView?.reloadData() //bug if not on the main thread
 //CALL THE COMPLETION BLOCK HERE
 completion(videos)
 
 })
 
 
 
 
 //                   var videos = [Video]() // adjusted for the completion block
 
 //                    for dictionary in jsonDictionaries  {
 //
 //
 //                        let video = Video(dictionary: dictionary) //new video object
 //
 //                        videos.append(video)
 //
 //
 //
 //                    }
 
 
 //   let videos = jsonDictionaries.map({return Video(dictionary: $0)})
 

 
 */

import UIKit

class ApiService: NSObject {
    //singleton
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets" //to make the service interchangable
    //completion:([Video]) -> ()  //added
    
    
    func fetchVideos(completion:@escaping ([Video]) -> ()){
        /*
        let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        fetchFeedForUrlString(urlString: urlString) { (videos) in
            // completion with the video array
            completion(videos)
        }
 */
        
        /*
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json") { (videos) in
            // completion with the video array
            completion(videos)
        }
 */
        //A BETTER WAY TO USE THE COMPLETION BLOCK BY PASSING IT IN.
       // fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
        
  
         fetchFeedForUrlString(urlString: "\(baseUrl)/home_num_likes.json", completion: completion)
        //CRASH - this class is not key value coding-compliant for the key number_of_likes.'
    }
    
    // "https://s3-us-west-2.amazonaws.com/youtubeassets/home_num_likes.json"
    
    //
    func fetchTrendingFeed(completion:@escaping ([Video]) -> ()){
        
        
        //let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json"
        
        /*
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json") { (videos) in
            // completion with the video array
            completion(videos)
        }
 */
        
        //A BETTER WAY TO USE THE COMPLETION BLOCK BY PASSING IT IN.
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)

        
        
    }
    
    //
    
    func fetchSubscriptionsFeed(completion:@escaping ([Video]) -> ()){
       // let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json"
        
        /*
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json") { (videos) in
            // completion with the video array
            completion(videos)
        }
 */
        
        //A BETTER WAY TO USE THE COMPLETION BLOCK BY PASSING IT IN.
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)

        
        
        
    }
    
    // TO STOP THE DUPLICATION. THE ONLY DIFFERENCE IS THE URLSTRING SO LETS PUT IT IN THE PARAMETER
    func fetchFeedForUrlString(urlString : String, completion:@escaping ([Video]) -> ()) {
        
        let url = URL(string:urlString)
        // 1: fire off a nsurlSession
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //these 3 parameters (data, response, error) are completed when the service returns from the json request
            
            if error != nil {
                print(error ?? "the request from the server ran into an error")
                return //immediately exit out
            }
            
            //SUCCESS MEAN THAT THE DATA IS GOOD ENOUGH TO START PROCESSING
            //            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) //HOW TO CONSTRUCT THE STRING OF THE DATA RECEIVED FROM THE API SWIFT 3
            //            print(str ?? "")
            
            //LETS USE A JSON PARSER TO MAKE SENSE OF THE STR
            //let json = JSONSerialization.jsonObject(with: data!, options: .mutableContainers) //can throw
            
            do {
                //REDUCTION 
                //ALL THE SETTINGS DONE IN VIDEO! - SETVALUEFORKEY
                
                //BANG! RELATED
                if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String : AnyObject]]  {
                    DispatchQueue.main.async( execute: {
                        
                        completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                    })
                    
                }
                
                
            } catch let jsonError {
                print(jsonError) //error parsing the json
            }
            
            //NOW WE HAVE THIS JSON OBJECT
            
            }.resume() // add this to kick off the request
        
    }
    
    
}
