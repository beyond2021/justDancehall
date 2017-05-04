//
//  ViewController.swift
//  OnFleek
//
//  Created by Kev1 on 4/26/17.
//  Copyright © 2017 Kev1. All rights reserved.
//  //FUNCTION CALL THAT FETCH DATA DOES NOT BELONG IN YOUR CONTROLLER FILE
// aALL THE COLLECTIONS VIEWS ARE IN HERE

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //INTRODUCING AN ARRAY OF MODELS(VIDEOS) // MODEL CLASS OF MVC
//    var videos : [Video] = {
//        
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeIsTheBestChannel"
//        kanyeChannel.profileImageName = "kanye_west"
//        //create the very first video
//        var blankSpaceVideo = Video() // as a new video object
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        //blankSpaceVideo.subTitle = "this is Blank Space subtitle"
//        blankSpaceVideo.thumbNailImageName = "TaylorS"
//        blankSpaceVideo.channel = kanyeChannel
//        blankSpaceVideo.numberOfViews = 38888888999
//        
//        var badBloodVideo = Video() // as a new video object
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
//        //badBloodVideo.subTitle = "this is Bad Blood subtitle"
//        badBloodVideo.thumbNailImageName = "taylor-swift-24a"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numberOfViews = 766778888888888
//
//        
//        
//        return[blankSpaceVideo, badBloodVideo] // only shows the same video twice. we have to do somerthing when the video property is set in VideoCell
//        
//        
//        
//    }()
    //FROM REST API
    //var videos : [Video]? // optional because we dont know what it is in the beginning. potentially just nothing
    
    //REST2
//    func fetchVideos() {
//        //USING THE API SERVICE
//        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
//            self.videos = videos //load up from the completion block
//            self.collectionView?.reloadData()
//        }
//        
//        
//    }
    
    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subsriptionCellId = "subsriptionCellId"
    let titles = ["Home", "Phone", "Camera", "Record"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchVideos() // REST 1
        
        //setting the battery color to white
        let titleLabel = UILabel(frame:CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navigationItem.titleView = titleLabel
        titleLabel.text = "  Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        //view.backgroundColor = .red
        //navigationItem.title = "Home"
        
        
        setupCollectionView()
        //Add the menuBar view
        setupMenuBar()
        setupNavBarButtonsOnRight()
        
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0 //Decrease the gap
            
        }
        
        
        
        navigationController?.navigationBar.isTranslucent = false
        collectionView?.backgroundColor = .white
        // register class
        //collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubsscriptionCell.self, forCellWithReuseIdentifier: subsriptionCellId)
        
        
        
        
        
        // Push the collectionView down a bit
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        // Snap in place
        collectionView?.isPagingEnabled = true
        
    }
    
    
    //Right BarButtonItems
    
    func setupNavBarButtonsOnRight(){
        let searchImage = UIImage(named: "Search-50")?.withRenderingMode(.alwaysOriginal)//makes the icon white
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreImage = UIImage(named: "Menu 2 Filled-50")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImage , style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [ moreBarButtonItem, searchBarButtonItem]
        
    }
    //lazy code only called once when settingsLauncher is nil
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
      return launcher
    }()
    
    func handleMore(){
        ////////////////////////////////
        //settingsLauncher.homeController = self //this will make sure its not nil when called from. the happens everytime we hit the more button settingsLauncher
        settingsLauncher.showSettings() //this can be nil by itself
        //THIS IS OW WE PUSH A NEW CONTROLLER ONTO THE STACK
        //showControllerForSettings()
        
    }
    
    //
    func showControllerForSetting(setting: Setting){
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue //
        dummySettingsViewController.view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white] //CHANGING THE TITLE COLOR 
        
        navigationController?.navigationBar.tintColor = .white //setting the back button color
        navigationController?.pushViewController(dummySettingsViewController, animated: true)

        
        
    }
    
    func handleSearch() {
//        print(123)
        scrollToMenuIndex(menuIndex: 2)
        
    }
    //scroll the view while hitting the buttons
    func scrollToMenuIndex(menuIndex:Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        //
        setTitleForIndex(index: menuIndex)
    }
    
    
    private func setTitleForIndex(index:Int){
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
            
        }

        
    }
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.homeController = self //needed so that functions in here from menubar. need LAZY VAR to make SELF accessable
        
       return mb
    }()
    
    private func setupMenuBar(){
     
     
        navigationController?.hidesBarsOnSwipe = true //hides thw
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        //redView.backgroundColor = .blue
        
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        self.view.addSubview(menuBar)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    //HOW DO WE FIND OUT WHERE WE ARE IN THE COLLECTIONVIEWS
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)//collectionView is a scrollview
        //using the x value
        menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / 4 //makes the horizontal bar scroll with the pages
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //view.frame.width
        //print(targetContentOffset.pointee.x / view.frame.width)
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
//        if let titleLabel = navigationItem.titleView as? UILabel {
//            titleLabel.text = "  \(titles[Int(index)])"
//            
//        }
        setTitleForIndex(index: Int(index))
        
        
    }
    //track the scrollView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 // 4 sections
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier : String
        
        
        if indexPath.item == 1 {
            identifier = trendingCellId
        } else if indexPath.item == 2 {
            
            identifier = subsriptionCellId
            
        } else {
            
            identifier = cellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        //cell.backgroundColor = colors[indexPath.item]
        
        return cell
    }
    
    let colors:[UIColor] = [UIColor.blue, UIColor.green, UIColor.gray, UIColor.purple]
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50 )
    }
    
    /*
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        let height = (view.frame.width - 16 - 16) * 9 / 16
        //print(height)
        
        return CGSize(width: view.frame.width, height: height + 16 + 88)//16 = 68 is the vertical spacing differencr
    }
    // Line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
 */
    

}


