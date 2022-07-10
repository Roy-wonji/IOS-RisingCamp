//
//  KakoData.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/09.
//

import Foundation

struct KakaoLocalResponse: Decodable {
    let documents: [Restaurant]
    let meta: MetaContainer
    struct MetaContainer: Decodable {
        let is_end: Bool
        let pageable_count: Int
        let same_name: RegionInfo
        
        struct RegionInfo: Decodable {
            let keyword: String
            let region: [String]
            let selected_region: String
        }
        let total_count: Int
    }
}

struct KakaoGeoResponse: Decodable {
    let meta: Meta
    struct Meta: Decodable {
        let total_count: Int
    }
    let documents: [GeoData]
}

struct GeoData: Decodable {
        let region_type: String
        let address_name: String
        let region_1depth_name: String
        let region_2depth_name: String
        let region_3depth_name: String
        let region_4depth_name: String
        let code: String
        let x: Double
        let y: Double
}


struct Restaurant: Decodable {
    let address_name: String
    let category_group_code: String
    let category_group_name: String
    let category_name: String
    let distance: String
    let id: String
    let phone: String
    let place_name: String
    let place_url: String
    let road_address_name: String
    let x: String
    let y: String
}
