/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation

class GradientBackgroundView: UIView {
    init(alpha: Float = 0.1, startPoint: CGPoint = CGPoint(x: -0.2, y: 0), endPoint: CGPoint = CGPoint(x: 1.2, y: 1)) {
        super.init(frame: CGRect.zero)

        backgroundColor = UIColor(hexString:"#1e93d1")

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
