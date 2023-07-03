//
//  BaseTableViewCell.swift
//  course3
//
//  Created by Tam Le on 03/07/2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    class var identifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
}
