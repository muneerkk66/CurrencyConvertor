//
//  ViewController.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 18/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//
//MARK:- primaryCurrencyView ---Default Country Currency
//MARK:- secondaryCurrencyView ---Converted Currency

import UIKit
import FittedSheets
private typealias ConvertorGridViewMethods = ConvertorVC
private typealias TextFieldDelegateMethods = ConvertorVC
private typealias CurrencyListDelegateMethods = ConvertorVC
class ConvertorVC: UIViewController {
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
        
        //MARK:- Load Initial Setup
        initializeUIComponents()
        
        //MARK:- Load Currency Data from server
        fetchCurrencyDetails()
    }
    //MARK:- Initial Setup
    fileprivate func initializeUIComponents(){
        guard let primaryCurrency = convertorVM.getPrimaryCurrencyObject() else {
            return
        }
        convertorVM.currencyBaseRateList.append(primaryCurrency)
        primaryCurrencyView.setCurrency(primaryCurrency)
        
    }
     //MARK:- API CALL to fetch the latest currency details
    fileprivate func fetchCurrencyDetails() {
        convertorVM.fetchCurrencyDetails(onCompletion: { [weak self](responseObject, errorObject) -> () in
            guard let weakSelf = self else {
                return
            }
            if let _ = errorObject {
                // Show the default Error Alert here.
            }
            else {
                do {
                    // We have used Codable & Decodable for json encoding & decoding
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
     //MARK:- Set Currency Details into the UI component.
     // MARK:- There are two currency view one for Default Country and other for secondary currency.
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
     //MARK:- Update the Currency list with reference of the user input
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
     //MARK:- Navigation to the list view
     //MARK: - SheetViewController is the custom Animation class .Please refere more details on the Utilities/ConvertorLicense.txt
    @IBAction func loadCurrencyList(){
        let storyboard : UIStoryboard = UIStoryboard(name:StoryboardName.main.rawValue, bundle: Bundle.main)
       let currencyListVC = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifier.currencyListVCID.rawValue) as! CurrencyListVC
       currencyListVC.convertorVM = convertorVM
        currencyListVC.delegate = self
       let controller = SheetViewController(controller: currencyListVC, sizes: [.fixed(AppConstants.screenHeight), .fullScreen])
       self.present(controller, animated: true, completion: nil)

    }
    

}
//MARK:- CurrencyListVC Did select currency delegate method.
//MARK:- Update the currencyBaseRateList & currencyUpdatedRateList with reference of selected secondary currency
//MARK:- We kept the primary currency as index 0 and secondary currency as index 1
extension CurrencyListDelegateMethods:CurrencyListTableViewCellDelegate {
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
//MARK:- Text field Edit delegate method.
//MARK:- We keep on updatin the currency when user edit the primary or secondary currency
//MARK:- When input is empty we treat as ZERO value (line number 146)
extension TextFieldDelegateMethods : UITextFieldDelegate {
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
}
//MARK: - Collection view delegate methods -
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


