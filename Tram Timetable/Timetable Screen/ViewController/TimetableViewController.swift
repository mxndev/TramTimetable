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
    @IBOutlet private weak var lineNumberLabel: UILabel!
    @IBOutlet private weak var stopNameLabel: UILabel!
    @IBOutlet private weak var directionNameLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var loadingView: UIView!
    
    let disposeBag = DisposeBag()
    
    fileprivate var viewModel: TimetableViewModelBase = TimetableViewModel.instance
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.timetableHeight.constant = getTableViewHeight()
    }
    
    private func configureSubviews() {
        // register nib
        timetableView.registerNib(name: TimetableCell.timetableCellNib)
        
        closeButton.rx.tap
            .subscribe(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        timetableView.estimatedRowHeight = 80
        timetableView.rowHeight = UITableViewAutomaticDimension
        
        self.viewModel.timetable.asObservable()
            .bind(to: (timetableView?.rx.items(cellIdentifier: TimetableCell.timetableCellNib, cellType: TimetableCell.self))!) { (row, element, cell) in
                
                cell.hourLabel.text = element.hour
                
                element.minutes.asObservable()
                    .bind(to: (cell.minutesView?.rx.items(cellIdentifier: MinutesCell.minutesCellNib, cellType: MinutesCell.self))!) { (collectionRow, collectionElement, collectionCell) in
                        collectionCell.minutesLabel.text = collectionElement
                        
                        let timeNow = Date()
                        if (self.viewModel.calculateNextTramTime(currentTime: timeNow).0 == row) && (self.viewModel.calculateNextTramTime(currentTime: timeNow).01 == collectionRow) {
                            collectionCell.minutesView.backgroundColor = UIColor.green
                        } else {
                            collectionCell.minutesView.backgroundColor = UIColor.clear
                        }
                        
                    }
                    .disposed(by: cell.disposeBag)

                cell.minutesViewHeight.constant = CGFloat(cell.calculateHeightOfMinutesView(of: element.minutes.value))
                
                
            }
            .disposed(by: disposeBag)
    }
}

extension TimetableViewController {
    func getTableViewHeight() -> CGFloat {
        let maximumHeight = self.view.frame.height - self.timetableView.frame.origin.y
        return timetableView.contentSize.height > maximumHeight ? maximumHeight : timetableView.contentSize.height
    }
}

extension TimetableViewController: TimetableViewDelegate {
    func showActivityIndicator(loaded: Bool) {
        if loaded {
            loadingView.isHidden = true
            self.timetableHeight.constant = getTableViewHeight()
        } else {
            loadingView.isHidden = false
        }
    }
    
    func setStopInfo(stopName: String, direction: String, lineNumber: String) {
        lineNumberLabel.text = lineNumber
        stopNameLabel.text = stopName
        directionNameLabel.text = direction
    }
    
    func showLoadingError() {
        let alertController = UIAlertController(title: "Sorry, error during loading!", message: "Try again later.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        topMostController().present(alertController, animated: true)
    }
    
    func showNoInternetConnectionError() {
        let alertController = UIAlertController(title: "Sorry, no internet connection!", message: "Try again later.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        topMostController().present(alertController, animated: true)
    }
}
