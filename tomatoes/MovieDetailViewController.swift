//
//  MovieDetailViewController.swift
//  tomatoes
//
//  Created by Gabe Kangas on 4/19/15.
//  Copyright (c) 2015 Gabe Kangas. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var movie :Movie!
    @IBOutlet weak var poster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        refresh()
        
        tableView.contentInset = UIEdgeInsetsMake(400, 0, 0, 0)
        
        poster.sd_setImageWithURL(movie.imageUrl, placeholderImage: UIImage(named: "placeholder.jpg"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return movie.cast.count
        }
        
        if section == 0 {
            return 2
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 20
        } else if indexPath.section == 1 {
            return 40
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ScoreTableViewCell", forIndexPath: indexPath) as! UITableViewCell
            if indexPath.row == 0 {
                let ratingString = movie.criticsRating > 0 ? String(movie.criticsRating) : "None"
                cell.textLabel?.text = "Critic's Score: \(ratingString)"
            } else {
                let ratingString = movie.rating > 0 ? String(movie.rating) : "None"
                cell.textLabel?.text = "Audience Socre: \(ratingString)"
            }
            
            cell.textLabel!.font = UIFont(name: "Helvetica-Neue", size: 9)
            return cell
        }
            
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CastCell", forIndexPath: indexPath) as! CastTableViewCell

            let castMember = movie.cast.objectAtIndex(indexPath.row) as! NSDictionary
            if let castCharacter = castMember.objectForKey("characters") as? NSArray {
                cell.characterLabel.text = castCharacter.firstObject as? String
            } else {
                cell.characterLabel.text = ""
            }
            
            cell.nameLabel.text = (castMember.valueForKey("name")) as? String
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func refresh() {
        let apiUrlString = "http://www.omdbapi.com/"
        var params = NSMutableDictionary()
        params["t"] = movie.name
        params["plot"] = "full"
        params["r"] = "json"
        
        let manager = AFHTTPRequestOperationManager()
        manager.GET(apiUrlString,
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                //Complete
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                //Error
            }
        )
        
    }
    
}
