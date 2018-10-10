//
//  TramService.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

protocol TramServicesProtocol {
    func stopsService(completionHandler: @escaping (NetworkResponse<StopsResponse>) -> Void)
}

extension TramServicesProtocol {
    static var instance: TramServicesProtocol {
        guard let resolved = SharedContainer.sharedContainer.resolve(TramServicesProtocol.self) else {
            let service = TramServices()
            SharedContainer.sharedContainer.register(TramServicesProtocol.self) { [service] _ in
                service
            }
            return service
        }
        return resolved
    }
}

class TramServices: TramServicesProtocol {
    
    private let alamofireService: AlamofireServiceBase = AlamofireService.instance
    
    func stopsService(completionHandler: @escaping (NetworkResponse<StopsResponse>) -> Void) {
        let stopsRequest = TramRouter.getStops.request
        alamofireService.executeRequest(request: stopsRequest) { (result: NetworkResponse<Data>) in
            let serializedResult: NetworkResponse<StopsResponse> = result.decodeData()
            completionHandler(serializedResult)
        }
    }
}
