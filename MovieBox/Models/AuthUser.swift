//
//  AuthUser.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

import Foundation

struct AuthUser: Decodable {
    let id: String
    let name: String
    let surname: String
    let email: String
}
