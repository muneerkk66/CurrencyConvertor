//
//  ViewController.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 18/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import UIKit
private typealias ConvertorGridViewMethods = ConvertorVC
class ConvertorVC: UIViewController {
@IBOutlet var collectionView: UICollectionView!
@IBOutlet var primaryCurrencyView: CurrencyView!
@IBOutlet var secondaryCurrencyView: CurrencyView!
    var convertorVM = ConvertorVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        // Do any additional setup after loading the view.
        
        // Load Currency Data
        fetchCurrencyDetails()
       
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
                    weakSelf.convertorVM.currencyRateList = response.payload.rates
                    
                    weakSelf.loadCurrencyDetails()
                    
                } catch {
                    print(error)
                }
                
                
                
            }
        })
    }
    fileprivate func loadCurrencyDetails() {
        guard var primaryCurrency = convertorVM.currencyRateList.first else {
            return
        }
        if let primaryImageName =  convertorVM.getCountryFlagImage(from: primaryCurrency.code){
             primaryCurrency.imageString = primaryImageName
        }
        primaryCurrencyView.setCurrency(primaryCurrency)
        
        guard var secondaryCurrency = convertorVM.getSecondaryCurrencyObject(convertorVM.currencyRateList) else {
            return
        }
        if let secondaryImageName =  convertorVM.getCountryFlagImage(from: secondaryCurrency.code){
             secondaryCurrency.imageString = secondaryImageName
        }

        secondaryCurrencyView.setCurrency(secondaryCurrency)
    }


}
extension ConvertorGridViewMethods : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return convertorVM.menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Menu", for: indexPath) as! MenuCollectionViewCell
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

