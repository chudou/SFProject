//
//  RightViewController.swift
//  EdouardChusseau
//
//  Created by EDOUARD CHUSSEAU on 24/03/15.
//  Copyright (c) 2015 edouardchusseau. All rights reserved.
//

import UIKit
import MapKit
import MessageUI


class RightViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var mapkitView: UIView!
    var delegate: ViewController?
    
    //Buttons
    
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var schoolButton: UIButton!
    @IBOutlet var sportButton: UIButton!
    @IBOutlet var wwdcButton: UIButton!
    
    //Data for MapKit
    var lat: CLLocationDegrees!
    var lon: CLLocationDegrees!
    var titre: String!
    var subtitre: String!
    var location: CLLocationCoordinate2D!
    var annotation: MKPointAnnotation!
    var span: MKCoordinateSpan!
    var xyspan: CLLocationDegrees!
    var region: MKCoordinateRegion!
    
    //Constraint for buttons
    
    @IBOutlet var homeLeading: NSLayoutConstraint!
    @IBOutlet var schooLeading: NSLayoutConstraint!
    @IBOutlet var sportLeading: NSLayoutConstraint!
    @IBOutlet var wwdcLeading: NSLayoutConstraint!
    
    //MapView
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var mapViewHeight: NSLayoutConstraint!
    @IBOutlet var mapViewWidth: NSLayoutConstraint!
    
    //TableView
    @IBOutlet var tableView: UITableView!
    let textCellIdentifier = "Cell"
    let data = [
        [["My website","edouardchusseau.com"]],
        [["Name","Edouard CHUSSEAU"],["Email","edouard.chusseau@icloud.com"],["Phone","+33 6 69 62 70 66"],["Address","Bordeaux, FRANCE"]],
        [["Facebook","Edouard Chusseau"],["Twitter","@edouard_chs"],["Linkedin","Edouard Chusseau"]],
    ]
    let dataTitle = ["My website","Contact Information","Social Network"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        //Constraints Leading
        var leading = (self.view.frame.size.width - 200)/5
        homeLeading.constant = leading
        schooLeading.constant = leading
        sportLeading.constant = leading
        wwdcLeading.constant = leading
        
        //homeButton
        homeButton.layer.cornerRadius = self.homeButton.layer.frame.size.width/2
        homeButton.layer.borderWidth = 1
        homeButton.layer.borderColor = UIColor.grayColor().CGColor
        //schoolButton
        schoolButton.layer.cornerRadius = self.homeButton.layer.frame.size.width/2
        schoolButton.layer.borderWidth = 1
        schoolButton.layer.borderColor = UIColor.grayColor().CGColor
        //sportButton
        sportButton.layer.cornerRadius = self.homeButton.layer.frame.size.width/2
        sportButton.layer.borderWidth = 1
        sportButton.layer.borderColor = UIColor.grayColor().CGColor
        //wwdcButton
        wwdcButton.layer.cornerRadius = self.homeButton.layer.frame.size.width/2
        wwdcButton.layer.borderWidth = 1
        wwdcButton.layer.borderColor = UIColor.grayColor().CGColor
        
        
        
        mapViewHeight.constant = self.view.frame.size.height/2
        mapViewWidth.constant = self.view.frame.size.width
        
        mapviewloc(46.654744,Lon: -1.455331,Titre: "Home",SubTitre: "This is where I grow up, and this is my paradise #Vendée <3",Span: 10.0)
    }
    
    //func for mapview
    func mapviewloc(Lat: CLLocationDegrees,Lon: CLLocationDegrees,Titre: String,SubTitre: String,Span: Float)
    {
        mapView.removeAnnotation(annotation)
        location = CLLocationCoordinate2D(
            latitude: Lat,
            longitude: Lon
        )
        xyspan = CLLocationDegrees(Span)
        span = MKCoordinateSpanMake(xyspan, xyspan)
        region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        titre = Titre
        subtitre = SubTitre
        annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = titre
        annotation.subtitle = subtitre
        mapView.addAnnotation(annotation)
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
            self.mapView.selectAnnotation(self.annotation, animated: true)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rvSwipeRight(sender: AnyObject) {
        delegate?.hideRight()
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    }
    */
    
    @IBAction func homePlace(sender: AnyObject) {
        mapviewloc(46.654744,Lon: -1.455331,Titre: "Home",SubTitre: "This is where I grow up, and this is my paradis #Vendée <3",Span: 10.0)
    }
    @IBAction func studyPlace(sender: AnyObject) {
        mapviewloc(44.8540923,Lon: -0.566065799999933,Titre: "Ingesup",SubTitre: "This is where I am studying informatics, and swift ",Span: 0.50)
    }
    @IBAction func sportPlace(sender: AnyObject) {
        mapviewloc(47.256067,Lon: -1.52475000000004,Titre: "FCNA",SubTitre: "My favorite soccer team : FCNantes  💛💚",Span: 0.50)
    }
    @IBAction func soonPlace(sender: AnyObject) {
        mapviewloc(37.783879,Lon: -122.401254,Titre: "WWDC  ",SubTitre: "This is where I hope to be in June ",Span:0.10)
    }
    
    //TableView Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataTitle.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var a = data[section].count
        return a
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        var text =  data[indexPath.section][indexPath.row][0]
        var detail =  data[indexPath.section][indexPath.row][1]
        
        cell.textLabel?.text = text
        cell.detailTextLabel?.text = detail
        
        return cell
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataTitle[section]
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0)
        {
            UIApplication.sharedApplication().openURL(NSURL(string: "http://edouardchusseau.com/road-to-wwdc/")!)
        }
        if(indexPath.section == 1 && indexPath.row == 1)
        {
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }
    }
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["edouard.chusseau@icloud.com"])
        mailComposerVC.setSubject("About your WWDC15 App :)")
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
