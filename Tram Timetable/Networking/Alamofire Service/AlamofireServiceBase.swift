//
//  AlamofireServiceBase.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Alamofire

class AlamofireService: AlamofireServiceBase {
    
    // set up oauth2 handler to refresh connection
    public static let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        
        let manager = SessionManager(configuration: configuration)
        return manager
    }()
    
    private var alamofireRequest: DataRequest?
    
    func executeAlamofireRequest(request: APIRequestBase, completionHandler: @escaping (Int?, Data?, Error?) -> Void) {
        
        if AlamofireConnectivity.isConnected {
            let url = URL(string: request.path)
            
            alamofireRequest = AlamofireService.sessionManager.request(url!, method: request.method, parameters: request.parameters, encoding: JSONEncoding.default, headers: request.headers).validate().response { [completionHandler] (dataResponse: DefaultDataResponse) in
                
                print("PATH: \(request.path)")
                print("STATUS CODE: \((dataResponse.response?.statusCode ?? -1))")
                
                completionHandler(dataResponse.response?.statusCode, dataResponse.data, dataResponse.error)
            }
        } else {
            // error: no internet
            completionHandler(-1009, nil, NSError(domain: "io.spaceos.nointernet", code: -1009, userInfo: nil))
        }
    }
    
    func cancel() {
        alamofireRequest?.cancel()
    }
}
