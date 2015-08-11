//
//  Meme.swift
//  MemeMe_JC
//
//  Created by John Ceniza on 7/24/15.
//  Copyright (c) 2015 AppDeco. All rights reserved.
//

import Foundation
import UIKit

//custom meme struct with convenience init method to set captions and image
struct Meme {
    var topText: String!
    var bottomText: String!
    var image: UIImage!
    var finalMemeImage: UIImage!
    
    init (topTxt: String, bottomTxt: String, img: UIImage, memeImage: UIImage) {
        topText = topTxt
        bottomText = bottomTxt
        image = img
        finalMemeImage = memeImage
    }
}
