//
//  RequestInterceptor.swift
//  thinkapp-ios
//
//  Created by MIrmuxammad on 16/09/22.
//
import Alamofire

final class RequestInterceptor: Alamofire.RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }

}
