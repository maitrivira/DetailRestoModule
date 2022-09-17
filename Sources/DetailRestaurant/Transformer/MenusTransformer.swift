//
//  File.swift
//  
//
//  Created by Maitri Vira on 27/05/22.
//

import Core
import RealmSwift

public struct MenusTransformer: Mapper {
    
    public typealias Request = String
    public typealias Response = DetailRestaurantResponse
    public typealias Entity = List<MenusEntity>
    public typealias Domain = Menus
    
    public init() { }
    
    public func transformResponseToEntity(response: DetailRestaurantResponse) -> List<MenusEntity> {
        let newMenu = List<MenusEntity>()
        
        let drinkEntity = DrinksEntity()
        let foodEntity = FoodEntity()
        
        for drinks in response.menus.drinks {
            drinkEntity.name = drinks.name ?? ""
        }
        
        for foods in response.menus.foods {
            foodEntity.name = foods.name ?? ""
        }
    
        return newMenu
    }
    
    public func transformModelToEntity(response: DetailRestaurantResponse) -> List<MenusEntity> {
        let newMenu = List<MenusEntity>()
        
        let drinkEntity = DrinksEntity()
        let foodEntity = FoodEntity()
        
        for drinks in response.menus.drinks {
            drinkEntity.name = drinks.name ?? ""
        }
        
        for foods in response.menus.foods {
            foodEntity.name = foods.name ?? ""
        }
    
        return newMenu
    }
    
    public func transformEntityToDomain(entity: List<MenusEntity>) -> Menus {
        let drinks: [Drinks] = []
        let foods: [Foods] = []
        
        return Menus(foods: foods, drinks: drinks)
    }
    
    public func transformResponseToDomain(response: DetailRestaurantResponse) -> Menus {
        return Menus(foods: response.menus.foods, drinks: response.menus.drinks)
    }
    
    public func transformDomainToEntity(domain: Menus) -> List<MenusEntity> {
        return 
    }
    
    public func transformEntityToDomain(entity: [CategoryEntity]) -> [CategoryModel] {
        return entity.map { result in
          return CategoryModel(
            id: result.id,
            title: result.title,
            image: result.image,
            description: result.desc
          )
        }
    }
}
