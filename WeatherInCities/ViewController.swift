//
//  ViewController.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 26.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {

    @IBOutlet weak var citiesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        citiesTableView.register(UINib(nibName: "CityViewCell", bundle: nil), forCellReuseIdentifier: "CityCell")

    }
}

