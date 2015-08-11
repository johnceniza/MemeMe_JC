//
//  MemeSentTableVC.swift
//  MemeMe_JC
//
//  Created by John Ceniza on 7/24/15.
//  Copyright (c) 2015 AppDeco. All rights reserved.
//

import UIKit

class MemeSentTableVC: UITableViewController {
    
    //instantiate and array of Meme objects
    var memeArray = [Meme]()
    
    override func viewWillAppear(animated: Bool) {
        //set memeArray to the AppDelegate array of memes
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memeArray = appDelegate.memesArray
        tableView.reloadData()
    }
    
    //determine correct number of rows for table view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeArray.count
    }
    
    //return custom row height for best appearance and experience
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    //populate row with meme image and captions using indexPath to determine proper object in array to show
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("memeCell") as! UITableViewCell
        cell.textLabel?.text = memeArray[indexPath.row].topText + " " + memeArray[indexPath.row].bottomText
        cell.imageView?.image = memeArray[indexPath.row].image
        return cell
    }
    
    //handle row selection and pass proper meme object to detail view
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
