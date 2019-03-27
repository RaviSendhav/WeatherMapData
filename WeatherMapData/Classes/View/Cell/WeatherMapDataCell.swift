//
//  WeatherMapDataCell.swift
//  WeatherMapData
//
//  Created by Ravi Sendhav on 26/03/19.
//  Copyright © 2019 Ravi Sendhav. All rights reserved.
//

import UIKit

class WeatherMapDataCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblAreaName      : UILabel!
    @IBOutlet weak var lblTemperature   : UILabel!
    @IBOutlet weak var lblHumidity      : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCellData(_ weatherMatData: WeatherMapData) {
        lblAreaName.text    = weatherMatData.name
        lblTemperature.text = weatherMatData.temp
        lblHumidity.text    = weatherMatData.humidity
    }

}
