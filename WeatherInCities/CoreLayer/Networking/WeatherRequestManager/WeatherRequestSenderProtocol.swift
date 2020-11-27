//
//  WeatherRequestSenderProtocol.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation

struct RequestConfig<Parser> where Parser: WeatherParserProtocol {
    let request: WeatherRequestProtocol
    let parser: Parser
}

enum Result<Model> {
    case success(Model)
    case error(String)
}

protocol RequestSenderProtocol {
    func send<Parser>(lat: String, lon: String, requestConfig config: RequestConfig<Parser>,
    completionHandler: @escaping (Result<Parser.Model>) -> Void) where Parser: WeatherParserProtocol
}
