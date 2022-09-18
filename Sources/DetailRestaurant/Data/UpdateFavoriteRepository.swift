//
//  File.swift
//  
//
//  Created by Maitri Vira on 18/09/22.
//

import Core
import RxSwift

public struct UpdateFavoriteRepository<
    RestaurantLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    RestaurantLocaleDataSource.Request == DetailRestaurantDomainModel,
    RestaurantLocaleDataSource.Response == DetailRestaurantModuleEntity,
    Transformer.Response == DetailRestaurantResponse,
    Transformer.Entity == DetailRestaurantModuleEntity,
    Transformer.Domain == DetailRestaurantDomainModel {
    
        public typealias Request = DetailRestaurantDomainModel
        public typealias Response = Bool
        
        private let _localeDataSource: RestaurantLocaleDataSource
        private let _mapper: Transformer
        
        public init(
            localeDataSource: RestaurantLocaleDataSource,
            mapper: Transformer){
                
            _localeDataSource = localeDataSource
            _mapper = mapper
        }
        
        public func execute(request: DetailRestaurantDomainModel?) -> Observable<Bool> {
            return _localeDataSource.addRestaurant(entities: _mapper.transformModelToEntity(request: request))
        }
}
