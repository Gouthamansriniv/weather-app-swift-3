//
//  ForeViewController.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/6/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import UIKit

class ForeViewController: UIViewController {

    let weatherDays:[String] = ["Monday", "Tuesday", "Wednesday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Armenia"
    }
    
}

extension ForeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDays.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue Reusable Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastDayTableViewCell
        
        // Configure Cell
        cell.weatherConditionImageView.image = #imageLiteral(resourceName: "ForecastIcon")
        cell.weekdayLabel.text = self.weatherDays[indexPath.row]
        
        
        return cell
    }
}
