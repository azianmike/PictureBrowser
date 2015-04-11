//
//  ImageObject.swift
//  PictureBrowser
//
//  Created by Michael Luo on 4/10/15.
//  Copyright (c) 2015 PictureBrowser. All rights reserved.
//

import Foundation

class ImageObject:NSObject{
    var numLikes:Int!
    var numDislikes:Int!
    var image:UIImage!
    var objectID:String!
    var article: Int!
    var maleFeedback: Bool!
    var femaleFeedback: Bool!
    
    override init(){
        super.init()
    }
    
    
    func getLikes()-> Int{
        return numLikes!
    }
    
    func getDislikes()-> Int{
        return numDislikes!
    }
    
    func getObjectID()-> String{
        return objectID!
    }
    
    func getArticle()-> Int{
        return article
    }
    
    func getMaleFeedback()-> Bool!{
        return maleFeedback
    }
    func getFemaleFeedback()-> Bool!{
        return femaleFeedback
    }
    
}


