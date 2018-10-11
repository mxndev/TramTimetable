//
//  NetworkResult.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

enum NetworkResultCode: Int
{
    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case JSONDecodingError = 0
    case APIError = -1
    case NoInternetConnection = -2
}

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkResultCode)
}

protocol NetworkResponseType { }
extension Data: NetworkResponseType {}

extension NetworkResponse where T: NetworkResponseType {
    
    func decodeData<U: Codable>() -> NetworkResponse<U> {
        switch self {
        case .success(let data):
            do {
                guard let data = data as? Data else {
                    return .failure(.APIError)
                }
                
                let object: U = try JSONDecoder().decode(U.self, from: data)
                return .success(object)
            } catch let jsonError {
                print("Error during JSON decoding: ", jsonError)
                return .failure(.APIError)
            }
        case .failure(let code):
            return .failure(code)
        }
    }
}
