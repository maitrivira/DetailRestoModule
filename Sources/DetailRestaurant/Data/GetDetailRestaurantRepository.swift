//
//  File.swift
//  
//
//  Created by Maitri Vira on 27/05/22.
//

import Core
import RxSwift

public struct GetDetailRestaurantRepository<
    RestaurantLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    RestaurantLocaleDataSource.Request == String,
    RestaurantLocaleDataSource.Response == DetailRestaurantDomainModel,
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == DetailRestaurantResponse,
    Transformer.Response == DetailRestaurantResponse,
    Transformer.Entity == DetailRestaurantModuleEntity,
    Transformer.Domain == DetailRestaurantDomainModel {
    
    public typealias Request = String
    public typealias Response = DetailRestaurantDomainModel

    private let _localeDataSource: RestaurantLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer

    public init(
        localeDataSource: RestaurantLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer){

        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> Observable<DetailRestaurantDomainModel> {
        return _remoteDataSource.getRestaurants(request: request).map { _mapper.transformResponseToDomain(response: $0) }
    }
    
}
