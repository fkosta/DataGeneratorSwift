import Foundation
import ArgumentParser

struct DataGenerator: ParsableCommand{
    static let configuration = CommandConfiguration(
        abstract: "A swift command line tool to generate RIG test data",
        subcommands: [Generate.self]
    )
    
    init(){
        
    }
}

DataGenerator.main()

