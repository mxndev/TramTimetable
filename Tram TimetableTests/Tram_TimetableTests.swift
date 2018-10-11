//
//  Tram_TimetableTests.swift
//  Tram TimetableTests
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import XCTest
@testable import Tram_Timetable
import CoreLocation
import RxSwift

class Tram_TimetableTests: XCTestCase {
    
    fileprivate var mapScreenViewModel: MapScreenViewModelBase = MapScreenViewModel.instance
    fileprivate var timetableScreenViewModel: TimetableViewModelBase = TimetableViewModel.instance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test1CalculateClosestStop() {
        // prepare data
        var stops: [Stops] = []
        stops.append(Stops(direction: "Banacha", latitude: 23.01, longitude: 23.02, line: "35", name: "Banacha 1", stopID: "1"))
        stops.append(Stops(direction: "Banacha", latitude: 24.01, longitude: 24.02, line: "35", name: "Banacha 1", stopID: "2"))
        stops.append(Stops(direction: "Banacha", latitude: 25.01, longitude: 25.02, line: "35", name: "Banacha 1", stopID: "3"))
        stops.append(Stops(direction: "Banacha", latitude: 27.01, longitude: 27.02, line: "35", name: "Banacha 1", stopID: "4"))
        
        // set view model data
        mapScreenViewModel.stops = stops
        mapScreenViewModel.currentLocation = CLLocationCoordinate2D(latitude: 26.5, longitude: 26.5)
        mapScreenViewModel.calculateClosestStop()

        XCTAssertEqual(mapScreenViewModel.closestStop, "4", "Calculate closest stop seems to be wrong")
    }
    
    func test2AddNewRecordToTimetable() {
        // prepare data
        var timetable: [TimetableRow] = []
        timetable.append(TimetableRow(hour: "07", minutes: Variable(["06", "15", "46"])))
        timetable.append(TimetableRow(hour: "11", minutes: Variable(["12", "25", "38"])))
        timetable.append(TimetableRow(hour: "14", minutes: Variable(["03", "07", "13"])))
        
        // set view model data
        timetableScreenViewModel.timetable.value = timetable
        
        timetableScreenViewModel.addNewRecordToTimetable(hour: "11", minutes: "56")
        XCTAssertEqual(timetableScreenViewModel.timetable.value.count, 3, "Putting new timetable record seems to be wrong")
        XCTAssertEqual(timetableScreenViewModel.timetable.value[1].minutes.value.count, 4, "Putting new timetable record seems to be wrong")
        
        timetableScreenViewModel.addNewRecordToTimetable(hour: "18", minutes: "15")
        XCTAssertEqual(timetableScreenViewModel.timetable.value.count, 4, "Putting new timetable record seems to be wrong")
        XCTAssertEqual(timetableScreenViewModel.timetable.value[3].minutes.value.count, 1, "Putting new timetable record seems to be wrong")
    }
    
    func test3ConvertToTimetable() {
        // prepare data
        var warsawTimetable: [WarsawTimetable] = []
        warsawTimetable.append(WarsawTimetable(values: [WarsawTimetableKV(value: "04:32", key: "czas")]))
        warsawTimetable.append(WarsawTimetable(values: [WarsawTimetableKV(value: "05:12", key: "czas")]))
        warsawTimetable.append(WarsawTimetable(values: [WarsawTimetableKV(value: "05:27", key: "czas")]))
        warsawTimetable.append(WarsawTimetable(values: [WarsawTimetableKV(value: "05:58", key: "czas")]))
        warsawTimetable.append(WarsawTimetable(values: [WarsawTimetableKV(value: "06:03", key: "czas")]))
        warsawTimetable.append(WarsawTimetable(values: [WarsawTimetableKV(value: "06:46", key: "czas")]))
        warsawTimetable.append(WarsawTimetable(values: [WarsawTimetableKV(value: "07:24", key: "czas")]))
        
        // set view model data
        timetableScreenViewModel.convertToTimetableRow(warsawTimetable: warsawTimetable)
        
        XCTAssertEqual(timetableScreenViewModel.timetable.value.count, 4, "Generating timetable from raw data seems to be wrong")
        XCTAssertEqual(timetableScreenViewModel.timetable.value[1].minutes.value.count, 3, "Generating timetable from raw data seems to be wrong")
    }
    
    func test4CalculateClosestTime() {
        // prepare data
        var timetable: [TimetableRow] = []
        timetable.append(TimetableRow(hour: "07", minutes: Variable(["06", "15", "46"])))
        timetable.append(TimetableRow(hour: "11", minutes: Variable(["12", "25", "38"])))
        timetable.append(TimetableRow(hour: "14", minutes: Variable(["03", "07", "13"])))
        
        // set view model data
        timetableScreenViewModel.timetable.value = timetable
        
        // set appropriate time
        let timeNow = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pl_PL")
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: timeNow)
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let currentFullDate = formatter.date(from: String(format: "%@ %@:%@", currentDate, "13", "38"))
        
        XCTAssertEqual(timetableScreenViewModel.calculateNextTramTime(currentTime: currentFullDate!).0, 2, "Calculating closest time seems to be wrong")
        XCTAssertEqual(timetableScreenViewModel.calculateNextTramTime(currentTime: currentFullDate!).1, 0, "Calculating closest time seems to be wrong")
    }
}
