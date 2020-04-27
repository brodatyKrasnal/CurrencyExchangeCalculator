//
//  ResultVC.swift
//  CurrencyExchangeCalculator
//
//  Created by Daniel Golęba Frygies on 23/04:114.
//  Copyright © 2020 Tymon Golęba Frygies. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    
    @IBOutlet weak var amountToExchange: UILabel!
    @IBOutlet weak var toCurrencyLabel: UILabel!
    @IBOutlet weak var rateValueLabel: UILabel!
    @IBOutlet weak var amountCalculatedLabel: UILabel!
    
    var toCurrency: String = ""// taken from CalculateVC
    var amount: Double = 0.0 // taken from CalculateVC
    var amountExchanged: Double = 0.0 // taken from CalculateVC
    var rate: Double = 0.0 // taken from CalculateVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountToExchange.text = String(amount)
        toCurrencyLabel.text = toCurrency
        rateValueLabel.text = String(format: "%.3f",rate)
        amountCalculatedLabel.text = String(format: "%.3f",amountExchanged)
        
    }
    
    
    @IBAction func doneButton(_ sender: UIButton) {
        performSegue(withIdentifier: "returnToBegining", sender: self)
    }
    
    @IBAction func returnButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
