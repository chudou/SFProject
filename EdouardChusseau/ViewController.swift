//
//  ViewController.swift
//  EdouardChusseau
//
//  Created by EDOUARD CHUSSEAU on 24/03/15.
//  Copyright (c) 2015 edouardchusseau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var imageBG: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var imageBGBlur: UIImageView!
    @IBOutlet var textEdouard: UILabel!
    
    @IBOutlet var upArrowButton: UIButton!
    @IBOutlet var leftArrowButton: UIButton!
    @IBOutlet var rightArrowButton: UIButton!
    @IBOutlet var downArrowButton: UIButton!
    
    
    var animationComplete:Bool = false
    
    var leftVC: LeftViewController!
    var rightVC: RightViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("Welcome on my WWDC student App")
        //Set Viewcontroller
        name.text = "Edouard Chusseau"
        textEdouard.text = "Hi !! My name is Edouard, i’m studying Informatics at Ingesup in Bordeaux. Fascinates by new technology. Currently in my third years, I naturally leads me to the web marketing, the Digital Strategy and the iOS development . I’ve recently launch my website edouardchusseau.com. I also participate in the adventure of #Captain apps, an iOS app which follow hashtag on social network. I’m also leading a groupe of apple dev at my school, i’m helping them in their app. Throughout these activities i discover some notion of sharing and managment. I'm a big fan of sport, espacially soccer. I love to play sport with my friends all the sunny afternoon."
        self.textEdouard.hidden = true
        //create two subbview
        leftVC = self.storyboard?.instantiateViewControllerWithIdentifier("LeftVC") as! LeftViewController
        leftVC.delegate = self
        leftVC.view.frame.origin.x = -view.frame.size.width
        
        rightVC = self.storyboard?.instantiateViewControllerWithIdentifier("RightVC") as! RightViewController
        rightVC.delegate = self
        rightVC.view.frame.origin.x = view.frame.size.width

        self.view.addSubview(leftVC.view)
        self.view.addSubview(rightVC.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Function for subview
    func showLeft() {
        leftAnimationShow()
        println("This is my Projects view")
    }
    func hideLeft() {
        leftAnimationHide()
    }
    func showRight(){
        rightAnimationShow()
        println("This is my informations view")
    }
    func hideRight(){
        rightAnimationHide()
    }
    //Function to animate subview
    func leftAnimationShow(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.leftVC.view.frame.origin.x = 0
        })
    }
    func leftAnimationHide(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.leftVC.view.frame.origin.x = -self.view.frame.size.width
        })
    }
    func rightAnimationShow(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.rightVC.view.frame.origin.x = 0
        })
    }
    func rightAnimationHide(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.rightVC.view.frame.origin.x = self.view.frame.size.width
        })
    }
    
    
    @IBAction func swipeGestureRecognized(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.Left:
            //show the project view
            println("Show the project view")
            showRight()
            break
        case UISwipeGestureRecognizerDirection.Up:
            //Show my description
            println("Show my description")
            if animationComplete == false
            {
                animateUp()
                animationComplete = true
            }
            break
        case UISwipeGestureRecognizerDirection.Right:
            //show the information view
            println("Show the information view")
            showLeft()
            break
        case UISwipeGestureRecognizerDirection.Down:
            //show the start view
            println("Show the start view")
            if animationComplete == true
            {
                animateDown()
                animationComplete = false
            }
            break
        default:
            println("default swipe")
        break
        }
    }

    
    func animation() {
        if animationComplete == false
        {
            animateUp()
            animationComplete = true
        } else {
            animateDown()
            animationComplete = false
        }
    }
    
    @IBAction func animationButton(sender: AnyObject) {
        if animationComplete == false
        {
            animateUp()
            animationComplete = true
        } else {
            animateDown()
            animationComplete = false
        }
        
    }
    
    @IBAction func upButton(sender: AnyObject) {
        animateUp()
        animationComplete = true
    }

    @IBAction func leftButton(sender: AnyObject) {
        showLeft()
    }
    
    @IBAction func RightButton(sender: AnyObject) {
        showRight()
    }
    
    @IBAction func downButton(sender: AnyObject) {
        animateDown()
        animationComplete = false
    }
    


    var imageBGHeight: CGFloat = 0
    var nameLabelFrame: CGRect!
    var backgroundblur: CGFloat!
    var edouardText: CGFloat!
    func animateDown() {
        //Background
        let xdiffBG = -(imageBG.frame.origin.x + imageBG.frame.size.width/4)
        //Annimation
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.image.transform = CGAffineTransformIdentity
            self.imageBG.frame.size.height = self.imageBGHeight
            self.name.frame = self.nameLabelFrame
            self.imageBGBlur.frame.origin.y = self.imageBGBlur.frame.origin.y + 175
            self.imageBGBlur.frame.size.height = self.backgroundblur
            self.textEdouard.frame.origin.y = self.edouardText
            }, completion: { (finished) -> Void in
                self.upArrowButton.hidden = false
                self.leftArrowButton.hidden = false
                self.rightArrowButton.hidden = false
                self.downArrowButton.hidden = true
        })
        let radius = CABasicAnimation(keyPath: "cornerRadius")
        radius.toValue = 0
        radius.fromValue = self.image.layer.cornerRadius
        radius.duration = 1
        radius.removedOnCompletion = false
        self.image.layer.addAnimation(radius, forKey: "radius")
        self.image.layer.cornerRadius = 0
        name.textColor = UIColor.blackColor()
        self.textEdouard.hidden = true
    }
    
    
    func animateUp(){
        //Variable
        let xdiff = -(image.frame.origin.x + image.frame.size.width/4)
        let ydiff = -(image.frame.origin.y + image.frame.size.width/4)
        let translate = CGAffineTransformMakeTranslation(xdiff-10,ydiff)
        let transform = CGAffineTransformScale(translate, 0.15, 0.15)
        backgroundblur = imageBGBlur.frame.size.height
        edouardText = textEdouard.frame.origin.y
        imageBGHeight = imageBG.frame.size.height
        let newCornerRaidus = image.bounds.size.width/4
        nameLabelFrame = name.frame
        //Animation
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            //image
            self.image.transform = transform
            //imgbackground
            self.imageBG.frame.size.height = 75
            //name
            self.name.center.x = self.view.center.x
            self.name.frame.origin.y = 39
            //imgblur
            self.imageBGBlur.frame.origin.y = self.imageBGBlur.frame.origin.y - 175
            self.imageBGBlur.frame.size.height = self.view.frame.size.height
            //textEdouard
            self.textEdouard.frame.origin.y = self.textEdouard.frame.origin.y - 175
        }, completion: { (finished) -> Void in
            self.name.textColor = UIColor.whiteColor()
            self.textEdouard.hidden = false
            self.downArrowButton.hidden = false
        })
        let radius = CABasicAnimation(keyPath: "cornerRadius")
        radius.toValue = newCornerRaidus
        radius.fromValue = self.image.layer.cornerRadius
        radius.duration = 1
        radius.removedOnCompletion = false
        self.image.layer.addAnimation(radius, forKey: "radius")
        self.image.layer.cornerRadius = newCornerRaidus
        self.upArrowButton.hidden = true
        self.leftArrowButton.hidden = true
        self.rightArrowButton.hidden = true
    }


}

