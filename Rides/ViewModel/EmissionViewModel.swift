//
//  EmissionViewModel.swift
//  Rides
//
//  Created by Vish on 2023-01-22.
//

import Foundation

class EmissionViewModel {
    
    func calculateEmssion(km: Int) -> String{
        var totalUnit = 0.0
        if km >= 5000{
            totalUnit = 5000 + Double(km - 5000) * 1.5
        }else{
            totalUnit = Double(km)
        }
        return "\(totalUnit) Unit"
    }
    
}

