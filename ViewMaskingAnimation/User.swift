//
//  User.swift
//  ViewMaskingAnimation
//
//  Created by Martin on 09.05.23.
//

import Foundation

struct User: Hashable{
    let id: UUID = UUID()
    let name: String
    let imageName:  String
    var lastOnline: Duration = .seconds(3600)
}
