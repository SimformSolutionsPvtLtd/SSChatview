//
//  Font+Extension.swift
//  SSChatView
//
//  Created by Palak Doshi on 01/08/23.
//

import SwiftUI

extension Font {

    static func regularFont(size: CGFloat) -> Font {
        return Font.custom(appFont.poppinsRegular.name, size: size)
    }

    static func boldFont(size: CGFloat) -> Font {
        return Font.custom(appFont.poppinsBold.name, size: size)
    }

    static func thinFont(size: CGFloat) -> Font {
        return Font.custom(appFont.poppinsThin.name, size: size)
    }

    static func mediumFont(size: CGFloat) -> Font {
        return Font.custom(appFont.poppinsMedium.name, size: size)
    }

    static func semiBoldFont(size: CGFloat) -> Font {
        return Font.custom(appFont.poppinsSemiBold.name, size: size)
    }

}
