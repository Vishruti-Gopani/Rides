//
//  carViewModels.swift
//  Rides
//
//  Created by Vish on 2023-01-19.
//

import Foundation

class VehicleViewModel {
    
    var vehicles: [Vehicle] = []
    
    //Data binder to View
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchVehicles(size:Int){
        self.eventHandler?(.loading)
        APIManager.shared.getVehicleModel(size: size) { results in
            self.eventHandler?(.stopLoading)
            switch results{
            case .success(let cars):
                self.vehicles = cars
                //Sorting vehicles by Vin
                self.vehicles.sort(by: {$0.vin < $1.vin})
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
          }
        }
    }
    
    func sortByType(){
         vehicles.sort(by: {$0.car_type < $1.car_type})
    }
    
    enum Event {
            case loading
            case stopLoading
            case dataLoaded
            case error(Error?)
        }
}
