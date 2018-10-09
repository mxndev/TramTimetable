//
//  TimetableViewController.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 08.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TimetableViewController: UIViewController {
    
    @IBOutlet private weak var timetableView: UITableView!
    @IBOutlet private weak var timetableHeight: NSLayoutConstraint!
    
    let disposeBag = DisposeBag()
    
    fileprivate var viewModel: TimetableViewModelBase = TimetableViewModel.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        
        // load timetable from server
        self.viewModel.loadTimetable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.timetableHeight.constant = self.getTableViewHeight()
    }
    
    private func configureSubviews() {
        // register nib
        timetableView.registerNib(name: TimetableCell.timetableCellNib)
        
        timetableView.estimatedRowHeight = 80
        timetableView.rowHeight = UITableViewAutomaticDimension
        
        self.viewModel.timetable.asObservable()
            .bind(to: (timetableView?.rx.items(cellIdentifier: TimetableCell.timetableCellNib, cellType: TimetableCell.self))!) { (row, element, cell) in
                
                cell.hourLabel.text = element.hour
                
                element.minutes.asObservable()
                    .bind(to: (cell.minutesView?.rx.items(cellIdentifier: MinutesCell.minutesCellNib, cellType: MinutesCell.self))!) { (collectionRow, collectionElement, collectionCell) in
                        collectionCell.minutesLabel.text = collectionElement
                    }
                    .disposed(by: cell.disposeBag)

                cell.minutesViewHeight.constant = CGFloat(cell.calculateHeightOfMinutesView(of: element.minutes.value))
            }
            .disposed(by: disposeBag)
    }
}

extension TimetableViewController {
    func getTableViewHeight() -> CGFloat {
        return timetableView.contentSize.height
    }
}
