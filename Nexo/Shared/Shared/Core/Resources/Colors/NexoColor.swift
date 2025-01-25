//
//  NexoColor.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 30/09/24.
//

import UIKit

public final class NexoColor {
    static func loadColor(named name: String) -> UIColor {
        return UIColor(named: name, in: .shared, compatibleWith: nil) ?? .clear
    }
    
    // Complementary Colors
    public static var disable: UIColor { return loadColor(named: "disable") }
    public static var blue009ED0: UIColor { return loadColor(named: "blue009ED0") }
    
    // Core Colors
    public static var accent: UIColor { return loadColor(named: "accent") }
    public static var background: UIColor { return loadColor(named: "background") }
    public static var mainPrimary: UIColor { return loadColor(named: "mainPrimary") }
    public static var mainSecondary: UIColor { return loadColor(named: "mainSecondary") }
    public static var whiteF2F2F2: UIColor { return loadColor(named: "whiteF2F2F2") }
    
    // Criticality Colors
    public static var success: UIColor { return loadColor(named: "green_success") }
    public static var warning: UIColor { return loadColor(named: "orange_warning") }
    public static var failure: UIColor { return loadColor(named: "red_failure") }
    
    // Gray Scale Colors
    public static var black040F14: UIColor { return loadColor(named: "black040F14") }
    public static var gray1: UIColor { return loadColor(named: "gray1") }
    public static var gray2: UIColor { return loadColor(named: "gray2") }
    public static var gray3: UIColor { return loadColor(named: "gray3") }
    public static var gray4: UIColor { return loadColor(named: "gray4") }
    public static var gray5: UIColor { return loadColor(named: "gray5") }
    public static var gray6: UIColor { return loadColor(named: "gray6") }
}
