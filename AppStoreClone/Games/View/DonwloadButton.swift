//
//  DonwloadButton.swift
//  AppStoreClone
//
//  Created by 1 on 2022/09/05.
//

import UIKit

class DonwloadButton: UIButton {
    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width + 10, height: super.intrinsicContentSize.height)
    }
}
