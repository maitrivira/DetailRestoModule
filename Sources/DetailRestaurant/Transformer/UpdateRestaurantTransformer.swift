//
//  File.swift
//  
//
//  Created by Maitri Vira on 20/09/22.
//

import Core
import RealmSwift

public struct UpdateRestaurantTransformer<CategoryMapper: Mapper, MenusMapper: Mapper, CustomerMapper: Mapper>: Mapper
where

    CategoryMapper.Response == DetailRestaurantResponse,
    CategoryMapper.Entity == List<CategoryEntity>,
    CategoryMapper.Domain == [Categories],

    MenusMapper.Response == DetailRestaurantResponse,
    MenusMapper.Entity == List<MenusEntity>,
    MenusMapper.Domain == Menus,

    CustomerMapper.Response == DetailRestaurantResponse,
    CustomerMapper.Entity == List<CustomerReviewsEntity>,
    CustomerMapper.Domain == [CustomerReviews]{
        
        public typealias Request = DetailRestaurantDomainModel
        public typealias Response = Bool
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
        
        public func transformResponseToEntity(response: Bool) -> DetailRestaurantModuleEntity {
            let newDetail = DetailRestaurantModuleEntity()
            return newDetail
        }
        
        public func transformModelToEntity(request: DetailRestaurantDomainModel) -> DetailRestaurantModuleEntity {
            let categories = _categoriesMapper.transformDomainToEntity(domain: request.categories)
            let menus = _menusMapper.transformDomainToEntity(domain: request.menus)
            let customer = _customerMapper.transformDomainToEntity(domain: request.customerReviews)
            
            let newDetail = DetailRestaurantModuleEntity()
            newDetail.id = request.id
            newDetail.name = request.name
            newDetail.descriptions = request.descriptions
            newDetail.pictureId = request.pictureId
            newDetail.city = request.city
            newDetail.address = request.address
            newDetail.rating = request.rating
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
        
        public func transformResponseToDomain(response: Bool) -> DetailRestaurantDomainModel {
            return DetailRestaurantDomainModel(id: "", name: "", descriptions: "", city: "", address: "", pictureId: "", rating: 0.0, categories: [], menus: menuDummy, customerReviews: [])
        }
        
        public func transformDomainToEntity(domain: DetailRestaurantDomainModel) -> DetailRestaurantModuleEntity {
            let categories = _categoriesMapper.transformDomainToEntity(domain: domain.categories)
            let menus = _menusMapper.transformDomainToEntity(domain: domain.menus)
            let customer = _customerMapper.transformDomainToEntity(domain: domain.customerReviews)
            
            let newDetail = DetailRestaurantModuleEntity()
            newDetail.id = domain.id
            newDetail.name = domain.name
            newDetail.descriptions = domain.descriptions
            newDetail.pictureId = domain.pictureId
            newDetail.city = domain.city
            newDetail.address = domain.address
            newDetail.rating = domain.rating
            newDetail.categories = categories
            newDetail.menus = menus
            newDetail.customerReviews = customer
            return newDetail
        }
        
    }
