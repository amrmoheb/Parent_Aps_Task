//
//  HideKeyboard.swift
//  Parent_Aps_Task
//
//  Created by developer on 20/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//


import Foundation
import UIKit
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
