//
//  Errors.swift
//  ios-articles
//
//  Created by Galileo Guzman on 02/11/20.
//

import Foundation

enum Errors: String, Error {
    case unableToComplete = "Unable to complete your request."
    case invalidResponse = "Invalid server response."
    case invalidData = "Invalid data."
}
