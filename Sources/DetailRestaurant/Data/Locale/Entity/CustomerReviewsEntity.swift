//
//  File.swift
//  
//
//  Created by Maitri Vira on 26/05/22.
//

import Foundation
import RealmSwift

public class CustomerReviewsEntity: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var review: String = ""
    @objc dynamic var date: String = ""
    
}

