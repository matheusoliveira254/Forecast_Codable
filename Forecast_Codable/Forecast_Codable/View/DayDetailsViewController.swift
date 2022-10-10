//
//  DayDetailsViewController.swift
//  Forecast_Codable
//
//  Created by Karl Pfister on 2/6/22.
//

import UIKit

class DayDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var dayForcastTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentHighLabel: UILabel!
    @IBOutlet weak var currentLowLabel: UILabel!
    @IBOutlet weak var currentDescriptionLabel: UILabel!
    
    //MARK: - Properties
    var forecastData: TopLevelDictionary?
    var days: [Day] = []
    
    //MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        dayForcastTableView.delegate = self
        dayForcastTableView.dataSource = self
        
            NetworkController.fetchDays { forecastData in
            guard let forecastData = forecastData else {return}
            self.forecastData = forecastData
            self.days = forecastData.days
            DispatchQueue.main.async {
                self.updateViews()
                self.dayForcastTableView.reloadData()
            }
        }
    }
    
    func updateViews() {
        let currentDay = days[0]
        cityNameLabel.text = forecastData?.cityName ?? "Error displaying city name."
        currentTempLabel.text = "\(currentDay.temp)F"
        currentHighLabel.text = "\(currentDay.highTemp)F"
        currentLowLabel.text = "\(currentDay.lowTemp)F"
        currentDescriptionLabel.text = currentDay.weather.description
        
    }
}

//MARK: - Extenstions
extension DayDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData?.days.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as? DayForcastTableViewCell else {return UITableViewCell()}
        let day = days[indexPath.row]
        cell.updateViews(day: day)
        return cell
    }
}

