//
//  File.swift
//  
//
//  Created by Maitri Vira on 27/05/22.
//

import Core
import RealmSwift

public struct CustomerTransformer: Mapper {
    
    public typealias Request = DetailRestaurantDomainModel
    public typealias Response = DetailRestaurantResponse
    public typealias Entity = List<CustomerReviewsEntity>
    public typealias Domain = [CustomerReviews]
    
    public init() { }
    
    public func transformResponseToEntity(response: DetailRestaurantResponse) -> List<CustomerReviewsEntity> {
        let newCustomer = List<CustomerReviewsEntity>()
        
        for item in response.customerReviews {
            let customerEntity = CustomerReviewsEntity()
            customerEntity.name = item.name ?? ""
            customerEntity.review = item.review ?? ""
            customerEntity.date = item.date ?? ""
        }
        
        return newCustomer
    }
    
    public func transformModelToEntity(request: DetailRestaurantDomainModel) -> List<CustomerReviewsEntity> {
        let newCustomer = List<CustomerReviewsEntity>()
        
        for item in request.customerReviews {
            let customerEntity = CustomerReviewsEntity()
            customerEntity.name = item.name ?? ""
            customerEntity.review = item.review ?? ""
            customerEntity.date = item.date ?? ""
        }
        
        return newCustomer
    }
    
    public func transformEntityToDomain(entity: List<CustomerReviewsEntity>) -> [CustomerReviews] {
        return entity.map { result in
            return CustomerReviews(name: result.name, review: result.review, date: result.date)
        }
    }
    
    public func transformResponseToDomain(response: DetailRestaurantResponse) -> [CustomerReviews] {
        return response.customerReviews.map { result in
            return CustomerReviews(name: result.name, review: result.review, date: result.date)
        }
    }
    
    public func transformDomainToEntity(domain: [CustomerReviews]) -> List<CustomerReviewsEntity> {
        let newCustomer = List<CustomerReviewsEntity>()
        
        for item in domain {
            let customerEntity = CustomerReviewsEntity()
            customerEntity.name = item.name ?? ""
            customerEntity.review = item.review ?? ""
            customerEntity.date = item.date ?? ""
        }
        
        return newCustomer
    }
    
}
