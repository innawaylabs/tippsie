//
//  ViewController.swift
//  Tippsie
//
//  Created by Ravi Mandala on 8/15/17.
//  Copyright © 2017 Ravi Mandala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let defaultTipPercentageKey = "default_tip_segment"
    let billAmountKey = "bill_amount"
    let currencySymbolIndexKey = "currency_symbol_index"
    let roundingPolicyKey = "rounding_policy_index"
    let savedDateKey = "saved_date"
    let tipPercentages = [0.18, 0.2, 0.25]
    let currencySymbols = ["$", "£", "₹"]
    var roundingPolicyIndex = 0
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentagesSegControl: UISegmentedControl!
    @IBOutlet weak var currencyLabel1: UILabel!
    @IBOutlet weak var currencyLabel2: UILabel!
    @IBOutlet weak var currencyLabel3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.billField.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        var ageInSeconds = 0.0
        
        if (defaults.object(forKey: billAmountKey) != nil) {
            if (defaults.object(forKey: savedDateKey) != nil) {
                let savedDate = defaults.object(forKey: savedDateKey) as! Date
                ageInSeconds = savedDate.timeIntervalSinceNow
            }
            if (ageInSeconds >= -600) {
                let billAmount = defaults.double(forKey: billAmountKey)
                billField.text = String(format: "%.2f", billAmount)
            }
        }
        if (defaults.object(forKey: currencySymbolIndexKey) != nil) {
            let currencySymbolIndex = defaults.integer(forKey: currencySymbolIndexKey)
            currencyLabel1.text = currencySymbols[currencySymbolIndex]
            currencyLabel2.text = currencySymbols[currencySymbolIndex]
            currencyLabel3.text = currencySymbols[currencySymbolIndex]
        }
        if (defaults.object(forKey: defaultTipPercentageKey) != nil) {
            let tipSegment = defaults.integer(forKey: defaultTipPercentageKey)
            tipPercentagesSegControl.selectedSegmentIndex = tipSegment
        }
        if (defaults.object(forKey: roundingPolicyKey) != nil) {
            roundingPolicyIndex = defaults.integer(forKey: roundingPolicyKey)
        }
        
        amountUpdated(billField);
    }
    
    @IBAction func amountUpdated(_ sender: AnyObject) {
        let billAmount = Double(billField.text!) ?? 0
        let tip = billAmount * tipPercentages[tipPercentagesSegControl.selectedSegmentIndex]
        let total = billAmount + tip
        
        tipLabel.text = String(format: "%.2f", tip)
        if (roundingPolicyIndex == 1) {
            totalLabel.text = String(format: "(%.0f)", ceil(total))
        } else if (roundingPolicyIndex == 2) {
            totalLabel.text = String(format: "(%.0f)", floor(total))
        } else {
            totalLabel.text = String(format: "%.2f", total)
        }
        

        // Persist the details
        let defaults = UserDefaults.standard
        
        defaults.set(billAmount, forKey: billAmountKey)
        defaults.set(Date(), forKey: savedDateKey)
        defaults.synchronize()
    }
}

