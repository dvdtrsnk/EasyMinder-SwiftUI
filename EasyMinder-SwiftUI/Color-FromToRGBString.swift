//
//  Color-FromToRGB.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import SwiftUI

extension Color {
    func toRGBString() -> String {
        guard let components = UIColor(self).cgColor.components else {
            return ""
        }
        
        let red = Int(components[0] * 255)
        let green = Int(components[1] * 255)
        let blue = Int(components[2] * 255)
        
        return "\(red), \(green), \(blue)"
    }
    
    static func fromRGBString(_ rgbString: String) -> Color {
        let components = rgbString.components(separatedBy: ",")
        
        guard components.count == 3,
              let red = Double(components[0].trimmingCharacters(in: .whitespaces)),
              let green = Double(components[1].trimmingCharacters(in: .whitespaces)),
              let blue = Double(components[2].trimmingCharacters(in: .whitespaces))
        else {
            return Color.black
        }
        
        let color = Color(
            red: red / 255.0,
            green: green / 255.0,
            blue: blue / 255.0
        )
        
        return color
    }
}
