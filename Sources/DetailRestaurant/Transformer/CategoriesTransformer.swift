//
//  File.swift
//  
//
//  Created by Maitri Vira on 27/05/22.
//

import Core
import RealmSwift

public struct CategoriesTransformer: Mapper {
    
    public typealias Request = String
    public typealias Response = DetailRestaurantResponse
    public typealias Entity = List<CategoryEntity>
    public typealias Domain = [Categories]
    
    public init() { }
    
    public func transformResponseToEntity(request: String?, response: DetailRestaurantResponse) -> List<CategoryEntity> {
        let newCategory = List<CategoryEntity>()
        
        for item in response.categories {
            let categoryEntity = CategoryEntity()
            categoryEntity.name = item.name ?? ""
        }
        
        return newCategory
        
    }
    
    public func transformModelToEntity(request: String?, response: DetailRestaurantResponse) -> List<CategoryEntity> {
        let newCategory = List<CategoryEntity>()
        
        for item in response.categories {
            let categoryEntity = CategoryEntity()
            categoryEntity.name = item.name ?? ""
        }
        
        return newCategory
    }
    
    public func transformEntityToDomain(entity: List<CategoryEntity>) -> [Categories] {
        return entity.map { result in
            return Categories(name: result.name)
        }
    }
    
    public func transformResponseToDomain(request: String?, response: DetailRestaurantResponse) -> [Categories] {
        return response.categories.map { result in
            return Categories(name: result.name)
        }
    }
    
}
