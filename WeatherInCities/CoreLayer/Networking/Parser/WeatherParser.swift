//
//  WeatherParser.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation
import UIKit
import SVGKit


struct WeatherData: Codable {
    let fact: Fact
    let info: Info
}
struct Info: Codable {
    let lat: Double
    let lon: Double
    let tzinfo: Tzinfo
}
struct Tzinfo: Codable {
    let name: String
}

struct Fact: Codable {
    let temp: Double
    let condition: String
    let icon: String
    let wind_speed: Double
    let wind_dir: String
    let pressure_mm: Double
    let humidity: Double
}

struct WeatherModel {
    let condition: String
    let name: String
    let temp: Double
    let icon: String
    let wind_speed: Double
    let wind_dir: String
    let pressure_mm: Double
    let humidity: Double
    let lat: Double
    let lon: Double
}

class WeatherParser: WeatherParserProtocol {
    typealias Model = WeatherModel
    
    func parse(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let factCondition = decodedData.fact.condition
            let name = decodedData.info.tzinfo.name
            let temp = decodedData.fact.temp
            let icon = decodedData.fact.icon
            let wind_speed = decodedData.fact.wind_speed
            let wind_dir = decodedData.fact.wind_dir
            let pressure = decodedData.fact.pressure_mm
            let humidity = decodedData.fact.humidity
            let lat = decodedData.info.lat
            let lon = decodedData.info.lon
            let weather = WeatherModel(condition: factCondition,
                                       name: name,
                                       temp: temp,
                                       icon: icon,
                                       wind_speed: wind_speed,
                                       wind_dir: wind_dir,
                                       pressure_mm: pressure,
                                       humidity: humidity,
                                       lat: lat, lon: lon)
            return weather
        } catch {
            print("\(error.localizedDescription) trying to convert data to JSON")
            return nil
        }
    }
}

class ImageParser: WeatherParserProtocol {
    typealias Model = SVGKImage
    
    func parse(data: Data) -> Model? {
        guard let picture: SVGKImage = SVGKImage(data: data)  else { return nil }
    return picture
}
}
