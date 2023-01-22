//
//  Constants.swift
//  Rides
//
//  Created by Vish on 2023-01-21.
//

import Foundation
import UIKit

struct Constants{
    
    static let baseURL = "https://random-data-api.com/api/vehicle/random_vehicle"
    static let listCellId = "carCell"
    static let vehicleDetailVCID = "VehicleDetailViewController"
    static let emissionDetailVCId = "VehicleEmissionViewController"
    static let customPageVCId = "CustomPageViewController"
    static let pageContainerVCId = "PageContainerViewController"
    static let cellSpacingHeight: CGFloat = 1.0
    static let selectedCellColor: UIColor = UIColor( red: CGFloat(48/255.0), green: CGFloat(93/255.0), blue: CGFloat(122/255.0), alpha: CGFloat(0.4))
    static let noOfAPIResults = 100

}
