//
//  File.swift
//  
//
//  Created by Maitri Vira on 26/05/22.
//

import Foundation

public struct DetailRestaurantsResponse: Decodable {
    
    let restaurant: DetailRestaurantResponse
    
}

public struct DetailRestaurantResponse: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id, name, city, address, pictureId, rating, categories, menus, customerReviews
        case descriptions = "description"
    }

    let id: String?
    let name: String?
    let descriptions: String?
    let city: String?
    let address: String?
    let pictureId: String?
    let rating: Double?
    let categories: [Categories]
    let menus: Menus
    let customerReviews: [CustomerReviews]

}

public struct Categories: Decodable, Hashable {
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    public let name: String?
    
}

public struct Menus: Decodable, Hashable {
    
    private enum CodingKeys: String, CodingKey {
        case foods, drinks
    }
    
    public let foods: [Foods]
    public let drinks: [Drinks]
    
}

public let menuDummy: Menus = Menus(foods: [], drinks: [])

public struct CustomerReviews: Decodable, Hashable {
    
    private enum CodingKeys: String, CodingKey {
        case name, review, date
    }
    
    public let name: String?
    public let review: String?
    public let date: String?
    
}

public struct Foods: Decodable, Hashable {
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    public let name: String?
    
}

public struct Drinks: Decodable, Hashable {
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    public let name: String?
    
}
