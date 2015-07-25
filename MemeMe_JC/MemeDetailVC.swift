//
//  MemeDetailVC.swift
//  MemeMe_JC
//
//  Created by John Ceniza on 7/24/15.
//  Copyright (c) 2015 AppDeco. All rights reserved.
//

import UIKit

class MemeDetailVC: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedMeme: Meme!
    var memeImage: UIImage!
    var index: Int!
    
    override func viewDidLoad() {
        //set imageview image to the memeImage
        imageView.image = memeImage
    }
    
    //MARK: - IB Actions
    
    @IBAction func deletePressed(sender: UIButton) {
        //pop UIAlertView to confirm delete (UIAlertController preferred in iOS 8, but nice to support iOS 7 at least)
        let alert = UIAlertView()
        alert.title = "Delete Meme"
        alert.message = "Are you sure you want to delete this meme?"
        alert.addButtonWithTitle("Yes")
        alert.addButtonWithTitle("No")
        alert.delegate = self
        alert.show()
    }
    
    //MARK: - AlertView Delegates
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            //yes - proceed with delete and go back to table/collection view
            
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memesArray.removeAtIndex(index)
            
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            //no - cancel delete
            alertView.dismissWithClickedButtonIndex(1, animated: true)
        }
    }
    
    //MARK: - Segue Management
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "memeDetailToEdit" {
            let navController: UINavigationController = segue.destinationViewController as! UINavigationController
            let destinationView:MemeEditorVC = navController.viewControllers[0] as! MemeEditorVC
            destinationView.editMeme = selectedMeme
        }
    }
}
