//
//  TramService.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

protocol TramServicesProtocol {
//    func tokenService(username: String, password: String, completionHandler: @escaping (NetworkResponse<TokenInfo>) -> Void)
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
    
//    func tokenService(username: String, password: String, completionHandler: @escaping (NetworkResponse<TokenInfo>) -> Void) {
//        let tokenRequest = APIRouter.getToken(username: username, password: password).request
//        alamofireService.executeRequest(request: tokenRequest) { (result: NetworkResponse<Data>) in
//            let serializedResult: NetworkResponse<TokenInfo> = result.decodeData()
//            completionHandler(serializedResult)
//        }
//    }
}
