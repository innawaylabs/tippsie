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
    let tipPercentages = [18, 20, 25]
    var roundingPolicyIndex = 0
    let currencySymbols = ["US": "$", "GB": "£", "IN": "₹", "JP": "¥", "GR": "€", "EE": "€"]

    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.billField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        var ageInSeconds = 0.0
        
        tipPercentageSlider.minimumValue = 0
        tipPercentageSlider.maximumValue = 100
        
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
        
        
        let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String
        if let currencySymbol = currencySymbols[countryCode!] {
            currencyLabel.text = currencySymbol
        } else {
            currencyLabel.text = "$"
        }
        
        if (defaults.object(forKey: defaultTipPercentageKey) != nil) {
            let tipPercentage = defaults.integer(forKey: defaultTipPercentageKey)
            tipPercentageSlider.value = Float(tipPercentages[tipPercentage])
            tipPercentageChanged(tipPercentageSlider)
        }
        if (defaults.object(forKey: roundingPolicyKey) != nil) {
            roundingPolicyIndex = defaults.integer(forKey: roundingPolicyKey)
        }
        
        amountUpdated(billField)
    }
    
    @IBAction func tipPercentageChanged(_ sender: Any) {
        tipPercentageLabel.text = String(format: "%.0f", tipPercentageSlider.value)
        amountUpdated(billField)
    }
    
    @IBAction func amountUpdated(_ sender: AnyObject) {
        let billAmount = Double(billField.text!) ?? 0
        let tipPercentage = tipPercentageSlider.value
        let tip = billAmount * Double(tipPercentage/100.0)
        let total = billAmount + tip
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        
        tipLabel.text = formatter.string(from: tip as NSNumber);
        if (roundingPolicyIndex == 1) {
            totalLabel.text = String(format: "(%.0f)", ceil(total))
        } else if (roundingPolicyIndex == 2) {
            totalLabel.text = String(format: "(%.0f)", floor(total))
        } else {
            totalLabel.text = formatter.string(from: total as NSNumber);
        }
        
        // Persist the details
        let defaults = UserDefaults.standard
        
        defaults.set(billAmount, forKey: billAmountKey)
        defaults.set(Date(), forKey: savedDateKey)
        defaults.synchronize()
    }
}
