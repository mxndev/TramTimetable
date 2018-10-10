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
    case getTimetable(stopID: String, stopNr: String, line: String)
}

extension TramRouter {

    var request: APIRequest {
        switch self {
            case .getStops:
                return APIRequest(method: .get, type:.rawData, endpoint: "S3QwgEbf", parameters: nil, requiredAuthentication: false)
            case .getTimetable(let stopID, let stopNr, let line):
                return APIRequest(method: .get, type:.warsawAPI, endpoint: "dbtimetable_get/?id=e923fa0e-d96c-43f9-ae6e-60518c9f3238&apikey=" + Constants.Networking.WarsawAPI.key + "&busstopId=" + stopID + "&busstopNr=" + stopNr + "&line=" + line, parameters: nil, requiredAuthentication: false)
        }
    }
}
