//
//  TwitterTableViewController.swift
//  SFProject
//
//  Created by EDOUARD CHUSSEAU on 25/03/15.
//  Copyright (c) 2015 edouardchusseau. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterTableViewController: UITableViewController, TWTRTweetViewDelegate {
    let tweetTableReuseIdentifier = "TweetCell"
    
    // Hold all the loaded Tweets
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    let tweetIDs = ["321403621","21"]
    
    override func viewDidLoad() {
        // Setup the table view
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension // Explicitly set on iOS 8 if using automatic row height calculation
        tableView.allowsSelection = false
        tableView.registerClass(TWTRTweetTableViewCell.self, forCellReuseIdentifier: tweetTableReuseIdentifier)
        
        // Load Tweets
//        Twitter.sharedInstance().APIClient.loadTweetsWithIDs(tweetIDs) { tweets, error in
//            if let ts = tweets as? [TWTRTweet] {
//                self.tweets = ts
//            } else {
//                println("Failed to load tweets: \(error.localizedDescription)")
//            }
//            self.tableView.reloadData()
//        }
        
       let statusesUserTimeline = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        let params = ["id": "321403621"]
        var clientError : NSError?
        
        let sess = TWTRSession(sessionDictionary: ["authToken":"321403621-7ePsHZSuFjWPX0MRhNNxeECkLgLR5JVAtrcAawus", "authTokenSecret":"TI9TKUbChbbO30AL2MMJxMGuXNPRV4LN7WBd9iTiK0yJX", "userName":"edouard_chs", "userID":"321403621"])
//        Twitter().
        Twitter.sharedInstance().logInGuestWithCompletion { (session, error) -> Void in
            let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod(
                "GET", URL: statusesUserTimeline, parameters: params,
                error: &clientError)
            
            if request != nil {
                Twitter.sharedInstance().APIClient.sendTwitterRequest(request) {
                    (response, data, connectionError) -> Void in
                    if (connectionError == nil) {
                        var jsonError : NSError?
                        if let dic : NSDictionary? = NSJSONSerialization.JSONObjectWithData(data, options: nil,error: &jsonError) as? NSDictionary {
                            println(dic)
                        }
                        
                    }
                    else {
                        println("Error: \(connectionError)")
                    }
                }
            }
            else {
                println("Error: \(clientError)")
            }
            self.tableView.reloadData()
        }
        
    }

    
  // MARK: UITableViewDelegate Methods
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.tweets.count
  }
 
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let tweet = tweets[indexPath.row]
      let cell = tableView.dequeueReusableCellWithIdentifier(tweetTableReuseIdentifier, forIndexPath: indexPath) as TWTRTweetTableViewCell
      cell.configureWithTweet(tweet)
      cell.tweetView.delegate = self
      return cell
  }
 
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      let tweet = tweets[indexPath.row]
      return TWTRTweetTableViewCell.heightForTweet(tweet, width: CGRectGetWidth(self.view.bounds))
  }
}