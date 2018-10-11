//
//  UIViewController+TopMostController.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 11.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import UIKit

extension UIViewController {
    func topMostController() -> UIViewController {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        
        while (topController?.presentedViewController != nil) {
            topController = topController?.presentedViewController
        }
        
        return topController!
    }
}
