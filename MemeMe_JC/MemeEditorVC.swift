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
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    let imagePicker = UIImagePickerController()
    
    //MARK: - UIViewController functions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            cameraButton.enabled = true
        } else {
            cameraButton.enabled = false
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func cameraPressed(sender: UIBarButtonItem) {
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion:nil)
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

