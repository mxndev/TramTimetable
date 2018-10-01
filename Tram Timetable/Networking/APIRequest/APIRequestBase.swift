//
//  APIRequestBase.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Alamofire

typealias Headers = [String: String]

protocol APIRequestBase {
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: Headers? { get }
    var parameters: Parameters? { get }
}
