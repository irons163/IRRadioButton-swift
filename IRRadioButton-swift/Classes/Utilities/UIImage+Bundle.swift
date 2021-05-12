//
//  UIImage+Bundle.swift
//  IRRadioButton-swift
//
//  Created by Phil on 2021/5/12.
//

import Foundation
import UIKit

extension UIImage {
    class func imageNamedForCurrentBundle(named: String) -> UIImage? {
        return UIImage.init(named: named, in: Utilities.getCurrentBundle(), compatibleWith: nil)
    }
}
