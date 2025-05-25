//
//  UpdateUserRequestBody.swift
//  MovieBox
//
//  Created by Yasin Onur on 25.05.2025.
//


struct UpdateUserWithPasswordRequestBody: Encodable {
    let name: String
    let surname: String
    let email: String
    let password: String
}

struct UpdateUserRequestBody: Encodable {
    let name: String
    let surname: String
    let email: String
}

