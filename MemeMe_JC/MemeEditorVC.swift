//
//  MemeEditorVC.swift
//  MemeMe_JC
//
//  Created by John Ceniza on 7/21/15.
//  Copyright (c) 2015 AppDeco. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var memeImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    //MARK: - UIViewController functions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: - IBActions
    
    @IBAction func cameraPressed(sender: UIBarButtonItem) {
        //TODO: add code for camera selection
    }
    
    @IBAction func albumPressed(sender: UIBarButtonItem) {
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion:nil)
    }

    @IBAction func sharePressed(sender: UIBarButtonItem) {
        //TODO: add sharing activity view pop up
    }
    
    //MARK: - UIImagePicker delegate functions
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        //user just finished selecting an image - add code to take image and show it on the screen and scale
        
        //TODO: add unrwapping and check dict for UIImage type
        memeImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

