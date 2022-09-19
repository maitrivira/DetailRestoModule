//
//  File.swift
//  
//
//  Created by Maitri Vira on 26/05/22.
//

import Foundation

public struct DetailRestaurantDomainModel: Equatable, Identifiable {
    
    public let id: String
    public let name: String
    public let descriptions: String
    public let city: String
    public let address: String
    public let pictureId: String
    public let rating: Double
    public let categories: [Categories]
    public let menus: Menus
    public let customerReviews: [CustomerReviews]
}

public let emptyDetail = DetailRestaurantDomainModel(id: "", name: "", descriptions: "", city: "", address: "", pictureId: "", rating: 0.0, categories: [], menus: menuDummy, customerReviews: [])
