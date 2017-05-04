//
//  SafeJsonObject.swift
//  OnFleek
//
//  Created by Kev1 on 5/4/17.
//  Copyright © 2017 Kev1. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        //
        //stops app from crashing (when calling super setValue) if parameter in json file is added later AND NOT IN YOUR MODEL OBJECTS
        let uppercaseFirstCharacter = key.firstCharacterUppercased //My string extension
        // range
        let start = key.index(key.startIndex, offsetBy: 0)
        let end = key.index(key.endIndex, offsetBy: 0)
        let range = start..<end
        // let r =  key[range]  // play
        let selectorString = key.replacingCharacters(in:range, with: uppercaseFirstCharacter)
        //print(selectorString)
        
        //number_of_likes
        //let selector = NSSelectorFromString("setTitle:")// if there is a "title" parameter in video file responds = true
        let selector = NSSelectorFromString("set\(selectorString):") //if there is no number_of_likes: parameter in video file responds responds ? true : false
        let responds = self.responds(to: selector)
        
        //key check for extra parameter NOT in video class //https://www.youtube.com/watch?v=11aHute59QQ&list=PL0dzCUj1L5JGKdVUtA5xds1zcyzsz7HLj&index=15  //25:01
        
        
        if !responds {
            return //get out OF THE SETTER CHAIN
        }
        
        super.setValue(value, forKey: key)

    }

}
