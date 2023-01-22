//
//  PageContainerViewController.swift
//  Rides
//
//  Created by Vish on 2023-01-21.
//

import UIKit

class PageContainerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    var carData: Vehicle?
    var currentVCIndex = 0
    var identifiers: NSArray = [Constants.vehicleDetailVCID, Constants.emissionDetailVCId]

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
    }
        
    func configurePageViewController(){
        
        guard let pageVC = storyboard?.instantiateViewController(withIdentifier: Constants.customPageVCId) as? CustomPageViewController else{
            return
        }
        
        pageVC.delegate = self
        pageVC.dataSource = self
        addChild(pageVC)
        pageVC.didMove(toParent: self)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(pageVC.view)
        let pageVCConstraints = [
            pageVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            pageVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            pageVC.view.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 0),
            pageVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: 0)
        ]
        
        NSLayoutConstraint.activate(pageVCConstraints)
        guard let startingVC = detailViewControllerAt(index : currentVCIndex ) else{
            return
        }
        
        pageVC.setViewControllers([startingVC], direction: .forward, animated: true)
    }
    
    func detailViewControllerAt(index : Int) -> UIViewController?{
        
        if index == 0 {
            guard let detailVC = storyboard?.instantiateViewController(withIdentifier: Constants.vehicleDetailVCID) as? VehicleDetailViewController else{
                return nil
            }
            detailVC.carData = carData
            return detailVC
        }
        if index == 1 {
            guard let detailVC = storyboard?.instantiateViewController(withIdentifier: Constants.emissionDetailVCId) as? VehicleEmissionViewController else{
                return nil
            }
            detailVC.carData = carData
            return detailVC
        }
        return nil
    }

}

// MARK: PageViewController Datasource and Delegate Methods

extension PageContainerViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let identifier = viewController.restorationIdentifier
        let index = self.identifiers.index(of: identifier)
        if index == 0 {
            return nil
        }
        self.currentVCIndex = self.currentVCIndex - 1
        return self.detailViewControllerAt(index: currentVCIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let identifier = viewController.restorationIdentifier
        let index = self.identifiers.index(of: identifier)
        if index == identifiers.count - 1 {
            return nil
        }
        self.currentVCIndex = self.currentVCIndex + 1
        return self.detailViewControllerAt(index: currentVCIndex)
        
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentVCIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.identifiers.count
    }
    
    
}
