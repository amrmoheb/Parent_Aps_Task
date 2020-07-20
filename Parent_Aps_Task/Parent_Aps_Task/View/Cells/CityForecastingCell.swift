//
//  CityForecastingCell.swift
//  Parent_Aps_Task
//
//  Created by developer on 19/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit

class CityForecastingCell: UITableViewCell {
    
    @IBOutlet weak var Date: UILabel!
    
    @IBOutlet weak var Time: UILabel!
    
    @IBOutlet weak var Tempreature: UILabel!
    
    @IBOutlet weak var Sky: UILabel!
    
    
    var viewModel : CityForcastingCellViewModel? {
        
        didSet
        {
            Date.text = viewModel?.Date
            Time.text = viewModel?.Time
            Tempreature.text = viewModel?.Tempreature
            Sky.text = viewModel?.Sky
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
