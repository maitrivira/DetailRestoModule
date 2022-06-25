//
//  File.swift
//  
//
//  Created by Maitri Vira on 26/05/22.
//

import Foundation
import RealmSwift

public class MenusEntity: Object {
    
    var foods = List<FoodEntity>()
    var drinks = List<DrinksEntity>()
    
}


public class FoodEntity: Object {
    @objc dynamic var name: String = ""
}

public class DrinksEntity: Object {
    @objc dynamic var name: String = ""
}
