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
    let type: APIType
    let path: String
    var headers: Headers?
    let parameters: Parameters?
}

extension APIRequest {
    
    init(method: HTTPMethod, type: APIType, endpoint: String, parameters: Parameters? = nil, requiredAuthentication: Bool) {
        var path: String
        switch type {
            case .rawData: 
                path = Constants.Networking.RawDataAPI.host + "/" + Constants.Networking.RawDataAPI.version + "/" + endpoint
            case .warsawAPI:
                path = Constants.Networking.WarsawAPI.host + "/" + Constants.Networking.WarsawAPI.version + "/" + endpoint
        }
        
        self.init(method: method, type: type, path: path, headers: nil, parameters: parameters)
    }
}
