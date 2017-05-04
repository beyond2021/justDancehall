//
//  Extensions.swift
//  OnFleek
//
//  Created by Kev1 on 4/26/17.
//  Copyright © 2017 Kev1. All rights reserved.
//

import UIKit

extension UIColor {
    //convenient method that returns a color for me.
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat)  -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
}
}

//
//Cache  to stop reloading images
let imageCache = NSCache<AnyObject, AnyObject>() // stops the constant reloading in collectionviews and tableviews. saves cellular charges


class CustomImageView: UIImageView {
    
    var imageURLString : String?
    //
    func loadImageUsingURLString(URLString : String) {
        
        imageURLString = URLString // check below
        
        
        let url = URL(string: URLString)
        
        image = nil
        
        
        // stops the constant reloading in collectionviews and tableviews
        //get the image from the cache if there is one
        if let imageFromCache = imageCache.object(forKey: URLString as AnyObject)  as? UIImage {
            
            self.image = imageFromCache
            return // we return if we find one
        }
        
        
        
        
        
        
        //create another session for the profile image
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            //
            if error != nil {
                print(error ?? "image download error")
                return
            }
            
            //get the main thread to stop the download stutter
            DispatchQueue.main.async( execute: {
                // print("Async2")
                //self.image = UIImage(data: data!) //because i am an imageview
                //everytime im finished loading one of these images im going to store it inside our cache
                
                // stops the constant reloading in collectionviews and tableviews
                let imageToChache = UIImage(data: data!)
                // CHECK FROM ABOVE
                
                if self.imageURLString == URLString {
                  self.image = imageToChache
                    
                }
                
                
                
                // put it in my imge cache
                imageCache.setObject(imageToChache!, forKey: URLString as AnyObject)
                
                
            })
            
            
            
            
            //SUCCESS
            // self.thumbnailImageView.image = UIImage(data: data!)
            
            
        }).resume()
        
        
        
    }

    
    
}


extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
