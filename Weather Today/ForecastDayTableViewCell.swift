//
//  ForecastDayTableViewCell.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/6/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import UIKit

class ForecastDayTableViewCell: UITableViewCell {
    @IBOutlet var weatherConditionImageView: UIImageView!
    @IBOutlet var weekdayLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
