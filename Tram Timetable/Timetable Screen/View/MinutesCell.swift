//
//  MinutesCell.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 07.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import UIKit

class MinutesCell: UICollectionViewCell {
    static let minutesCellNib = "MinutesCell"
    
    @IBOutlet weak var minutesView: UIView!
    @IBOutlet weak var minutesLabel: UILabel!
}
