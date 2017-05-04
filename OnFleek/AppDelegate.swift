
//Modifying the nav bar
//
//  AppDelegate.swift
//  OnFleek
//
//  Created by Kev1 on 4/26/17.
//  Copyright © 2017 Kev1. All rights reserved.
//

import UIKit
    
    


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Remove Storyboard
        window = UIWindow(frame: UIScreen.main.bounds)
        //make visible
        window?.makeKeyAndVisible()
        //Set the rootViewController to nav controller
        //configure collectionview with flow layout
        let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = .horizontal
        window?.rootViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
        //modifying the nav bar
        UINavigationBar.appearance().barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        //changing the statusbar color to white
        application.statusBarStyle = .lightContent
        
        //set the background for the statusbar
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        statusBarBackgroundView.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31)
        window?.addSubview(statusBarBackgroundView)
        // x,y,width and height
        statusBarBackgroundView.widthAnchor.constraint(equalTo: (window?.widthAnchor)!) .isActive = true
        statusBarBackgroundView.centerXAnchor.constraint(equalTo: (window?.centerXAnchor)!).isActive = true
        statusBarBackgroundView.topAnchor.constraint(equalTo: (window?.topAnchor)!).isActive = true
        statusBarBackgroundView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //get rid of the shadow under the navbar
        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage().forBarMetrics: .Default)
        UINavigationBar.appearance().setBackgroundImage(UIImage(),for: .default)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

