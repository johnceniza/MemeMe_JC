//
//  MemeSentCollectionVC.swift
//  MemeMe_JC
//
//  Created by John Ceniza on 7/24/15.
//  Copyright (c) 2015 AppDeco. All rights reserved.
//

import UIKit

class MemeSentCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //instantiate and array of Meme objects
    var memeArray = [Meme]()
    
    override func viewDidLoad() {
        //register for device orientation notification so that we can adjust the insets accordingly (based on nav bar height, status bar height and tab bar height)
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChange:", name: UIDeviceOrientationDidChangeNotification, object: UIDevice.currentDevice())
        adjustInsets()
    }
    
    override func viewWillAppear(animated: Bool) {
        //set memeArray to the AppDelegate array of memes
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memeArray = appDelegate.memesArray
        collectionView?.reloadData()
    }

    //determine correct number of items for a single collection view section
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    //load and populate custom cell with meme image and captions using indexPath to determine proper object in array to show
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! customCollectionCell
        cell.mainImage.image = memeArray[0].finalMemeImage
        cell.topLabel.text = memeArray[0].topText
        cell.bottomLabel.text = memeArray[0].bottomText

        // Configure the cell
        return cell
    }
    
    //properly size each collection view cell so that it is user friendly and presentable
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let frame:CGRect = self.view.frame
        return CGSizeMake(frame.width/3, frame.width/3)
    }
    
    //specify line spacing between rows or columns of a section
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    //handle transition upon selection of cell and pass proper meme object to detail view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gridToDetailSegue" {
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView!.indexPathForCell(cell)
            let row = indexPath?.row
            
            let detailView:MemeDetailVC = segue.destinationViewController as! MemeDetailVC
            detailView.memeImage = (memeArray[Int(row!)].finalMemeImage)
            detailView.index = Int(row!)
            detailView.selectedMeme = memeArray[Int(row!)]
        }
    }
    
    //quick function to get current height of status bar programatically - returns the min between width and height of status bar b/c width vs height varies with orientation but safe to assume that height will always be less
    func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.sharedApplication().statusBarFrame.size
        return Swift.min(statusBarSize.width, statusBarSize.height)
    }
    
    //function called when orientation changes - no need for switch statement since the system takes care of nav bar size and status bar size so we just call adjustInsets
    func orientationChange(notification: NSNotification) {
        adjustInsets()
    }
    
    //set collection view inset and take into account for nav bar, status bar and tab bar
    func adjustInsets() {
        self.collectionView?.contentInset = UIEdgeInsetsMake(self.navigationController!.navigationBar.frame.height+self.statusBarHeight(),-1,self.tabBarController!.tabBar.frame.height,-1)
    }
}
