//
//  Created by Tom Baranes on 24/04/16.
//  Copyright © 2016 Tom Baranes. All rights reserved.
//

import UIKit

// MARK: Initializer


public extension UIImage {

    public convenience init(color: UIColor?) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color?.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }

}

// MARK: RenderingMode

public extension UIImage {

    public var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }

    public var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }

}
