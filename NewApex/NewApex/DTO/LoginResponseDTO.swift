//
//  LoginResponseDTO.swift
//  NewApex
//
//  Created by Hemareddy Halli on 4/14/19.
//  Copyright © 2019 Apex Capital Corp. All rights reserved.
//

import Foundation
class LoginResponseDTO: ApexBaseDTO
{
    var sessionID: String?
    var friendlyName: String?
    var userName: String?
    var password: String?
    var latestVersionMessage: String?
    var requiredVersionMessage: String?
    var profileCount: NSNumber?
    var profileId: NSNumber?
    var requiredDocuments: [Any]?
    var tutorialsRequired: NSNumber?
    var tutorialsCount: NSNumber?
}
