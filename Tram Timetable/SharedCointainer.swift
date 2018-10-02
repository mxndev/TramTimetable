//
//  SharedCointainer.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 03.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Swinject

class SharedContainer {
    static let sharedContainer = Container() { _ in }
}
