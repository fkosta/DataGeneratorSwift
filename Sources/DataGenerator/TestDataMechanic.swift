//
//  TestDataMechanic.swift
//  DataGenerator
//
//  Created by Software Quality Assurance on 13.10.2022.
//

import Foundation
struct MechanicData: Codable{
    var phoneNumber = ""
    var mechanicType = ""
    var firstname = ""
    var lastname = ""
    var newFirstName = ""
    var newLastName = ""
    var notifications = false
    var messages = false
    var calls = false
    var updateProfilePicture = false
    var partsStop = Array<String>()
    var locationLatitude: Decimal = 0.0
    var locationLongitude: Decimal = 0.0
    var postalCode = ""
    var shopAddress = ""
    var shopName = ""
    var tirePrices: Array<Decimal> = [0.0,0.0,0.0]
    var prepTime:Decimal = 0.0
    var mileageRate: Decimal = 0.0
    var loadedMileageRate: Decimal = 0.0
    var hockFee: Decimal = 0.0
    var updateLocationBeforeTests = true
    var uploadServiceImages = true

    init(){}
}
