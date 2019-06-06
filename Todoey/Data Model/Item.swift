//
//  Item.swift
//  Todoey
//
//  Created by Meng Dong on 2019/06/05.
//  Copyright © 2019 Dong. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCatogery = LinkingObjects(fromType: Category.self, property: "items")
    
}
