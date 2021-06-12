//
//  Logo.swift
//  LogoApp
//
//  Created by Jitesh Middha on 12/06/21.
//

struct Logo: Codable {
    let imageUrl: String?
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "imgUrl"
    }
}

