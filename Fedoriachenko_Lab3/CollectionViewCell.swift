//
//  CollectionViewCell.swift
//  Fedoriachenko_Lab3
//
//  Created by Yaroslav Fedoriachenko on 02.12.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    static let identifier = "MyCell"
    
    func setPhoto(photo: PhotoCollectionCell) {
        cellImage.image = photo.image
    }
    
}
