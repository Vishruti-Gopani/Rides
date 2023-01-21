//
//  Car.swift
//  Rides
//
//  Created by Vish on 2023-01-19.
//

import Foundation

struct Vehicle: Codable{
    var id: Int
    var uid: String
    var vin: String
    var make_and_model: String
    var color: String
    var transmission: String
    var drive_type: String
    var fuel_type: String
    var car_type: String
    var car_options: [String]
    var specs: [String]
    var doors: Int
    var mileage: Int
    var kilometrage: Int
    var license_plate: String
}
