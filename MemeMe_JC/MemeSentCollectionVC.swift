//
//  MemeSentCollectionVC.swift
//  MemeMe_JC
//
//  Created by John Ceniza on 7/24/15.
//  Copyright (c) 2015 AppDeco. All rights reserved.
//

import UIKit

class MemeSentCollectionVC: UICollectionViewController {

    var memeArray = [Meme]()
    
    override func viewWillAppear(animated: Bool) {

    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        // Configure the cell
        return cell
    }
    
}
