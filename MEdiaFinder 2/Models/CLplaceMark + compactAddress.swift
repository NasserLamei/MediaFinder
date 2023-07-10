//
//  CLplaceMark + compactAddress.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 5/5/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import MapKit
extension CLPlacemark{
    var compactAddress: String? {
        if let name = name{
            var result = name
            if let streat = thoroughfare{
                result += ", \(streat)" }
                if let city = locality{
                    result += ", \(city)"}
                    if let country = country{
                        result += ", \(country)"
                    }
                    return result
            }
        
 return nil
        
    }
    
}
