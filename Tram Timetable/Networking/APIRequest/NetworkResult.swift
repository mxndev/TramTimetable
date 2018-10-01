//
//  NetworkResult.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

enum NetworkResponse<T> {
    case success(T)
    case failure(Int, Error?)
}

protocol NetworkResponseType { }
extension Data: NetworkResponseType {}

extension NetworkResponse where T: NetworkResponseType {
    
    func decodeData<U: Codable>() -> NetworkResponse<U> {
        switch self {
        case .success(let data):
            do {
                guard let data = data as? Data else {
                    return .failure(-1, nil)
                }
                
                let object: U = try JSONDecoder().decode(U.self, from: data)
                return .success(object)
            } catch let jsonError {
                print("Error during JSON decoding: ", jsonError)
                return .failure(-1, nil)
            }
        case .failure(let intCode, let error):
            return .failure(intCode, error)
        }
    }
}
