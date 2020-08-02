//
//  UIView+Extensions.swift
//
//  Created by Kirill Chistyakov on 29.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

extension UIView {
    
    var snapshotView: UIView {
        if let tempSnapshotView = self.snapshotView(afterScreenUpdates: true) {
            tempSnapshotView.bounds = tempSnapshotView.bounds.applying(self.transform)
            return tempSnapshotView
        }
        let transformedBounds = self.bounds.applying(self.transform)
        UIGraphicsBeginImageContextWithOptions(transformedBounds.size, self.isOpaque, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImageView(image: image)
    }

}
