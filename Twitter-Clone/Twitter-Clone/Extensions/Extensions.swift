//
//  Extensions.swift
//  Twitter-Clone
//
//  Created by Niklas Fischer on 22/12/22.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


