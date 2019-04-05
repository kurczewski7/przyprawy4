//
//  Product.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 31.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//


import UIKit
class Product: NSObject  {
    //let database = Database()
    
    var producent   : String
    var productName : String
    var weight      : Int
    var eanCode     : String
    var number1     : Int
    var number2     : Int
    var number3     : Int
    var pictureName : String
    
    override init()
    {
        self.producent   = ""
        self.productName = ""
        self.weight      = 0
        self.eanCode     = ""
        self.number1     = 0
        self.number2     = 0
        self.number3     = 0
        self.pictureName = ""
        
    }
    init(producent: String, productName: String, weight: Int, eanCode: String, number1: Int, number2: Int, number3: Int, pictureName: String) {
        self.producent   = producent
        self.productName = productName
        self.weight      = weight
        self.eanCode     = eanCode
        self.number1     = number1
        self.number2     = number2
        self.number3     = number3
        self.pictureName = pictureName
    }
    func toString()
    {
        print("\(producent) :  \(productName) :  \(weight)  : \(eanCode) : \(number1) : \(number2) : \(number3)")
    }
}
