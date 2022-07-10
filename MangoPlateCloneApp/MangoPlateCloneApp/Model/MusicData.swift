//
//  MusicData.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/10.
//

import Foundation

// 실제 API에서 받게 되는 정보

struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}
