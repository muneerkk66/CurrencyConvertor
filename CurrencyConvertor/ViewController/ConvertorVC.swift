//
//  ViewController.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 18/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import UIKit
import FittedSheets
private typealias ConvertorGridViewMethods = ConvertorVC
class ConvertorVC: UIViewController,UITextFieldDelegate,currencyListTableViewCellDelegate {
@IBOutlet var collectionView: UICollectionView!
@IBOutlet var primaryCurrencyView: CurrencyView!
@IBOutlet var secondaryCurrencyView: CurrencyView!
@IBOutlet var baseCurrencyLabel: UILabel!
    
    //MARK: - Currency TextField Enum
    enum EdittedCurrency: Int {
        case primaryCurrency  = 0
        case secondayCurrency
    }
    var edittedCurrency:EdittedCurrency = .primaryCurrency
    var convertorVM = ConvertorVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUIComponents()
        
        // Load Currency Data
        fetchCurrencyDetails()
    }
    fileprivate func initializeUIComponents(){
        guard let primaryCurrency = convertorVM.getPrimaryCurrencyObject() else {
            return
        }
        convertorVM.currencyBaseRateList.append(primaryCurrency)
        primaryCurrencyView.setCurrency(primaryCurrency)
        
    }
    fileprivate func fetchCurrencyDetails() {
        convertorVM.fetchCurrencyDetails(onCompletion: { [weak self](responseObject, errorObject) -> () in
            guard let weakSelf = self else {
                return
            }
            DispatchQueue.main.async(execute: { [weak self]() -> Void in
               // MBProgressHUD.hideAllHUDs(for: self?.view, animated: true)
            })
            if let _ = errorObject {
                let error = errorObject! as NSError
               
            }
            else {
                do {
                    let response = try JSONDecoder().decode(ConvertorResponse.self, from: responseObject as! Data)
                    weakSelf.convertorVM.currencyBaseRateList.append(contentsOf: response.payload.rates)
                    weakSelf.convertorVM.currencyUpdatedRateList =  weakSelf.convertorVM.currencyBaseRateList
                    guard let primaryCurrency = weakSelf.convertorVM.currencyUpdatedRateList.first else {
                        return
                    }
                    weakSelf.loadCurrencyDetails(from: primaryCurrency)
                    
                } catch {
                    print(error)
                }
                
                
                
            }
        })
    }
    fileprivate func loadCurrencyDetails(from currency:CurrencyRate) {
        
        
        guard let primaryCurrency = convertorVM.currencyUpdatedRateList.first else {
            return
        }
        if currency.code != primaryCurrency.code {
            primaryCurrencyView.setCurrency(primaryCurrency)
        }
            
        
        guard let secondaryCurrency = convertorVM.getSecondaryCurrencyObject(&convertorVM.currencyUpdatedRateList) else {
            return
        }
        if currency.code != secondaryCurrency.code {
            secondaryCurrencyView.setCurrency(secondaryCurrency)
        }
        
        baseCurrencyLabel.text = "\(primaryCurrency.rate.roundTo(places: AppConstants.currencyDecimal))" + " " + "\(primaryCurrency.code)" + "=" + "\(secondaryCurrency.rate.roundTo(places: AppConstants.currencyDecimal))" + " " + "\(secondaryCurrency.code)"
    }
    fileprivate func updateCurrencyRate(with value:Double, type:EdittedCurrency){
        var currency: CurrencyRate
        if type == .primaryCurrency {
            currency = convertorVM.getPrimaryCurrencyObject()!
        } else {
            currency = convertorVM.getSecondaryCurrencyObject(&convertorVM.currencyUpdatedRateList)!
        }
        currency.rate = value
        let updatedList = convertorVM.updateCurrencyListWithReference(currency, currencylist: convertorVM.currencyBaseRateList)
        convertorVM.currencyUpdatedRateList = updatedList
        loadCurrencyDetails(from:currency)
    }
    @IBAction func loadCurrencyList(){
        let storyboard : UIStoryboard = UIStoryboard(name:StoryboardName.main.rawValue, bundle: Bundle.main)
       let currencyListVC = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifier.currencyListVCID.rawValue) as! CurrencyListVC
       currencyListVC.convertorVM = convertorVM
        currencyListVC.delegate = self
       let controller = SheetViewController(controller: currencyListVC, sizes: [.fixed(AppConstants.screenHeight), .fullScreen])
       self.present(controller, animated: true, completion: nil)

    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let textFieldString = textField.text, let swtRange = Range(range, in: textFieldString) {
            var inputText = textFieldString.replacingCharacters(in: swtRange, with: string)
            if inputText.count == 0{
                inputText = "0.0"
            }
                
            guard let inputNumber = Double(inputText) else {
                return true
            }
            if textField == primaryCurrencyView.rateField {
                edittedCurrency = .primaryCurrency
            }else{
                edittedCurrency = .secondayCurrency
            }
            updateCurrencyRate(with: inputNumber,type:edittedCurrency)
           
        }

        

       
        return true
    }
    func didSelectCurrency(currency:CurrencyRate){
        let index = convertorVM.currencyUpdatedRateList.firstIndex { (obj) -> Bool in
            obj.code == currency.code
        }!
        convertorVM.currencyUpdatedRateList.remove(at: index)
        convertorVM.currencyUpdatedRateList.insert(currency, at: 1)
        let currencyBase = convertorVM.currencyBaseRateList.filter{$0.code == currency.code}.first
        convertorVM.currencyBaseRateList.remove(at: index)
        convertorVM.currencyBaseRateList.insert(currencyBase!, at: 1)
        guard let secondaryCurrency = convertorVM.getSecondaryCurrencyObject(&convertorVM.currencyUpdatedRateList) else {
            return
        }
        secondaryCurrencyView.setCurrency(secondaryCurrency)
        
        
    }


}
extension ConvertorGridViewMethods : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return convertorVM.menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.menuCellID.rawValue, for: indexPath) as! MenuCollectionViewCell
        cell.configureCell(convertorVM.menuTitles[indexPath.row],convertorVM.menuImages[indexPath.row])
        return cell
    }
    
    //MARK: - Collection view flow layout delegate methods -


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 2.0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 0.0
    }
}


