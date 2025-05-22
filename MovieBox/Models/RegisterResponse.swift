//
//  RegisterResponse.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

struct RegisterResponse: Decodable {
    let message: String
    let token: String
    let user: User
}
