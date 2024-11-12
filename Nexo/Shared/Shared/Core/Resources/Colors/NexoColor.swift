//
//  NexoColor.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 30/09/24.
//

import UIKit

import UIKit

public final class NexoColor {
    private static func loadColor(named name: String) -> UIColor {
        return UIColor(named: name, in: .shared, compatibleWith: nil) ?? .clear
    }
    
    // Complementary Colors
    public static var green01AF41: UIColor { return loadColor(named: "green01AF41") }
    public static var disable: UIColor { return loadColor(named: "disable") }
    
    // Core Colors
    public static var accent: UIColor { return loadColor(named: "accent") }
    public static var background: UIColor { return loadColor(named: "background") }
    public static var mainPrimary: UIColor { return loadColor(named: "mainPrimary") }
    public static var mainSecondary: UIColor { return loadColor(named: "mainSecondary") }
    public static var whiteF2F2F2: UIColor { return loadColor(named: "whiteF2F2F2") }
    
    // Criticality Colors
    public static var blue009ED0: UIColor { return loadColor(named: "blue009ED0") }
    public static var orangeFFA300: UIColor { return loadColor(named: "orangeFFA300") }
    public static var redC13018: UIColor { return loadColor(named: "redC13018") }
    public static var yellowFCD610: UIColor { return loadColor(named: "yellowFCD610") }
    
    // Gray Scale Colors
    public static var black040F14: UIColor { return loadColor(named: "black040F14") }
    public static var gray1: UIColor { return loadColor(named: "gray1") }
    public static var gray2: UIColor { return loadColor(named: "gray2") }
    public static var gray3: UIColor { return loadColor(named: "gray3") }
    public static var gray4: UIColor { return loadColor(named: "gray4") }
    public static var gray5: UIColor { return loadColor(named: "gray5") }
    public static var gray6: UIColor { return loadColor(named: "gray6") }
}
