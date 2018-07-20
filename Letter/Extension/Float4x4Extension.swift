//
//  Float4x4Extension.swift
//  Letter
//
//  Created by Bianca Itiroko on 20/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import SceneKit

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
