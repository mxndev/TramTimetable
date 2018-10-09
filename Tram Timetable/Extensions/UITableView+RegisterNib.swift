//
//  UITableView+RegisterNib.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 09.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNib(name: String) {
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}
