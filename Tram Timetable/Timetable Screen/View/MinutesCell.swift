//
//  MinutesCell.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 07.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

class MinutesCell : UICollectionViewCell {
    static let minutesCellNib = "MinutesCell"
    
    @IBOutlet private weak var minutesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
}

extension MinutesCell {
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
