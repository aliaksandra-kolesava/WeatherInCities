//
//  WeatherParser.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation


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
}

struct WeatherModel {
    let condition: String
    let name: String
    let temp: Double
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
            let weather = WeatherModel(condition: factCondition, name: name, temp: temp)
            return weather
        } catch {
            print("\(error.localizedDescription) trying to convert data to JSON")
            return nil
        }
    }
}
