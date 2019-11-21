//
//  MenuCollectionViewCell.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 19/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet var menuImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    func configureCell(_ title:String,_ imageString:String){
        menuImageView.image = UIImage.init(named: imageString)
        titleLabel.text = title
    }
}
