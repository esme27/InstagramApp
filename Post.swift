//
//  Post.swift
//  Instagram Parse
//
//  Created by KaKin Chiu on 3/5/16.
//  Copyright © 2016 KaKinChiu. All rights reserved.
//

import UIKit
import Parse


class Post: NSObject {
    /**
     * Other methods
     */
     
     /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}


//class UserMedia: NSObject {
//    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
//        // Create Parse object PFObject
//        let media = PFObject(className: "UserMedia")
//        
//        // Add relevant fields to the object
//        media["media"] = getPFFileFromImage(image) // PFFile column type
//        media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
//        media["caption"] = caption
//        media["likesCount"] = 0
//        media["commentsCount"] = 0
//        
//        // Save object (following function will save the object in Parse asynchronously)
//        media.saveInBackgroundWithBlock(completion)
//    }
//    
//    /**
//     Method to post user media to Parse by uploading image file
//     
//     - parameter image: Image that the user wants upload to parse
//     
//     - returns: PFFile for the the data in the image
//     */
//    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
//        // check if image is not nil
//        if let image = image {
//            // get image data and check if that is not nil
//            if let imageData = UIImagePNGRepresentation(image) {
//                return PFFile(name: "image.png", data: imageData)
//            }
//        }
//        return nil
//    }
//}
