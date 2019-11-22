//
//  CurrencyListVC.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 21/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import UIKit

//MARK: Delegate method for currecny selection
protocol CurrencyListTableViewCellDelegate:class {
    
    func didSelectCurrency(currency:CurrencyRate)
}
private typealias CurrencyListVCTableViewMethods = CurrencyListVC
private typealias Constants = CurrencyListVC
class CurrencyListVC: UIViewController {
@IBOutlet weak var currencyListTableView: UITableView!
    weak var delegate:CurrencyListTableViewCellDelegate?
    var convertorVM:ConvertorVM = ConvertorVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: - Tableview Methods
extension CurrencyListVCTableViewMethods:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currencyCell =  currencyListTableView.dequeueReusableCell(withIdentifier:"currencyCell") as! CurrencyTableViewCell
        currencyCell.configureCell(convertorVM.currencyUpdatedRateList[indexPath.row])
        return currencyCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return convertorVM.currencyUpdatedRateList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
      
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let selectedCurrency = convertorVM.currencyUpdatedRateList[indexPath.row]
        self.delegate?.didSelectCurrency(currency: selectedCurrency)
        self.dismiss(animated: true, completion: nil)
           
    }
}
//MARK: - Tableview Constants
extension Constants {
    struct Constants {
        static let rowHeight:CGFloat = 60.0
    }
}
