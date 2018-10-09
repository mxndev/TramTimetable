//
//  APIRouter.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Alamofire

enum TramRouter {
    case getStops
}

extension TramRouter {

    var request: APIRequest {
        switch self {
            case .getStops:
//                let params: Parameters = ["grant_type":"password", "username":username, "password":password]
                return APIRequest(method: .get, type:.rawData, endpoint: "S3QwgEbf", parameters: nil, requiredAuthentication: false)
        }
    }
}
