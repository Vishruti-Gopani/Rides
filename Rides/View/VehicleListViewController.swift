//
//  ViewController.swift
//  Rides
//
//  Created by Vish on 2023-01-19.
//

import UIKit

class VehicleListViewController: UIViewController {
    
    // MARK: - Variables
    var vehicleVM = VehicleViewModel()
    
    // MARK: - Outlets
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var vehicleListTableView: UITableView!
    @IBOutlet weak var TextField: UITextField!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        self.updateVehicleModel()
    }
    @IBAction func sortByButtonTapped(_ sender: UIButton) {
        vehicleVM.sortByType()
        vehicleListTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupTableView()
    }
    
    func updateVehicleModel(){
        guard let  noOfResults = TextField.text , let result = Int(noOfResults), isValidTFValue(value: result) else{
            /* Showing alert for invalid textfield value*/
            showAlertView()
            return
        }
        vehicleVM.fetchVehicles(size: result)
        observeEvent()
    }
    
    func isValidTFValue(value : Int) -> Bool{
        guard value > 0 , value <= Constants.noOfAPIResults else{
            return false
        }
        return true
    }
    
    func showAlertView(){
        let alert = UIAlertController(title: "Invalid Value Entered!!!", message: "\nPlease add valid integer value.\n Value must be in range 1 to 100.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupTableView(){
        indicatorView.isHidden = true
        vehicleListTableView.isHidden = true
        vehicleListTableView.delegate = self
        vehicleListTableView.dataSource = self
    }
    func configureViews(){
        TextField.layer.borderWidth = 1
        TextField.layer.borderColor = UIColor.black.cgColor
        TextField.layer.masksToBounds = true
        TextField.layer.cornerRadius = 5
        searchView.layer.borderWidth = 3
        searchView.layer.borderColor = UIColor.black.cgColor
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = 10
    }
    
    //observeEvent function will keep track of different API events and updates UI based on response.
    func observeEvent() {
        vehicleVM.eventHandler = { [weak self] event in
            switch event {
                case .loading:
                    DispatchQueue.main.async {
                        self?.indicatorView.isHidden = false
                    }
                    print("Product loading....")
                case .stopLoading:
                    DispatchQueue.main.async {
                        self?.indicatorView.isHidden = true
                    }
                    print("Stop loading...")
                case .dataLoaded:
                    print("Data loaded...")
                    DispatchQueue.main.async {
                        self?.vehicleListTableView.isHidden = false
                        self?.vehicleListTableView.reloadData()
                    }
                case .error(let error):
                print(error?.localizedDescription)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Something went wrong!!!", message: "The operation couldn’t be completed.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

// MARK: Tableview Datasource and Delegate Methods

extension VehicleListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vehicleVM.vehicles.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.listCellId, for: indexPath)
        let backgroundView = UIView()
        backgroundView.backgroundColor = Constants.selectedCellColor
        cell.selectedBackgroundView = backgroundView
        cell.textLabel?.text = vehicleVM.vehicles[indexPath.section].make_and_model
        cell.detailTextLabel?.text = "\(vehicleVM.vehicles[indexPath.section].vin) (\(vehicleVM.vehicles[indexPath.section].car_type))"
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue", size: 12)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.pageContainerVCId) as? PageContainerViewController{
            tableView.deselectRow(at: indexPath, animated: true)
            vc.carData = vehicleVM.vehicles[indexPath.section]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
