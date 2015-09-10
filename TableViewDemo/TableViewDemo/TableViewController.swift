//
//  TableViewController.swift
//  TableViewDemo
//
//  Created by Pei Pei on 2015-09-02.
//  Copyright (c) 2015 Pei Pei. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        // Trim leading '#' if needed
        var cleanedHexString = hexString
                // String -> UInt32
        var rgbValue: UInt32 = 0
        NSScanner(string: cleanedHexString).scanHexInt(&rgbValue)
        
        // UInt32 -> R,G,B
        let red = CGFloat((rgbValue >> 16) & 0xff) / 255.0
        let green = CGFloat((rgbValue >> 08) & 0xff) / 255.0
        let blue = CGFloat((rgbValue >> 00) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}



class TableViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        println("cancelButtonPressed")
 
        performSegueWithIdentifier("showPreviousViewSegue", sender: self)
    }
    
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("showPreviousViewSegue", sender: self)
        writeConfigToDevice()
    }
    
    static let CONFIGKEY_EN = "OnDeviceTV";
    static let CONFIGKEY_CN = "OnDeviceTVCN";
    let tableHeader = ["My Favorite","挚爱仙侠"]
    var tvNames = ["The Journey of Flower", "The Legend of the Condor Heros", "Gujian Legend"]
    var tvNamesChinese = ["花千骨","神雕侠侣","古剑奇谭"]
    var image_names = ["qiangu.jpeg","shendiao.jpeg","gujian.jpeg"]
    var checkMarkedEN =  [String: Bool]()
    var checkMarkedCN =  [String: Bool]()
    
    func loadConfigFromDevice(){
        //Load/refresh the courses from device
        //TODO: I assume here courses contains the fetched courses
        
        //initialize all courses to be checked
        for name in tvNames {
            checkMarkedEN[name] = true
        }
        
        //initialize all activities to be checked
        for name in tvNamesChinese {
            checkMarkedCN[name] = true
        }
        
        
        //load the previous defined filters from device
        
        if NSUserDefaults.standardUserDefaults().objectForKey(TableViewController.CONFIGKEY_EN) != nil {
            let savedCheckMarkedEN = NSUserDefaults.standardUserDefaults().objectForKey(TableViewController.CONFIGKEY_EN) as! [String: Bool]
            for course in tvNames {
                if(savedCheckMarkedEN[course] != nil){
                    checkMarkedEN[course] = savedCheckMarkedEN[course]
                }
            }
        }
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey(TableViewController.CONFIGKEY_CN) != nil {
            let savedCheckMarkedCN = NSUserDefaults.standardUserDefaults().objectForKey(TableViewController.CONFIGKEY_CN) as! [String: Bool]
            for activity in tvNamesChinese {
                if(savedCheckMarkedCN[activity] != nil){
                    checkMarkedCN[activity] = savedCheckMarkedCN[activity]
                }
            }
        }

        
    }
    
    func writeConfigToDevice(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(checkMarkedEN, forKey: TableViewController.CONFIGKEY_EN)
        defaults.setObject(checkMarkedCN, forKey: TableViewController.CONFIGKEY_CN)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadConfigFromDevice()
        saveButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (section == 0){
            return tvNames.count
        } else {
            return tvNamesChinese.count
        }
        
    }
    
    
    //The following two method would be good enough for simple text section headers
    
    /*
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableHeader[section];
    }
    */
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let  headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! CustomHeaderCell
        headerCell.backgroundColor = UIColor(hexString:"E6E6E6")

        headerCell.headerLabel.text = tableHeader[section];

        
        return headerCell
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        switch (indexPath.section){

            case 0:
                var cell:UITableViewCell

                cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
                cell.textLabel?.text = tvNames[indexPath.row]
                //In viewDidLoad the checkMarked array is initialized to make sure no nil returned
                //This is just to get rid of the unwraping error
                if checkMarkedEN[tvNames[indexPath.row]] != nil {
                    if (checkMarkedEN[tvNames[indexPath.row]] == true){
                        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    }
                }
                return cell

        
            case 1:
                var cellWithIcon : type1Cell
                cellWithIcon = tableView.dequeueReusableCellWithIdentifier("type1Cell", forIndexPath: indexPath) as! type1Cell
                cellWithIcon.label.text = tvNamesChinese[indexPath.row]
                cellWithIcon.iconImage.image = UIImage(named: image_names[indexPath.row
                    ])
                if checkMarkedCN[tvNamesChinese[indexPath.row]] != nil {
                    if (checkMarkedCN[tvNamesChinese[indexPath.row]] == true){
                        cellWithIcon.accessoryType = UITableViewCellAccessoryType.Checkmark
                    }
                }
                return cellWithIcon
            
            default:
                var cell:UITableViewCell
                cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
                return cell
        }
        
    
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        switch (indexPath.section){
        case 0 :
            
            if checkMarkedEN[tvNames[indexPath.row]] != nil {
                if checkMarkedEN[tvNames[indexPath.row]] == true {
                    checkMarkedEN[tvNames[indexPath.row]] = false
                    cell.accessoryType = UITableViewCellAccessoryType.None
                } else {
                    checkMarkedEN[tvNames[indexPath.row]] = true
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            }
        case 1:
            
            if checkMarkedCN[tvNamesChinese[indexPath.row]] != nil {
                if checkMarkedCN[tvNamesChinese[indexPath.row]] == true {
                    checkMarkedCN[tvNamesChinese[indexPath.row]] = false
                    cell.accessoryType = UITableViewCellAccessoryType.None
                } else {
                    checkMarkedCN[tvNamesChinese[indexPath.row]] = true
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            }
        default:
            break

        }
        saveButton.enabled = true
        
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
