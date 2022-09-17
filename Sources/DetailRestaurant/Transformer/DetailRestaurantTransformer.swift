//
//  File.swift
//  
//
//  Created by Maitri Vira on 26/05/22.
//

import Core
import RealmSwift

public struct DetailRestaurantTransformer<CategoryMapper: Mapper, MenusMapper: Mapper, CustomerMapper: Mapper>: Mapper
where

    CategoryMapper.Request == String,
    CategoryMapper.Response == DetailRestaurantResponse,
    CategoryMapper.Entity == List<CategoryEntity>,
    CategoryMapper.Domain == [Categories],

    MenusMapper.Request == String,
    MenusMapper.Response == DetailRestaurantResponse,
    MenusMapper.Entity == List<MenusEntity>,
    MenusMapper.Domain == Menus,

    CustomerMapper.Request == String,
    CustomerMapper.Response == DetailRestaurantResponse,
    CustomerMapper.Entity == List<CustomerReviewsEntity>,
    CustomerMapper.Domain == [CustomerReviews]{
    
    public typealias Request = String
    public typealias Response = DetailRestaurantResponse
    public typealias Entity = DetailRestaurantModuleEntity
    public typealias Domain = DetailRestaurantDomainModel
        
    private let _categoriesMapper: CategoryMapper
    private let _menusMapper: MenusMapper
    private let _customerMapper: CustomerMapper

    public init(categoriesMapper: CategoryMapper, menusMapper: MenusMapper, customerMapper: CustomerMapper) {
        _categoriesMapper = categoriesMapper
        _menusMapper = menusMapper
        _customerMapper = customerMapper
    }
    
    public func transformResponseToEntity(response: DetailRestaurantResponse) -> DetailRestaurantModuleEntity {
        
        let categories = _categoriesMapper.transformResponseToEntity(response: response)
        let menus = _menusMapper.transformResponseToEntity(response: response)
        let customer = _customerMapper.transformResponseToEntity(response: response)
        
        let newDetail = DetailRestaurantModuleEntity()
        newDetail.id = response.id ?? ""
        newDetail.name = response.name ?? ""
        newDetail.descriptions = response.descriptions ?? ""
        newDetail.pictureId = response.pictureId ?? ""
        newDetail.city = response.city ?? ""
        newDetail.address = response.address ?? ""
        newDetail.rating = response.rating ?? 0.0
        newDetail.categories = categories
        newDetail.menus = menus
        newDetail.customerReviews = customer
        return newDetail
    }
    
    public func transformModelToEntity(response: DetailRestaurantResponse) -> DetailRestaurantModuleEntity {
        
        let categories = _categoriesMapper.transformResponseToEntity(response: response)
        let menus = _menusMapper.transformResponseToEntity(response: response)
        let customer = _customerMapper.transformResponseToEntity(response: response)
        
        let newDetail = DetailRestaurantModuleEntity()
        newDetail.id = response.id ?? ""
        newDetail.name = response.name ?? ""
        newDetail.descriptions = response.descriptions ?? ""
        newDetail.pictureId = response.pictureId ?? ""
        newDetail.city = response.city ?? ""
        newDetail.address = response.address ?? ""
        newDetail.rating = response.rating ?? 0.0
        newDetail.categories = categories
        newDetail.menus = menus
        newDetail.customerReviews = customer
        return newDetail
    }
    
    public func transformEntityToDomain(entity: DetailRestaurantModuleEntity) -> DetailRestaurantDomainModel {
        let categories = _categoriesMapper.transformEntityToDomain(entity: entity.categories)
        let menus = _menusMapper.transformEntityToDomain(entity: entity.menus)
        let customer = _customerMapper.transformEntityToDomain(entity: entity.customerReviews)
        
        return DetailRestaurantDomainModel(
            id: entity.id,
            name: entity.name,
            descriptions: entity.descriptions,
            city: entity.city,
            address: entity.address,
            pictureId: entity.pictureId,
            rating: entity.rating,
            categories: categories,
            menus: menus,
            customerReviews: customer
        )
    }
    
    public func transformResponseToDomain(request: String?, response: DetailRestaurantResponse) -> DetailRestaurantDomainModel {
        let categories = _categoriesMapper.transformResponseToDomain(request: request, response: response)
        let menus = _menusMapper.transformResponseToDomain(request: request, response: response)
        let customer = _customerMapper.transformResponseToDomain(request: request, response: response)
        
        return DetailRestaurantDomainModel(
            id: response.id ?? "",
            name: response.name ?? "",
            descriptions: response.descriptions ?? "",
            city: response.city ?? "",
            address: response.address ?? "",
            pictureId: response.pictureId ?? "",
            rating: response.rating ?? 0.0,
            categories: categories,
            menus: menus,
            customerReviews: customer
        )
    }
}
