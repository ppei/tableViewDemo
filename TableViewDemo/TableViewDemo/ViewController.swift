//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Pei Pei on 2015-09-02.
//  Copyright (c) 2015 Pei Pei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func Filters_button_pressed(sender: AnyObject) {
        performSegueWithIdentifier("show_filter_segue", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

