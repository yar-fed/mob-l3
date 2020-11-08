//
//  Movie.swift
//  Fedoriachenko_Lab3
//
//  Created by Yaroslav Fedoriachenko on 03.11.2020.
//

import Foundation
import UIKit


class Movie {
    var image: UIImage
    var title: String
    var year: String
    var type: String
    
    init (image: UIImage, title: String, year: String, type: String) {
        self.image = image
        self.title = title
        self.year = year
        self.type = type
    }
}
