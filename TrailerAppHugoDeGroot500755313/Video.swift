//
//  Video.swift
//  TrailerAppHugoDeGroot500755313
//
//  Created by Wim de Groot on 22/04/2019.
//  Copyright © 2019 Wim de Groot. All rights reserved.
//

import Foundation
import UIKit

struct Video: Codable {
    var id: Int
    var title: String
    var url: String
    var description: String
    var posterImage: String
    var stillImage: String
    var genre: [String]
}
