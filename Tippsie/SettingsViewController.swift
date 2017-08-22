//
//  SettingsViewController.swift
//  Tippsie
//
//  Created by Ravi Mandala on 8/20/17.
//  Copyright © 2017 Ravi Mandala. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let defaultTipPercentageKey = "default_tip_segment"
    let currencySymbolKey = "currency_symbol_index"
    
    @IBOutlet weak var defaultTipPercentage: UISegmentedControl!
    @IBOutlet weak var currencySymbolSegControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        if (defaults.object(forKey: defaultTipPercentageKey) != nil) {
            let segIndex = defaults.integer(forKey: defaultTipPercentageKey)
            defaultTipPercentage.selectedSegmentIndex = segIndex
        }
        if (defaults.object(forKey: currencySymbolKey) != nil) {
            let currencySymbolIndex = defaults.integer(forKey: currencySymbolKey)
            currencySymbolSegControl.selectedSegmentIndex = currencySymbolIndex
        }
    }
    
    @IBAction func persistDefaultTipPercentage(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        defaults.set(defaultTipPercentage.selectedSegmentIndex, forKey: defaultTipPercentageKey)
        defaults.set(currencySymbolSegControl.selectedSegmentIndex, forKey: currencySymbolKey)
        defaults.synchronize()
    }
}
