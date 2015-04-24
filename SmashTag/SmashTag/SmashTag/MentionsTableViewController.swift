//
//  MentionsTableViewController.swift
//  SmashTag
//
//  Created by Student on 24-04-15.
//  Copyright (c) 2015 HAN. All rights reserved.
//

import UIKit

class MentionsTableViewController: UITableViewController {
    
    //We need a Tweet variable since the information needed to display is from a Tweet
    var tweet: Tweet?{
        didSet{
            title = tweet?.user.screenName //To show the user this tweet belongs to in the Title
            //There are 4 possible mentions : Images, URLs, HashTags and Users
            //To set the header for each section I need a "title" and the data, I stored these items in a struct
            if let images = tweet?.media {
                var imageData:[MentionItem] = []
                //Get all the images represented as a MentionItem
                for item in images{
                    imageData.append(MentionItem.Image(item.url))
                }
                mentions.append(MentionInformation(title:"Images", data: imageData))
            }
        }
    }
    
    //An array of MentionInformation (images, urls, hashtags and users)
    var mentions:[MentionInformation] = []
    
    struct MentionInformation{
        var title : String
        var data: [MentionItem] //There is the option of storing an image or storing text, hence why I made an enum
    }
    
    enum MentionItem{
        case Text(String)
        case Image(NSURL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
