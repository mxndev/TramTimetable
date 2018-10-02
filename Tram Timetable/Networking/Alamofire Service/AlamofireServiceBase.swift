//
//  AlamofireServiceBase.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Alamofire

protocol AlamofireServiceBase {
    func executeAlamofireRequest(request: APIRequestBase, completionHandler: @escaping (Int?, Data?, Error?) -> Void)
    func cancel()
}

extension AlamofireServiceBase {
    static var instance: AlamofireServiceBase {
        guard let resolved = SharedContainer.sharedContainer.resolve(AlamofireServiceBase.self) else {
            let service = AlamofireService()
            SharedContainer.sharedContainer.register(AlamofireServiceBase.self) { [service] _ in
                service
            }
            return service
        }
        return resolved
    }
}

extension AlamofireServiceBase {
    // retrieve executed request to appriopriate response status
    func executeRequest(request: APIRequestBase, completionHandler: @escaping (NetworkResponse<Data>) -> Void) {
        
        executeAlamofireRequest(request: request) { [completionHandler] (statusCode: Int?, data: Data?, error: Error?) in
            if let statusCode = statusCode {
                if let data = data, statusCode < 300 {
                    completionHandler(.success(data))
                } else {
                    completionHandler(.failure(statusCode, error))
                }
            } else {
                completionHandler(.failure(500, error))
            }
        }
    }
}
