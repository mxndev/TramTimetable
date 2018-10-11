//
//  TimetableCell.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 07.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import UIKit
import RxSwift

class TimetableCell: UITableViewCell {
    static let timetableCellNib = "TimetableCell"
    static let timetableHourWidth: CGFloat = 40
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minutesView: UICollectionView!
    @IBOutlet weak var hoursViewWidth: NSLayoutConstraint!
    @IBOutlet weak var minutesViewHeight: NSLayoutConstraint!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}

extension TimetableCell {
    fileprivate func setupLayout() {
        // register nib
        minutesView.registerNib(name: MinutesCell.minutesCellNib)
        
        hoursViewWidth.constant = TimetableCell.timetableHourWidth
    }
    
    func calculateHeightOfMinutesView(of elements:[String]) -> Int {
        let widthOfMinutesView = self.frame.size.width - TimetableCell.timetableHourWidth
        
        var lineWidth: CGFloat = 0
        let sizeOfCell: CGFloat = 36
        var height = sizeOfCell
        
        for _ in elements {
            lineWidth += sizeOfCell
            if lineWidth > widthOfMinutesView {
                height += sizeOfCell
                lineWidth = sizeOfCell
            }
        }
        return Int(height)
    }
}
