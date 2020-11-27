//
//  CityViewCell.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 26.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import UIKit

class CityViewCell: UITableViewCell, ConfigurableView {
    
    typealias ConfigurationModel = WeatherModel

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var condition: UILabel!
    
//    var weatherManager = WeatherRequest()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityName.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        temperature.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        condition.font = UIFont.systemFont(ofSize: 13, weight: .regular)
//        weatherManager.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: WeatherModel) {
        cityName.text = model.name
        temperature.text = "\(String(model.temp)) °C"
        condition.text = model.condition
       }
    
}
