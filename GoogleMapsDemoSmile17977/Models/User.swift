//
//  User.swift
//  GoogleMapsDemoSmile17977
//
//  Created by Kir Pir on 20.10.2020.
//

import Foundation

struct User: Decodable {
    let idClient: Int?
    let idClientAccount: Int?
    let clientCode: String?
    let latitude: Double?
    let longitude: Double?
    let avatarHash: String?
    let statusOnline: Bool?
    
    enum CodingKeys: String, CodingKey {
        case idClient = "IdClient"
        case idClientAccount = "IdClientAccount"
        case clientCode = "ClientCode"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case avatarHash = "AvatarHash"
        case statusOnline = "StatusOnline"
    }
}
