//
//  MemeDetailVC.swift
//  MemeMe_JC
//
//  Created by John Ceniza on 7/24/15.
//  Copyright (c) 2015 AppDeco. All rights reserved.
//

import UIKit

class MemeDetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var memeImage: UIImage!
    
    override func viewDidLoad() {
        imageView.image = memeImage
    }
}
