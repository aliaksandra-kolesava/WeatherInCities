//
//  RootAssembly.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation

class RootAssembly {
    
    lazy var  presentationAssembly: PresentationAssemblyProtocol = PresentationAssembly(serviceAssembly: self.serviceAssembly)
    
    private lazy var coreAssembly: CoreAssemblyProtocol = CoreAssembly()
   private lazy var serviceAssembly: ServiceAssemblyProtocol = ServiceAssembly(coreAssembly: self.coreAssembly)
}
