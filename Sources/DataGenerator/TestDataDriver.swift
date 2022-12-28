//
//  TestDataSet.swift
//  DataGenerator
//
//  Created by Software Quality Assurance on 12.10.2022.
//

import Foundation

struct DriverData: Codable{
    var phoneNumber = ""
    var firstname = ""
    var lastname = ""
    var newFirstName = ""
    var newLastName = ""
    var notifications = false
    var messages = false
    var calls = false
    var updateProfilePicture = false
    var wheels: Array<String> = ["","",""]
    var tireSize = ""
    var tireBrand = ""
    var retreaded = false
    var make = ""
    var year = ""
    var model = ""
    var location = ""
    var destination = ""
    var locationLatitude: Decimal = 0.0
    var locationLongitude: Decimal = 0.0
    var updateLocationBeforeTests = true
    var removeBeforeAdd = true
    var uploadTiresImages = false
    var uploadMobileRequestImage = false
    
    init(){}
}
