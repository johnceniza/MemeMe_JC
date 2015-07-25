//
//  MemeSentTableVC.swift
//  MemeMe_JC
//
//  Created by John Ceniza on 7/24/15.
//  Copyright (c) 2015 AppDeco. All rights reserved.
//

import UIKit

class MemeSentTableVC: UITableViewController {
    
    var memeArray = [Meme]()
    
    override func viewWillAppear(animated: Bool) {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memeArray = appDelegate.memesArray
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("memeCell") as! UITableViewCell
        cell.textLabel?.text = memeArray[indexPath.row].topText + " " + memeArray[indexPath.row].bottomText
        cell.imageView?.image = memeArray[indexPath.row].image
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "listToDetailSegue" {
            let selectedRow = tableView.indexPathForSelectedRow()!.row
            
            let detailView:MemeDetailVC = segue.destinationViewController as! MemeDetailVC
            detailView.memeImage = (memeArray[selectedRow].finalMemeImage)
            detailView.index = selectedRow
            detailView.selectedMeme = memeArray[selectedRow]
        }
    }
}
