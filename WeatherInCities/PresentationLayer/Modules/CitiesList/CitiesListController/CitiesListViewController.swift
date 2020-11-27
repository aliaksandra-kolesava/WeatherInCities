//
//  CitiesListViewController.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 26.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    var array: [WeatherModel] = []
    var model: CitiesListModelProtocol?
    
//    var weatherRequest = WeatherRequest()

    @IBOutlet weak var citiesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        citiesTableView.register(UINib(nibName: "CityViewCell", bundle: nil), forCellReuseIdentifier: "CityCell")
        citiesTableView.dataSource = self
        model?.loadData()


    }
}

extension CitiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.weatherArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = citiesTableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityViewCell else { return UITableViewCell() }
        if let weatherArray = model?.weatherArray[indexPath.row] {
        cell.configure(with: weatherArray)
        }
        return cell
    }
}

extension CitiesListViewController: CitiesListDelegate {
    func loadComplited() {
        DispatchQueue.main.async {
            self.citiesTableView.reloadData()
        }
    }
}

