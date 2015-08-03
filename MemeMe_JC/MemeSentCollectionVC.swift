//
//  MemeSentCollectionVC.swift
//  MemeMe_JC
//
//  Created by John Ceniza on 7/24/15.
//  Copyright (c) 2015 AppDeco. All rights reserved.
//

import UIKit

class MemeSentCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //TODO: - add comments test thoroughly review and finalze
    var memeArray = [Meme]()
    
    override func viewWillAppear(animated: Bool) {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memeArray = appDelegate.memesArray
        collectionView?.reloadData()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! customCollectionCell
        cell.mainImage.image = memeArray[indexPath.row].finalMemeImage
        cell.topLabel.text = memeArray[indexPath.row].topText
        cell.bottomLabel.text = memeArray[indexPath.row].bottomText

        // Configure the cell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let frame:CGRect = self.view.frame
        return CGSizeMake(frame.width/3, frame.width/3)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(-1,-1,-1,-1) // margin between cells
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
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
}
