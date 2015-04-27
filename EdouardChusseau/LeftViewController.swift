//
//  LeftViewController.swift
//  EdouardChusseau
//
//  Created by EDOUARD CHUSSEAU on 24/03/15.
//  Copyright (c) 2015 edouardchusseau. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var imgBack: UIImageView!
    @IBOutlet var nameProject: UILabel!
    @IBOutlet var detailProject: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var ViewProjects: UIView!
    @IBOutlet var textStudy: UILabel!
    
    
    @IBOutlet var LaboButton: UIButton!
    @IBOutlet var schoolButton: UIButton!
    @IBOutlet var ViewEducation: UIView!
    @IBOutlet var ImageEducation: UIImageView!
    
    
    @IBOutlet var projectViewHeight: NSLayoutConstraint!
    @IBOutlet var educationViewTop: NSLayoutConstraint!
    @IBOutlet var educationViewHeight: NSLayoutConstraint!
    
    var delegate: ViewController?
    
    //Variables
    var dataTable: [String] = ["Card Game", "Stadium", "#Captain","Sofaremote", "Blog"]
    var dataDetail: [String] = ["52 card card game to play in the evening with your friends","Application which concentrates the soccer game photos on Instagram through hashtags","One hashtag to rull them all, with my friends Remi Santos and Damien Audrezet (also on wwdc student program)","Leave your TV remote lost under your sofa, and control your TV with all your apple devices","My personal blog"]
    var imgTable: [String] = ["cardgame","stadium","captain","sofaremote","blog"]
    var imgback: [String] = ["cardgameBack","stadiumBack","captainBack","sofaremoteBack","blogBack"]
    var dataurl: [String] = ["itms-apps://itunes.apple.com/us/app/jeu-de-cartes-random/id933857966?ls=1&mt=8","itms-apps://itunes.apple.com/us/app/stadium-pictures-sports-matches/id883251164?ls=1&mt=8","itms-apps://itunes.apple.com/app/id934806007","http://sofaremote.com","http://edouardchusseau.com"]
    var textUrl:String!
    
    //Project and App View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolButton.backgroundColor = UIColor.blackColor()
        schoolButton.alpha = 0.25
        projectViewHeight.constant = view.frame.size.height - 75
        
        nameProject.text = dataTable[0]
        detailProject.text = dataDetail[0]
        imgBack.image = UIImage(named: imgback[0])
        textUrl = dataurl[0]
        textStudy.text = "I'm a informatic student at Ingesup Bordeaux - Master degree in computer science . I learn many language but especially swift."
        ImageEducation.image = UIImage(named: "ingesup")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func lvSwipeLeft(sender: AnyObject) {
        delegate?.hideLeft()
    }
    @IBAction func seeMoreButton(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: textUrl)!)
    }
    
    // MARK: - CollectionView
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTable.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.lblText.text = dataTable[indexPath.row]
        cell.imgCell.image = UIImage(named: imgTable[indexPath.row])
        cell.imgCell.layer.cornerRadius = cell.imgCell.frame.size.height/4
            
        return cell
    }

    @IBAction func showEducationView(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.ViewEducation.frame.origin.y = 75
        }, completion: { (finished) -> Void in
            self.educationViewTop.constant = -self.projectViewHeight.constant + 75
        })
    }
    
    @IBAction func hideEducationView(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.ViewEducation.frame.origin.y = self.view.frame.size.height - 75
        }, completion: { (finished) -> Void in
                self.educationViewTop.constant = 0
        })
    }
    
    @IBAction func schoolButtonAction(sender: AnyObject) {
        schoolButton.backgroundColor = UIColor.blackColor()
        schoolButton.alpha = 0.25
        LaboButton.backgroundColor = UIColor.clearColor()
        LaboButton.alpha = 1
        textStudy.text = "I'm a informatic student at Ingesup Bordeaux - Master degree in computer science . I learn many language but especially swift."
        ImageEducation.image = UIImage(named: "ingesup")
    }
    
    @IBAction func LaboButtonAction(sender: AnyObject) {
        LaboButton.backgroundColor = UIColor.blackColor()
        LaboButton.alpha = 0.25
        schoolButton.backgroundColor = UIColor.clearColor()
        schoolButton.alpha = 1
        textStudy.text = "Every Wednesday at school, I co-head a group of student who works on apple technology, we call that the 'Laboratoire Apple'. During this time we explore and share the ios world. A lot of projects begin in the lab"
        ImageEducation.image = UIImage(named: "applelab")
    }


    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        nameProject.text = dataTable[indexPath.row]
        detailProject.text = dataDetail[indexPath.row]
        imgBack.image = UIImage(named: imgback[indexPath.row])
        textUrl = dataurl[indexPath.row]
        
    }
}
