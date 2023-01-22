//
//  VehicleEmissionViewController.swift
//  Rides
//
//  Created by Vish on 2023-01-21.
//

import UIKit


class VehicleEmissionViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var kilometrage: UILabel!
    @IBOutlet weak var carbonEmission: UILabel!
    
    var carData: Vehicle?
    var index: Int?
    var emissionVM = EmissionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.borderColor = UIColor.black.cgColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureData()
    }
    
    func configureData(){
        guard let km = carData?.kilometrage else{
            return
        }
        kilometrage.text = "\(km) Km"
        carbonEmission.text = emissionVM.calculateEmssion(km: km)
    }
}
