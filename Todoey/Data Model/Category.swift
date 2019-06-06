//
//  Category.swift
//  Todoey
//
//  Created by Meng Dong on 2019/06/05.
//  Copyright © 2019 Dong. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
