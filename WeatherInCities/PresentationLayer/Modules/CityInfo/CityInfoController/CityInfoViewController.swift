//
//  CityInfoViewController.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import UIKit
import SVGKit

class CityInfoViewController: UIViewController {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherTemp: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    
    var model: CityInfoModelProtocol?
    var lat: String?
    var lon: String?
    var icon: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let fontResize = weatherIcon.bounds.size.height
        weatherTemp.font = UIFont.systemFont(ofSize: fontResize / 2)
        cityName.font = UIFont.systemFont(ofSize: fontResize / 4)
    }
    
    func loadData() {
        guard let lat = lat else { return }
        guard let lon = lon else { return }
        guard let icon = icon else { return }
        
        DispatchQueue.global(qos: .background).async {
            self.model?.loadData(lat: lat, lon: lon)
            self.model?.loadImage(icon: icon, completion: { (image) in
                DispatchQueue.main.async {
                    self.weatherIcon.image = image?.uiImage
                }
            })
        }
    }
}

// MARK: - CityInfoDelegate

extension CityInfoViewController: CityInfoDelegate {
    func loadComplited() {
        DispatchQueue.main.async {
            guard let weather = self.model?.weatherInfo else { return }
            self.weatherTemp.text = String(weather.temp)
            self.cityName.text = weather.name
            self.wind.text = "\(weather.wind_speed) m/s, \(weather.wind_dir)"
            self.humidity.text = "\(weather.humidity) %"
            self.pressure.text = "\(weather.pressure_mm) mm"
        }
    }
}
