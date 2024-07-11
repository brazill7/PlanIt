//
//  ModelColor.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import Foundation
import SwiftUI

struct ModelColor: Codable{
    var red: Float
    var green: Float
    var blue: Float
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = Float(red)
        self.green = Float(green)
        self.blue = Float(blue)
    }
    
    func getColor() -> Color{
        return Color(red: Double(red),
                     green: Double(green),
                     blue: Double(blue))
    }
}

extension Color {
    func toUIColor() -> UIColor {
        let components = UIColor(self).cgColor.components!
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

func dynamicColor(basedOn backgroundColor: Color) -> Color {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        UIColor(backgroundColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Calculate brightness
        let brightness = (red * 299 + green * 587 + blue * 114) / 1000
        
        // Return black or white based on brightness
        return brightness > 0.5 ? .black : .white
    }

extension UIColor {
    var r: CGFloat {
        return cgColor.components![0]
    }

    var g: CGFloat {
        return cgColor.components![1]
    }

    var b: CGFloat {
        return cgColor.components![2]
    }
}
