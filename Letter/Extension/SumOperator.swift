//
//  Vector3Addition.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 20/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import ARKit

infix operator +
func + (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
    return SCNVector3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.y)
}
