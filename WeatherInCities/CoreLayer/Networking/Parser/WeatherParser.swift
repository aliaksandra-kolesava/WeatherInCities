//
//  WeatherParser.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation
import UIKit


struct WeatherData: Codable {
    let fact: Fact
    let info: Info
}
struct Info: Codable {
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
            let weather = WeatherModel(condition: factCondition, name: name, temp: temp, icon: icon, wind_speed: wind_speed, wind_dir: wind_dir, pressure_mm: pressure, humidity: humidity)
            return weather
        } catch {
            print("\(error.localizedDescription) trying to convert data to JSON")
            return nil
        }
    }
}

class ImageParser: WeatherParserProtocol {
    typealias Model = UIImage
    
    func parse(data: Data) -> Model? {
    guard let picture = UIImage(data: data)  else { return nil }
    return picture
}
}
