//
//  dataGen.swift
//  DataGenerator
//
//  Created by Software Quality Assurance on 11.10.2022.
//

import Foundation
import ArgumentParser
import SwiftCSV

struct Generate:ParsableCommand{
    public static let configuration = CommandConfiguration(abstract: "Data generator for RIG applications")
    
    @Argument(help: "The file name of driver data")
    private var driverDataFileName: String

    @Argument(help: "The file name of mechanic data")
    private var mechanicDataFileName: String
    
    @Argument(help: "The file name with available accounts")
    private var accountsFileName: String
    
    @Argument(help: "The file name with locations")
    private var locationsFileName: String
    
    @Argument(help: "CSV file with data generator parameters")
    private var configFileName: String

    func run(){
        var testDataBlock = TestDataBlock()
        var driverTestData = DriverData()
        var mechanicTestData = MechanicData()
        
        do{
            let configFile:CSV = try CSV<Named>(url: URL(fileURLWithPath: configFileName))
            let partsStops = configFile.rows[0]["partsStops"]
            let tireTypesNum = Int(configFile.rows[0]["tireTypesNum"]!)!
            
            do{
                let locationsFile:CSV = try CSV<Named>(url: URL(fileURLWithPath: locationsFileName))
            
                do{
                    let accountsFile:CSV = try CSV<Named>(url: URL(fileURLWithPath: accountsFileName))

                    var mechAccountsArray = [String]()
                    var drvAccountsArray = [String]()
                
                    for ind in 0..<accountsFile.rows.count{
                        if accountsFile.rows[ind]["type"]! == "mechanic"{
                            mechAccountsArray.append(accountsFile.rows[ind]["phone"]!)
                        }
                        else{
                            drvAccountsArray.append(accountsFile.rows[ind]["phone"]!)
                        }
                    }
                
                    testDataBlock.setDriverAccounts(drvAccounts: drvAccountsArray)
                    testDataBlock.setMechanicAccounts(mechAccounts: mechAccountsArray)
                
                    let locNum:Int = locationsFile.rows.count
            
                    driverTestData.phoneNumber = testDataBlock.getPhoneNumber(userType: "driver") ?? "5555557777"
            
                    driverTestData.firstname = testDataBlock.getfirstName()
                    driverTestData.lastname = testDataBlock.getLastName()
                    driverTestData.newFirstName = driverTestData.firstname
                    driverTestData.newLastName = driverTestData.lastname
                    
                    driverTestData.notifications = Bool.random()
                    driverTestData.messages = Bool.random()
                    driverTestData.calls = Bool.random()
                    driverTestData.wheels = testDataBlock.getWheels(numWheels: tireTypesNum)
                    driverTestData.tireSize = testDataBlock.getTireSize()
                    driverTestData.tireBrand = testDataBlock.getTireBrand()
                    driverTestData.retreaded = Bool.random()
                    let carMakeYearModel = testDataBlock.getCarMakeYearModel()
                    driverTestData.make = carMakeYearModel[0]
                    driverTestData.year = carMakeYearModel[1]
                    driverTestData.model = carMakeYearModel[2]
            
                    var randInd = Int.random(in: 0..<locNum)
                    if !Bool(configFile.rows[0]["useCurrent"]!)!{
                        driverTestData.location = locationsFile.rows[randInd]["location"]!
                        randInd = Int.random(in: 0..<locNum)
                    }
                    else{
                        driverTestData.location = "Current Location"
                    }

                    driverTestData.locationLatitude = roundDecimal(Decimal(Double(locationsFile.rows[randInd]["latitude"]!)!),4)
                    driverTestData.locationLongitude = roundDecimal(Decimal(Double(locationsFile.rows[randInd]["longitude"]!)!),4)

                    randInd = Int.random(in: 0..<locNum)
                    driverTestData.destination = locationsFile.rows[randInd]["location"]!

                    driverTestData.updateLocationBeforeTests = Bool(configFile.rows[0]["updateDrvLoc"]!)!
                    driverTestData.updateProfilePicture = Bool(configFile.rows[0]["updateDrvImages"]!)!
                    driverTestData.removeBeforeAdd = Bool.random()
                    driverTestData.uploadTiresImages = Bool(configFile.rows[0]["updateTiresImages"]!)!
                    driverTestData.uploadMobileRequestImage = Bool(configFile.rows[0]["uploadMobileRequestImage"]!)!
            
                    mechanicTestData.phoneNumber = testDataBlock.getPhoneNumber(userType: "mechanic") ?? "5555553333"
                    
                    mechanicTestData.firstname = testDataBlock.getfirstName()
                    mechanicTestData.lastname = testDataBlock.getLastName()
                    mechanicTestData.newFirstName = mechanicTestData.firstname
                    mechanicTestData.newLastName = mechanicTestData.lastname
                    
                    mechanicTestData.notifications = Bool.random()
                    mechanicTestData.messages = Bool.random()
                    mechanicTestData.calls = Bool.random()
                    mechanicTestData.updateProfilePicture = Bool(configFile.rows[0]["updateMechImages"]!)!

                    randInd = Int.random(in: 0..<locNum)

                    mechanicTestData.locationLatitude = roundDecimal(Decimal(Double(locationsFile.rows[randInd]["latitude"]!)!),4)
                    mechanicTestData.locationLongitude = roundDecimal(Decimal(Double(locationsFile.rows[randInd]["longitude"]!)!),4)

                    var pStops = Int(partsStops!)!
                    if pStops > 0{
                        var partStopsLocations:[String] = []
                        while pStops > 0{
                            randInd = Int.random(in: 0..<locNum)
                            partStopsLocations.append(locationsFile.rows[randInd]["location"]!)
                            pStops = pStops-1
                        }
                        mechanicTestData.partsStop = partStopsLocations
                    }

                    mechanicTestData.updateLocationBeforeTests = Bool(configFile.rows[0]["updateMechLoc"]!)!

                    mechanicTestData.tirePrices = [getRandomFormattedDecimal(in: 1...20.0, scale: 2),getRandomFormattedDecimal(in: 1...20.0, scale: 2),getRandomFormattedDecimal(in: 1...20.0, scale: 2)]
                    mechanicTestData.mileageRate = getRandomFormattedDecimal(in: 1...20.0, scale: 2)
                    mechanicTestData.loadedMileageRate = getRandomFormattedDecimal(in: 1...20.0, scale: 2)
                    mechanicTestData.prepTime = Int.random(in: 1...20)
                    mechanicTestData.hockFee = getRandomFormattedDecimal(in: 1...20.0, scale: 2)
                    mechanicTestData.uploadServiceImages = Bool(configFile.rows[0]["uploadServiceImages"]!)!
                    mechanicTestData.mobileServiceLevel = Int.random(in: 0...1)
                    mechanicTestData.diagnosticFeePartsCost = getRandomFormattedDecimal(in: 1...20.0, scale: 2)
                    mechanicTestData.laborCost = getRandomFormattedDecimal(in: 1...20.0, scale: 2)
            
                    writeJSONFile(inputStruct: driverTestData, fname:driverDataFileName)
                    writeJSONFile(inputStruct: mechanicTestData, fname: mechanicDataFileName)
            
                    print("Test data have been written to files")
                }
                catch{
                    print("accounts.csv file is not found")
                }
            }
            catch{
                print("locations.csv file is not found")
            }
        }
        catch{
            print("Configuration file is not found")
        }
    }
    
    func getRandomFormattedDecimal(in: ClosedRange<Double>, scale: Int)->Decimal{
        var formattedDecimalValue = Decimal()
        var inValue:Decimal = Decimal(Double.random(in: 1...20.0))
        NSDecimalRound(&formattedDecimalValue, &inValue,scale,NSDecimalNumber.RoundingMode.plain)
        return formattedDecimalValue
    }
    
    func roundDecimal(_ inValue: Decimal,_ scale: Int)->Decimal{
        var formattedDecimalValue = Decimal()
        var inV = inValue
        NSDecimalRound(&formattedDecimalValue, &inV,scale,NSDecimalNumber.RoundingMode.plain)
        return formattedDecimalValue
    }

    func writeJSONFile<T:Codable>(inputStruct: T, fname:String){
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.withoutEscapingSlashes, .prettyPrinted]
        
        do{
            let jsonData = try encoder.encode(inputStruct.self)
            let filePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            
            let fileURL = URL(fileURLWithPath: fname, relativeTo: filePath)
            
            do{
                try jsonData.write(to: fileURL)
            }
            catch{
                print("Error in writing file")
            }
        }
        catch{
            print("The data can't be converted")
        }
    }
}
