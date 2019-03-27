//
//  WeatherMapDataVC.swift
//  WeatherMapData
//
//  Created by Ravi Sendhav on 26/03/19.
//  Copyright © 2019 Ravi Sendhav. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherMapDataVC: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tblWeatherMapData: UITableView! {
        didSet {
            tblWeatherMapData.tableFooterView = UIView(frame: .zero)
        }
    }
    
    // MARK: - Property Declaration/Initialization
    private let locationManager   = CLLocationManager()
    private let reuserIdentifire  = "WeatherMapDataCell"
    private var arrWeatherMapData = NSArray()
    
    // private var arrWeatherMapData = [WeatherMapData]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - API Method
    private func getWeatherMapData(_ latitude: Double, longitude: Double) {
        
        // TODO: Manage network related condition
        // TODO: Need to add Show loader condition
        
        let getWeatherMapDataURL = "https://samples.openweathermap.org/data/2.5/find?lat=\(latitude)&lon=\(longitude)&cnt=1000&appid=b1b15e88fa797225412429c1c50c122a1"
        
        APIManager.sharedInstance.makeHTTPGetRequest(getWeatherMapDataURL) { [weak self] (json) in
            
            // TODO: Need to add Hide loader condition

            if let arrTemp = json["list"] as? NSArray {
                self?.arrWeatherMapData = arrTemp
            }

            DispatchQueue.main.async {
                self?.tblWeatherMapData.reloadData()
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        
        // Perform Get weather map data API
        getWeatherMapData(locValue.latitude, longitude: locValue.longitude)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension WeatherMapDataVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWeatherMapData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuserIdentifire, for: indexPath) as? WeatherMapDataCell
        
        if cell == nil {
            cell = WeatherMapDataCell(style: UITableViewCellStyle.default, reuseIdentifier: reuserIdentifire)
        }
        cell?.selectionStyle = .none
        
//        let weatherMatData = arrWeatherMapData[indexPath.row]
//        cell?.configureCellData(weatherMatData)
        
        let dictWeatherMapData = arrWeatherMapData[indexPath.row] as? NSDictionary
        
        let dictMain = dictWeatherMapData!["main"] as? NSDictionary
        
        cell?.lblAreaName.text    = "Area name: \(dictWeatherMapData!["name"] ?? "")"
        cell?.lblTemperature.text = "Temperature: \(dictMain!["temp"] ?? "")"
        cell?.lblHumidity.text    = "Humidity: \(dictMain!["humidity"] ?? "")"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

