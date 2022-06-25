//
//  File.swift
//  
//
//  Created by Maitri Vira on 27/05/22.
//

import Core
import RxSwift
import Alamofire
import Foundation

public struct DetailRemoteDataSource: DataSource {
    
    public typealias Request = String
    public typealias Response = DetailRestaurantResponse
    
    private let _endpoint: String
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func getRestaurants(request: String?) -> Observable<DetailRestaurantResponse> {
        return Observable<DetailRestaurantResponse>.create { observer in
            
            var urls = _endpoint
            
            if let request = request {
                let newRequest = request.replacingOccurrences(of: " ", with: "%20")
                urls = _endpoint + newRequest
            }
            
            if let url = URL(string: urls) {
                AF.request(url,encoding: URLEncoding.httpBody)
                    .validate()
                    .responseDecodable(of: DetailRestaurantsResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            print("success get restaurants module")
                            observer.onNext(value.restaurant)
                            observer.onCompleted()
                        case .failure:
                            print("failure detail")
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
}
