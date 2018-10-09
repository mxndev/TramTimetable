//
//  ViewController.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import UIKit

class MapScreenViewController: UIViewController {

    fileprivate var viewModel: MapScreenViewModelBase = MapScreenViewModel.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        
        // load timetable from server
        self.viewModel.loadTramStops()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func configureSubviews() {
    }
}
