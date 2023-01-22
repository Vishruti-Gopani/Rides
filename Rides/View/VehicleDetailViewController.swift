//
//  CarDetailViewController.swift
//  Rides
//
//  Created by Vish on 2023-01-19.
//

import UIKit

class VehicleDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var make_and_model: UILabel!
    @IBOutlet weak var cocor: UILabel!
    @IBOutlet weak var car_type: UILabel!
    
    // MARK: - Variables
    var carData: Vehicle?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.borderColor = UIColor.black.cgColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureData()
    }
    
    func configureData(){
        vin.text = carData?.vin
        make_and_model.text = carData?.make_and_model
        cocor.text = carData?.color
        car_type.text = carData?.car_type
    }
}
