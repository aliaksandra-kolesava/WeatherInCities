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
    func citiesListViewController() -> CitiesListViewController
}

class PresentationAssembly: PresentationAssemblyProtocol {
    
    private let serviceAssembly: ServiceAssemblyProtocol
    init(serviceAssembly: ServiceAssemblyProtocol) {
        self.serviceAssembly = serviceAssembly
    }
    
    func citiesListViewController() -> CitiesListViewController {
        let model = CitiesListModel(networkManager: serviceAssembly.networkManager)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let citiesListViewController = storyboard.instantiateViewController(withIdentifier: "CitiesListViewController") as? CitiesListViewController else { return CitiesListViewController() }
        citiesListViewController.model = model
        model.delegate = citiesListViewController
        return citiesListViewController
    }
}
