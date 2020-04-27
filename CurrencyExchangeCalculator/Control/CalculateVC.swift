//
//  CalculateViewController.swift
//  CurrencyExchangeCalculator
//
//  Created by Daniel Golęba Frygies on 23/04:114.
//  Copyright © 2020 Tymon Golęba Frygies. All rights reserved.
//

import UIKit

class CalculateVC: UIViewController {
    
    @IBOutlet weak var toCurrencyLabel: UILabel!
    @IBOutlet weak var amountToExchangeField: UITextField!
    
    var dm = DataManager()
    
    var currencyTaken: String = "" // from StartVC
    var rate = 0.0 // from StartVC
    
    var amountToExchange: Double = 0.0
    var amountExchanged = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toCurrencyLabel.text = dm.currencyName[currencyTaken]
        
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
         amountToExchnageFunc()
        performSegue(withIdentifier: "resultsSegue", sender: self)
        
    }
    
    func amountToExchnageFunc () {
        amountToExchange = Double(amountToExchangeField.text!)!
        if amountToExchangeField.text != "" {
            print(amountToExchange)
            print(rate)
            calculateAmount(amount: amountToExchange, rate: rate)
            print(amountExchanged)
        }
    }
    
    func calculateAmount (amount: Double, rate: Double) {
        amountExchanged = amount * rate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! ResultVC
        
        resultVC.toCurrency = currencyTaken
        resultVC.amount = amountToExchange
        resultVC.rate = rate
        resultVC.amountExchanged = amountExchanged
    }
    
    
    @IBAction func returnButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
//MARK: - TextField Delegate
extension CalculateVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountToExchnageFunc()
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            textField.endEditing(true)
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.endEditing(true)
    }
}
