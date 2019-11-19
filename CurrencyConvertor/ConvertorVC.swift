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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
extension ConvertorGridViewMethods : UICollectionViewDelegate,UICollectionViewFlowLayout,UICollectionViewDataSource{
    //MARK: - Collection view flow layout delegate methods -

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
      let screenSize = UIScreen.mainScreen().bounds
      let screenWidth = screenSize.width
      let cellSquareSize: CGFloat = screenWidth / 2.0
      return CGSizeMake(cellSquareSize, cellSquareSize);
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
       return UIEdgeInsetsMake(0, 0, 0.0, 0.0)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
       return 0.0
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
       return 0.0
    }
}

