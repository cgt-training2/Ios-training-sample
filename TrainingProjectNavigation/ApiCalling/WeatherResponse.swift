//
//  WeatherResponse.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 01/07/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import ObjectMapper
class WeatherResponse : Mappable {
    
    var location : String?
    var threeDayForecast: [Forecast]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        location <- map["location"]
        threeDayForecast <- map["three_day_forecast"]
    }
}

class  Forecast: Mappable {
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        day <- map["day"]
        temperature <- map ["temperature"]
        conditions <- map["conditions"]
    }
    
    var day : String?
    var temperature : Int?
    var conditions: String?
}
