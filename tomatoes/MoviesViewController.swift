//
//  MoviesViewController.swift
//  tomatoes
//
//  Created by Gabe Kangas on 4/14/15.
//  Copyright (c) 2015 Gabe Kangas. All rights reserved.
//
// http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&q=star+wars

import UIKit
import SDWebImage
import JGProgressHUD
import AFNetworking

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movies = NSMutableArray()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.addSubview(refreshControl)

        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCollectionViewCell
        
        if let movie = movies.objectAtIndex(indexPath.row) as? Movie {
            cell.movieName.text = movie.name
            cell.movieImageView.sd_setImageWithURL(movie.imageUrl, placeholderImage: UIImage(named:"placeholder.jpg"))
            cell.ratingImageFilename = movie.rating > 50 ? "rebel.png" : "empire.png"
            if !movie.displayed {
                var delay = Double(indexPath.item % 2) * 0.1
                cell.animate(delay: delay)
                movie.displayed = true
            } else {
                cell.layout()
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func parseData(dataArray: NSArray) {
        dataArray.enumerateObjectsUsingBlock { (movieDictionary, index, complete) -> Void in
            let singleMovie = Movie(dictionary: movieDictionary as! NSDictionary)
            self.movies.addObject(singleMovie)
        }
        collectionView.reloadData()
        
    }
    
    func refresh() {
        movies.removeAllObjects()
        
        let apiUrlString = "http://api.rottentomatoes.com/api/public/v1.0/movies.json"
        var params = NSMutableDictionary()
        params["apikey"] = "dagqdghwaq3e3mxyrp7kmmj5"
        params["q"] = "star wars"
        
        let manager = AFHTTPRequestOperationManager()
        manager.GET(apiUrlString,
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                //Complete
                if let movies = responseObject.objectForKey("movies") as? NSArray {
                    self.parseData(movies)
                    self.refreshControl.endRefreshing()
                }
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                self.showError("Network Error")
                self.refreshControl.endRefreshing()
            }
        )
        
    }
    
    func showError(errorText: String) {
        let errorView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        errorView.tintColor = UIColor.redColor()
        errorView.frame = CGRectMake(0, 0, view.frame.size.width, 50)
        
        let errorViewLabel = UILabel(frame: errorView.frame)
        errorViewLabel.backgroundColor = UIColor.clearColor()
        errorViewLabel.textColor = UIColor.whiteColor()
        errorViewLabel.textAlignment = NSTextAlignment.Center
        errorViewLabel.adjustsFontSizeToFitWidth = true
        errorViewLabel.minimumScaleFactor = 0.3
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "crossed-lightsabers.png")
        attachment.bounds = CGRectMake(5, -2, 15, 15)
        
        var attributedStringAttachment = NSAttributedString(attachment: attachment)
        
        let attributedString = NSMutableAttributedString(string: errorText)
        attributedString.appendAttributedString(attributedStringAttachment)
        
        errorViewLabel.attributedText = attributedString
        
        errorView.addSubview(errorViewLabel)
        view.insertSubview(errorView, aboveSubview: collectionView)
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            errorView.frame.origin.y = 60
        }) { (completed) -> Void in
            // Move error out
            UIView.animateWithDuration(1.0, delay: 3.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                errorView.frame.origin.y = 0
            }, completion: { (completed) -> Void in
                errorView.removeFromSuperview()
            })
        }
    }

    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        let cell = sender as! UICollectionViewCell
        let index = collectionView.indexPathForCell(cell)
        let movie = movies.objectAtIndex(index!.item) as! Movie

        if movie.cast.count == 0 {
            showError("We have no cast information for this movie to display.")
            return false
        }
        
        return true
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UICollectionViewCell
        let index = collectionView.indexPathForCell(cell)
        let movie = movies.objectAtIndex(index!.item) as! Movie
        
        let destinationVC = segue.destinationViewController as! MovieDetailViewController
        destinationVC.movie = movie
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
