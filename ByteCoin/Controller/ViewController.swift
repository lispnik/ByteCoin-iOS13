//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    var coinManager = CoinManager()
    let defaultCurrency = "USD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        currencyLabel.text = defaultCurrency
        currencyPicker.selectRow(
            coinManager.currencyArray.firstIndex(of: defaultCurrency)!,
            inComponent: 0,
            animated: true)
        coinManager.getCoinPrice(for: defaultCurrency)
    }
}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }

    func pickerView(_: UIPickerView, didSelectRow: Int, inComponent: Int) {
        let currency: String = coinManager.currencyArray[didSelectRow]
        coinManager.getCoinPrice(for: currency)
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {

    func didFetchCoinPrice(rate: Double, currency: String) {
        bitcoinLabel.text = String(format: "%.2f", rate)
        currencyLabel.text = currency
    }
}
