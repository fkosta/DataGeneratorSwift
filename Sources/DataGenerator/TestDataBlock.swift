//
//  TestDataBlock.swift
//  DataGenerator
//
//  Created by Software Quality Assurance on 12.10.2022.
//

import Foundation

struct TestDataBlock{
    
    private var mechanicAccounts: Array<String> = []
    private var driverAccounts: Array<String> = []
    private let firstName: Array<String> = ["Joe","Carl","Ivan","Pete","Mike","Elizabeth","Paul","George","John","Lewis"]
    private let lastName: Array<String> = ["Doe","Marx","Terrible","First","Second","Taylor","Richard","Bush","Lucas","Carrol"]
    private let tireTypes: Array<String> = ["steeringLeft","steeringRight","driveLeftFirst","driveLeftFirstI","driveRightFirst","driveRightFirstI","driveLeftSecond","driveLeftSecondI","driveRightSecond","driveRightSecondI","trailerLeftFront","trailerLeftFrontI","trailerRightFront","trailerRightFrontI","trailerLeftBack","trailerLeftBackI","trailerRightBack","trailerRightBackI"]
    private let tireSizes: Array<String> = ["11R22.5","11R24.5","255/70R22.5","285/75R24.5","295/75R22.5","10R22.5","225/70R19.5","245/70R19.5","275/80R22.5","285/70R19.5","445/50R22.5","455/55R22.5"]

    private let tireBrands: Array<String> = ["BridgeStone","Cooper","Continental","BFGoodrich","Goodyear","Michelin","Pirelli","Toyo","Yokohama"]

    private let destinations: Array<String> = ["6404 Telephone Road, Houston, TX 77061, United States","550 Telephone Road, Houston, TX 77061, United States","10404 Telephone Road, Houston, TX 77075, United States","2680 TX-35, Alvin, TX 77511, United States","4115 TX-35 S, Alvin, TX 77511, United States"]
    
    private let locations: Array<String> = ["Current location","6113 Telephone Road, Houston, TX 77087, United States"]
    
    private let carMakeYearModel = [["AUTOCAR","2022","AT"],["AUTOCAR","2022","DK"],["AUTOCAR","2021","S"],["AUTOCAR","2021","Xpeditor"],
                                    ["AUTOCAD","2022","Kombat"],["CATERPILLAR","2021","CF6AA"],["CATERPILLAR","2021","CF6AB"],["CATERPILLAR","2020","CF7AA"],
                                    ["HINO","2020","HS"],["HINO","2020","XJC700"],["HONDA","2019","Accord"],["HONDA","2019","CB1000"],
                                    ["HONDA","2020","CR-V"],["HONDA","2020","CB125"],["HYUNDAI","2021","Accent"],["HYUNDAI","2021","Elantra"],
                                    ["HYUNDAI","2022","Sonata"],["HYUNDAI","2022","Tucson"],["MITSUBISHI","2021","Galant"],["MITSUBISHI","2021","Lancer"],
                                    ["MITSUBISHI","2020","Outlander"],["MITSUBISHI","2020","RVR"],["SUZUKI","2019","AN400"],["SUZUKI","2019","AN400A"],
                                    ["SUZUKI","2018","DL1000K"],["SUZUKI","2018","DL650A"],["VOLVO","2019","B10M"],["VOLVO","2019","S90"]]
    
    // Randomly selects a first name for SignUp and Update prfile tests

    func getfirstName() -> String{
        let randInd = UInt8.random(in: 0...UInt8(firstName.count-1))
        return firstName[Int(randInd)]
    }
    
    // Randomly selects a last name for SignUp and Update prfile tests
    func getLastName() -> String{
        let randInd = UInt8.random(in: 0...UInt8(lastName.count-1))
        return lastName[Int(randInd)]
    }
    
    // Randomly selects a phone number for tests
    func getPhoneNumber(userType:String) -> String?{
        if userType == "mechanic"{
            let randInd = UInt8.random(in: 0...UInt8(mechanicAccounts.count-1))
            return mechanicAccounts[Int(randInd)]
        } else if userType == "driver"{
            let randInd = UInt8.random(in: 0...UInt8(driverAccounts.count-1))
            return driverAccounts[Int(randInd)]
        }
        else{
            return nil
        }
    }
        
    // Randomly selects a tire size for the tire service test
    func getTireSize() -> String {
        let randInd = UInt8.random(in: 0...UInt8(tireSizes.count-1))
        return tireSizes[Int(randInd)]
    }
    
    // Randomly selects a tire brand for the tire service test
    func getTireBrand() -> String{
        let randInd = UInt8.random(in: 0...UInt8(tireBrands.count-1))
        return tireBrands[Int(randInd)]
    }

    // If numWheels == 0, the arrays size is also random
    func getWheels(numWheels: Int) -> Array<String> {
        let wheelNumber = (numWheels == 0 ? Int.random(in: 1...tireTypes.count) : numWheels)

        var wheelsArray = tireTypes
        if wheelNumber < tireTypes.count{
            for _ in 0...(tireTypes.count - wheelNumber - 1){
                let randInd = UInt8.random(in: 0...UInt8(wheelsArray.count-1))
                wheelsArray.remove(at: Int(randInd))
            }
        }
        return wheelsArray.sorted()
    }
    
    func getWheel() -> String{
        let randInd = UInt8.random(in: 0...UInt8(tireTypes.count-1))
        return tireTypes[Int(randInd)]
    }
    
    func getCarMakeYearModel() -> Array<String>{
        let randInd = UInt8.random(in: 0...UInt8(carMakeYearModel.count-1))
        return carMakeYearModel[Int(randInd)]
    }
    
    mutating func setMechanicAccounts(mechAccounts:Array<String>){
        self.mechanicAccounts = mechAccounts
    }
    
    mutating func setDriverAccounts(drvAccounts:Array<String>){
        self.driverAccounts = drvAccounts
    }
}

