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

extension User {
    static var maxPersona = User(name: "Max Mustermann", imageName: "zebra")
    static var lieschenPersona = User(name: "Lieschen Müller", imageName: "blueberries", lastOnline: .seconds(7200))
}
