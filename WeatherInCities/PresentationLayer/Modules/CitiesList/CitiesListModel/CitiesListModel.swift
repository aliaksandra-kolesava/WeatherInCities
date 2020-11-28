//
//  CitiesListModel.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation

protocol CitiesListModelProtocol {
    var weatherArray: [WeatherModel] { get set }
    var currentLatLon: [LatLon] { get set }
    func loadData()
}

protocol CitiesListDelegate: class {
    func loadComplited()
}

struct LatLon {
    let lat: String
    let lon: String
}

class CitiesListModel: CitiesListModelProtocol {
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    weak var delegate: CitiesListDelegate?
    var currentLatLon: [LatLon] = []
    var weatherArray: [WeatherModel] = []
    var latLonArray: [LatLon] = [LatLon(lat: "51.5085300", lon: "-0.1257400"),
    LatLon(lat: "40.7142700", lon: "-74.0059700"),
    LatLon(lat: "52.5243700", lon: "13.4105300"),
    LatLon(lat: "1.2896700", lon: "103.8500700"),
    LatLon(lat: "35.6895000", lon: "139.6917100"),
    LatLon(lat: "53.9000000", lon: "27.5666700"),
    LatLon(lat: "27.7016900", lon: "85.3206000"),
    LatLon(lat: "24.4666700", lon: "54.3666700"),
    LatLon(lat: "-15.7797200", lon: "-47.9297200"),
    LatLon(lat: "64.1354800", lon: "-21.8954100")]
    
    func loadData() {
        for latLon in latLonArray {
            networkManager.loadData(lat: latLon.lat, lon: latLon.lon) { (weather, error) in
            if let error = error {
                print(error)
                return
            }
            guard let weather = weather else { return }
            self.weatherArray.append(weather)
            self.delegate?.loadComplited()
            self.currentLatLon.append(latLon)
                print("\(weather.name) (\(latLon.lat), \(latLon.lon)")
            }
        }
    }
}
