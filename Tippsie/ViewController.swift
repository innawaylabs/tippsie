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
    let tipPercentages = [0.18, 0.2, 0.25]
    let currencySymbols = ["$", "£", "₹"]

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentagesSegControl: UISegmentedControl!
    @IBOutlet weak var currencyLabel1: UILabel!
    @IBOutlet weak var currencyLabel2: UILabel!
    @IBOutlet weak var currencyLabel3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        if (defaults.object(forKey: billAmountKey) != nil) {
            let billAmount = defaults.double(forKey: billAmountKey)
            billField.text = String(format: "%.2f", billAmount)
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
        
        amountUpdated(billField);
    }
    
    @IBAction func amountUpdated(_ sender: AnyObject) {
        let billAmount = Double(billField.text!) ?? 0
        let tip = billAmount * tipPercentages[tipPercentagesSegControl.selectedSegmentIndex]
        let total = billAmount + tip
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)

        // Persist the details
        let defaults = UserDefaults.standard
        
        defaults.set(billAmount, forKey: billAmountKey)
        defaults.synchronize()
    }
}

