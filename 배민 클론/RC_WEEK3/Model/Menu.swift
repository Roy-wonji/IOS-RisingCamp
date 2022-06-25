//
//  Menu.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/24.
//

import Foundation
import MobileCoreServices

class Menu: NSObject, Codable {
    var name: String
    var detail: String
    var price: Int
    
    init(name: String, detail: String, price: Int) {
        self.name = name
        self.detail = detail
        self.price = price
    }
}

extension Menu: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        
        return progress
    }
}



extension Menu: NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        do {
            let menu = try JSONDecoder().decode(Menu.self, from: data)
            return menu as! Self
        } catch {
            fatalError()
        }
    }
}
