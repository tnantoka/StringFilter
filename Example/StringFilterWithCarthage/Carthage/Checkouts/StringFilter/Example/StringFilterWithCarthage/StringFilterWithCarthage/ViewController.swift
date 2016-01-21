//
//  ViewController.swift
//  StringFilterWithCarthage
//
//  Created by Tatsuya Tobioka on 1/18/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import UIKit

import StringFilter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("test".str_filter(.Shift(1)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

