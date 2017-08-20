//
//  ViewController.swift
//  Tippsie
//
//  Created by Ravi Mandala on 8/15/17.
//  Copyright © 2017 Ravi Mandala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentagesSegControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onScreenTap(_ sender: AnyObject) {
        print ("Hello")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let tipSegment = defaults.integer(forKey: "default_tip_segment")

        tipPercentagesSegControl.selectedSegmentIndex = tipSegment
        amountUpdated(billField);
    }
    
    @IBAction func amountUpdated(_ sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.25]
        let billAmount = Double(billField.text!) ?? 0
        let tip = billAmount * tipPercentages[tipPercentagesSegControl.selectedSegmentIndex]
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }    
}

