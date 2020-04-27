//
//  ViewController.swift
//  CurrencyExchangeCalculator
//
//  Created by Daniel Golęba Frygies on 22/04:113.
//  Copyright © 2020 Tymon Golęba Frygies. All rights reserved.
//

import UIKit

class StartVC: UIViewController {
    
    @IBOutlet weak var toPicker: UIPickerView!
    @IBOutlet weak var pickCurrencyLabel: UILabel!
    
    
    var currencyCode: String = ""
    var rate = 0.0
    
    var dm = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        toPicker.delegate = self
        dm.delegate = self
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        if rate != 0.0 {
            performSegue(withIdentifier: "currenciesSegue", sender: self)
        } else {
            pickCurrencyLabel.textColor = .red
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let calcVC = segue.destination as! CalculateVC
        calcVC.currencyTaken = currencyCode
        calcVC.rate = rate
    }
}

//MARK: - PickerView Data Source
extension StartVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //indicates number of pickers in a view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // provides size of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dm.currenciesList.count
    }
    
    // provides row names
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dm.currenciesList[row]
    }
    
    //catches row name
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyCode = dm.currenciesList[row]
        dm.fetchData(currency: currencyCode)
    }
    
}

//MARK: - DataManager Delegate
extension StartVC: DataManagerDelegate {
    func didGrabData(_ dataMechanism: DataManager, dataSet: DataModel) {
        DispatchQueue.main.async {
            self.rate = dataSet.mid
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}




