//
//  ViewController.swift
//  PictureBrowser
//
//  Created by Michael Luo on 4/10/15.
//  Copyright (c) 2015 PictureBrowser. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MDCSwipeToChooseDelegate {
    
    //@IBOutlet var temp:UIImageView!
    var mainView:MDCSwipeToChooseView!
    @IBOutlet var smallView:UIView!
    var jsonResults:NSArray!
    var currentIndex:Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        //loadingNotification.mode = MBProgressHUDModeIndeterminate
        loadingNotification.labelText = "Loading Submissions"
        // Do any additional setup after loading the view, typically from a nib.
        //loadData()
        

        
        loadRedditPics()

        createNewImageView()
        //loadRedditPics()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNewImageView()
    {


        var options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "Like"
        options.likedColor = UIColor.blueColor()
        options.nopeText = "Dislike"
        options.onPan = { state -> Void in
            if state.thresholdRatio == 1 && state.direction == MDCSwipeDirection.Left {
                println("Photo deleted!")
            }
            if state.thresholdRatio == 1 && state.direction == MDCSwipeDirection.Right {
                println("Photo liked!")
            }
        }
        mainView = MDCSwipeToChooseView(frame: self.view.bounds, options: options)
        mainView.imageView.image = loadNextRedditPic()
        //mainView.imageView.image = loadData()
        //view.imageView = temp
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        self.smallView.addSubview(mainView)
    }
    
    func loadNextRedditPic()->UIImage{
        var url2 = ""
        while(url2.rangeOfString("imgur") == nil)
        {
            let url3 = jsonResults[currentIndex]["data"] as! NSDictionary
            url2 = url3["url"] as! String
            if url2.rangeOfString(".jpg") == nil
            {
                url2 += ".jpg"
            }
            currentIndex!++
        }
        
        let url = NSURL(string: url2)
        let data = NSData(contentsOfURL: url!)
        let image = UIImage(data: data!)
        currentIndex!++
        return image!
    }
    
    func loadRedditPics(){
        
        let temp = [ImageObject]()
        let url = NSURL(string: "http://www.reddit.com/r/earthporn/hot.json?sort=new")
        let data = NSData(contentsOfURL: url!)

        var err: NSError?
        var theJSON = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSMutableDictionary
        jsonResults = theJSON["data"]!["children"] as! NSArray
        
    }
    

    func loadData()->UIImage{
        let imageURL = "http://i.imgur.com/uYZuuJ9.jpg"
        let url = NSURL(string: imageURL)
        let data = NSData(contentsOfURL: url!)
        let image = UIImage(data: data!)
        //temp.image=image
        return image!
    }
    
    // This is called when a user didn't fully swipe left or right.
    func viewDidCancelSwipe(view: UIView) -> Void{
        println("Couldn't decide, huh?")
    }
    
    // Sent before a choice is made. Cancel the choice by returning `false`. Otherwise return `true`.
    func view(view: UIView, shouldBeChosenWithDirection: MDCSwipeDirection) -> Bool{
        if (shouldBeChosenWithDirection == MDCSwipeDirection.Left || shouldBeChosenWithDirection == MDCSwipeDirection.Right) {
            let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            //loadingNotification.mode = MBProgressHUDModeIndeterminate
            loadingNotification.labelText = "Loading Submissions"
            return true;
        } else {
            // Snap the view back and cancel the choice.
            UIView.animateWithDuration(0.16, animations: { () -> Void in
                view.transform = CGAffineTransformIdentity
                view.center = view.superview!.center
            })
            return false;
        }
    }
    
    // This is called then a user swipes the view fully left or right.
    func view(view: UIView, wasChosenWithDirection: MDCSwipeDirection) -> Void{
        if wasChosenWithDirection == MDCSwipeDirection.Left {
            println("Photo deleted!")
        }else{
            println("Photo saved!")
        }
        println("added new image")
        createNewImageView()
    }

}

