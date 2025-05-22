//
//  RegisterRequestBody.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//


struct RegisterRequestBody: Encodable {
    let name: String
    let surname: String
    let email: String
    let password: String
}
