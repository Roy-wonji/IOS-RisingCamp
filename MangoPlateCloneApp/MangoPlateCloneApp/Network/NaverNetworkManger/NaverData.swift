//
//  NaverData.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/10.
//

import Foundation

struct NaverData: Decodable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Decodable {
    let title: String
    let link: String
    let category, itemDescription, telephone, address: String
    let roadAddress, mapx, mapy: String

    enum CodingKeys: String, CodingKey {
        case title, link, category
        case itemDescription = "description"
        case telephone, address, roadAddress, mapx, mapy
    }
}

