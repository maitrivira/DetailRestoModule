//
//  File.swift
//  
//
//  Created by Maitri Vira on 26/05/22.
//

import Foundation
import RealmSwift

public class DetailRestaurantModuleEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var descriptions: String = ""
    @objc dynamic var pictureId: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var rating: Double = 0.0
    
    var categories = List<CategoryEntity>()
    var menus = List<MenusEntity>()
    var customerReviews = List<CustomerReviewsEntity>()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
}
