//
//  PresentationAssembly.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation
import UIKit

protocol PresentationAssemblyProtocol {
    func mainNavigationController() -> UINavigationController
    func citiesListViewController() -> CitiesListViewController
    func cityInfoCiewController() -> CityInfoViewController
}

class PresentationAssembly: PresentationAssemblyProtocol {
    
    private let serviceAssembly: ServiceAssemblyProtocol
    init(serviceAssembly: ServiceAssemblyProtocol) {
        self.serviceAssembly = serviceAssembly
    }
    
    func mainNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as? UINavigationController
        guard let navigationVC = navigationController else {
            return UINavigationController()
        }
        navigationVC.setViewControllers([citiesListViewController()], animated: false)
        return navigationVC
    }
    
    func citiesListViewController() -> CitiesListViewController {
        let model = CitiesListModel(networkManager: serviceAssembly.networkManager)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let citiesListViewController = storyboard.instantiateViewController(withIdentifier: "CitiesListViewController") as? CitiesListViewController else { return CitiesListViewController() }
        citiesListViewController.model = model
        citiesListViewController.presentationAssembly = self
        model.delegate = citiesListViewController
        return citiesListViewController
    }
    
    func cityInfoCiewController() -> CityInfoViewController {
        let model = CityInfoModel(networkManager: serviceAssembly.networkManager)
        let storyboard: UIStoryboard = UIStoryboard(name: "CityInfo", bundle: nil)
        guard let cityInfoViewController = storyboard.instantiateViewController(withIdentifier: "CityInfoViewController") as? CityInfoViewController else { return CityInfoViewController() }
        cityInfoViewController.model = model
        model.delegate = cityInfoViewController
        return cityInfoViewController
    }
}
