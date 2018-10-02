//
//  APIRequest.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Alamofire

struct APIRequest: APIRequestBase {
    let method: HTTPMethod
    let path: String
    var headers: Headers?
    let parameters: Parameters?
}

extension APIRequest {
    
    init(method: HTTPMethod, endpoint: String, parameters: Parameters? = nil, requiredAuthentication: Bool) {
//        let path = UPNConfig.baseURL().absoluteString + UPNConfig.baseAPIURL().path + "/" + endpoint
        self.init(method: method, path: endpoint, headers: nil, parameters: parameters)
    }
}
