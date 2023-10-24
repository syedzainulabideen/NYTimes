//
//  ResuseableCell.swift
//  NYTimes
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var nibValue: UINib {
        return UINib(nibName: identifierValue, bundle: .main)
    }
}


extension NSObject {
    static var identifierValue: String {
        return String(describing: self)
    }
    
}
