//
//  TimetableCell.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 07.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import UIKit

class TimetableCell: UITableViewCell {
    static let timetableCellNib = "TimetableCell"
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minutesView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
}

extension TimetableCell {
    fileprivate func setupLayout() {
    }
    
//    func fill(with item: NewsFeedItem) {
//        imagePath = item.photo?.scaledImage
//        descriptionViewContainer.subviews.forEach({ $0.removeFromSuperview() })
//
//        if let categoryType = item.category?.type, categoryType == NewsFeedCategoryType.event {
//            configureForEvent(item: item)
//        } else {
//            configureForNews(item: item)
//        }
//    }
}
