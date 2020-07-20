//
//  CountyCell.swift
//  Parent_Aps_Task
//
//  Created by developer on 19/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    
    @IBOutlet weak var AddOrRemove: UIButton!
    
    @IBOutlet weak var CityName: UILabel!
    var CurrentState = ""
    var AddOrRemoveEvent: (()->(String))?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func SetCityName(CityName : String)  {
        self.CityName.text = CityName
    }
    
    @IBAction func AddOrRemoveBtn(_ sender: Any) {
       CurrentState  =  self.AddOrRemoveEvent?() ?? ""
        SetAddOrRemoveBtnTitle(Title : CurrentState)
       
    }
    func SetAddOrRemoveBtnTitle(Title : String) {
        CurrentState = Title
        AddOrRemove.setTitle(Title, for: .normal)
    }

}
