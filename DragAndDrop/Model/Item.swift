//
//  Item.swift
//
//  Created by Kirill Chistyakov on 30.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

class Item {
    
    var name: String!
    var image: UIImage!
    
    class func getArray() -> [Item] {
        var items = [Item]()
        
        if let imageURLs = Bundle.main.urls(forResourcesWithExtension: "png", subdirectory: nil) {
            for url in imageURLs {
                let item = Item()
                item.name = url.deletingPathExtension().lastPathComponent
                item.image = UIImage(contentsOfFile: url.path)
                items.append(item)
            }
        }
        
        return items
    }
}
