//
//  HomeViewController.swift
//  Instagram Parse
//
//  Created by KaKin Chiu on 3/5/16.
//  Copyright © 2016 KaKinChiu. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mediaArr: [PFObject]?
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blueBackground-2.png")!)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //tableView.estimatedRowHeight = 220.0
        //tableView.rowHeight = 520;
        //tableView.rowHeight = UITableViewAutomaticDimension
        

        //Using a Basic UIRefreshControl
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        let query = PFQuery(className: "Post")
        query.orderByDescending("_created_at")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (post: [PFObject]?, error: NSError?) -> Void in
            if post != nil {
                self.mediaArr = post
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        
        self.tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mediaArr != nil {
            return mediaArr!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        let media = mediaArr![indexPath.row]
        cell.captionLabel.text = media["caption"] as? String
        let userImageFile = media["media"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.postImage.image = image
                }
            }
        }
        return cell
    }
    
    func refresh(sender: AnyObject) {
        let query = PFQuery(className: "Post")
        query.orderByDescending("_created_at")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (post: [PFObject]?, error: NSError?) -> Void in
            if post != nil {
                self.mediaArr = post
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        self.refreshControl.endRefreshing()
    }
}