//
//  UpdateUserProfileResponse.swift
//  MovieBox
//
//  Created by Yasin Onur on 25.05.2025.
//

struct UpdateUserProfileResponse: Decodable {
    let message: String
    let user: AuthUser
}
