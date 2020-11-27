//
//  ServiceAssembly.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation

protocol ServiceAssemblyProtocol {
    var networkManager: NetworkManagerProtocol { get }
}

class ServiceAssembly: ServiceAssemblyProtocol {
    private let coreAssembly: CoreAssemblyProtocol
    
    init(coreAssembly: CoreAssemblyProtocol) {
        self.coreAssembly = coreAssembly
    }
    
    lazy var networkManager: NetworkManagerProtocol = NetworkManager(requestSender: coreAssembly.requestSender)
}
