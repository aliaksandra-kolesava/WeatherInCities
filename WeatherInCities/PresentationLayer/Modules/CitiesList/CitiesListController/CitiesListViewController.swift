//
//  CitiesListViewController.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 26.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    var model: CitiesListModelProtocol?
    var presentationAssembly: PresentationAssemblyProtocol?
    var filteredTableData = [WeatherModel]()
    var searchController = UISearchController()
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    @IBOutlet weak var citiesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewSetup()
        loadData()
        searchControllerSetup()
    }
    
    func tableViewSetup() {
        citiesTableView.register(UINib(nibName: "CityViewCell", bundle: nil), forCellReuseIdentifier: "CityCell")
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
    }
    
    func loadData() {
        DispatchQueue.global(qos: .background).async {
            self.model?.loadData()
        }
    }
    
    func searchControllerSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        guard let modelArray = model?.weatherArray else { return }
        let sortedData = modelArray.sorted() {$0.name < $1.name}
        filteredTableData = sortedData.filter { (weather: WeatherModel) -> Bool in
            return weather.name.lowercased().contains(searchText.lowercased())
        }
        citiesTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CitiesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && !isSearchBarEmpty {
            return filteredTableData.count
        } else {
            return model?.weatherArray.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = citiesTableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityViewCell else { return UITableViewCell() }
        if searchController.isActive && !isSearchBarEmpty {
            cell.configure(with: filteredTableData[indexPath.row])
        } else {
            if let weatherArray = model?.weatherArray {
                let sortedData = weatherArray.sorted() { $0.name < $1.name}
                cell.configure(with: sortedData[indexPath.row])
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cityInfoViewController = presentationAssembly?.cityInfoCiewController() else { return }
        navigationController?.pushViewController(cityInfoViewController, animated: true)
        let array = model?.weatherArray.sorted() { $0.name < $1.name }
        guard let weather = array else { return }
        if searchController.isActive && !isSearchBarEmpty {
            cityInfoViewController.lat = String(filteredTableData[indexPath.row].lat)
            cityInfoViewController.lon = String(filteredTableData[indexPath.row].lon)
            cityInfoViewController.icon = filteredTableData[indexPath.row].icon
        } else {
            let latString = String(weather[indexPath.row].lat)
            let lonString = String(weather[indexPath.row].lon)
            cityInfoViewController.lat = latString
            cityInfoViewController.lon = lonString
            cityInfoViewController.icon = weather[indexPath.row].icon
        }
        citiesTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CitiesListDelegate

extension CitiesListViewController: CitiesListDelegate {
    func loadComplited() {
        DispatchQueue.main.async {
            self.citiesTableView.reloadData()
        }
    }
}

// MARK: - UISearchResultsUpdating

extension CitiesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let text = searchBar.text else { return }
        filterContentForSearchText(text)
    }
}

