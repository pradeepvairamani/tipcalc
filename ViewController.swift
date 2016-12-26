//
//  ViewController.swift
//  tipcalc
//
//  Created by Pradeep Vairamani on 12/22/16.
//  Copyright © 2016 Pradeep Vairamani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var amtController: UISegmentedControl!
    @IBOutlet weak var spinnerController: UIStepper!
    @IBOutlet weak var amtPerPerson: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let defaultVal = defaults.value(forKey: "default_tip")
        if(defaultVal != nil){
            let intDefaultVal = defaults.value(forKey: "default_tip") as! Int
            amtController.selectedSegmentIndex = intDefaultVal

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        let defaultVal = defaults.value(forKey: "default_tip")
        if(defaultVal != nil){
            let intDefaultVal = defaults.value(forKey: "default_tip") as! Int
            amtController.selectedSegmentIndex = intDefaultVal
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSpinnerChange(_ sender: Any) {
        OnBillChange(sender)
        mainView.endEditing(true)
    }

    @IBAction func onSegmentChange(_ sender: Any) {
        OnBillChange(sender)
        mainView.endEditing(true)
    }
    @IBAction func OnBillChange(_ sender: Any) {
        let tipValuesArray = [15.0, 20.0, 25.0]
        let billValue = Double(billField.text!) ?? 0
        let tipPercentatge = tipValuesArray[amtController.selectedSegmentIndex]
        let tipValue = (billValue * tipPercentatge)/100
        tipLabel.text = String(format: "$%.2f", tipValue)
        let totalValue = billValue + tipValue
        totalLabel.text = String(format: "$%.2f", totalValue)
        
        // Logic to split bill
        let noSplits = Int(spinnerController.value)
        if (noSplits == 1) {
            splitLabel.text = String("Not splitting the bill with anyone ")
        }
        else{
            splitLabel.text = "Splitting the bill among " + String(noSplits) + " people"
        }
        let perPersonVal = Double(totalValue/Double(noSplits))
        amtPerPerson.text = String(format: "$%.2f", perPersonVal)
        
    }
    
}

