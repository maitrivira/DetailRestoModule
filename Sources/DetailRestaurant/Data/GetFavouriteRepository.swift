//
//  File.swift
//  
//
//  Created by Maitri Vira on 18/09/22.
//

import Core
import RxSwift

public struct GetFavouriteRepository<
    RestaurantLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    RestaurantLocaleDataSource.Response == DetailRestaurantModuleEntity,
    Transformer.Response == [DetailRestaurantResponse],
    Transformer.Entity == [DetailRestaurantModuleEntity],
    Transformer.Domain == [DetailRestaurantDomainModel] {
    
        public typealias Request = Any
        public typealias Response = [DetailRestaurantDomainModel]
        
        private let _localeDataSource: RestaurantLocaleDataSource
        private let _mapper: Transformer
        
        public init(
            localeDataSource: RestaurantLocaleDataSource,
            mapper: Transformer){
                
            _localeDataSource = localeDataSource
            _mapper = mapper
        }
    
        public func execute(request: Any?) -> Observable<[DetailRestaurantDomainModel]> {
            return _localeDataSource.getRestaurants()
                .map { _mapper.transformEntityToDomain(entity: $0) }
        }
        
    }
