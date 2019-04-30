//
//  Server.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 13/03/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import Foundation
import UIKit

class Server {
    let httpProtocol="http";
    var urlString: String = ""
    var pictureUrlString = ""
    var url: URL? = nil
    var urlRequest:URLRequest? = nil
    var task: URLSession? = nil

    func makeSqlTxt(database db : Database) -> String  {
    
//        CREATE TABLE `product_table` (
//            `categoryId` int(10) DEFAULT NULL,
//            `changeDate` date NOT NULL,
//            `checked` tinyint(1) NOT NULL,
//            `eanCode` text COLLATE utf8_polish_ci NOT NULL,
//            `fullPicture` text COLLATE utf8_polish_ci NOT NULL,
//            `id` int(10) NOT NULL,
//            `number1` int(10) NOT NULL,
//            `number2` int(10) NOT NULL,
//            `number3` int(10) NOT NULL,
//            `pictureName` text COLLATE utf8_polish_ci NOT NULL,
//            `producent` text COLLATE utf8_polish_ci NOT NULL,
//            `productName` text COLLATE utf8_polish_ci NOT NULL,
//            `searchTag` text COLLATE utf8_polish_ci NOT NULL,
//            `smallPicture` text COLLATE utf8_polish_ci NOT NULL,
//            `weight` int(10) NOT NULL
//        ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
        
        var isNumber: Bool = false 
        var tekst: String = ""
        var tx: [String] =  ["","","","","","","","","","","","","","",""]
        let integerFields: [Int] = [0, 2, 5, 6, 7, 8, 14]

//        tekst =  "INSERT INTO `dvds` (`filmId`, `title`, `filmDirector`, `actors`, `type`, `filmDescription`, `filmImageName`, `youtubeUrl`, `price`, `isLiked`) VALUES \n"
        
        
        tekst = "INSERT INTO `product_table` (`categoryId`, `changeDate`, `checked`, `eanCode`, `fullPicture`, `id`, `number1`, `number2`, `number3`, `pictureName`, `producent`, `productName`, `searchTag`, `smallPicture`, `weight`) VALUES\n"
        
        let dbArray = db.product.productArray
        for i in 0..<dbArray.count   {
            tx[0] = "\(dbArray[i].categoryId)"            
            tx[1] =  getStringDate(forDate: dbArray[i].changeDate)                                           //"\(dbArray[i].changeDate ?? Date())"
            tx[2] = "\(dbArray[i].checked)"
            tx[3] = "\(dbArray[i].eanCode ?? "")"
            tx[4] =  "pict_\(dbArray[i].eanCode ?? "")"
            tx[5] = "\(dbArray[i].id)"
            tx[6] = "\(dbArray[i].number1)"
            tx[7] = "\(dbArray[i].number2)"
            tx[8] = "\(dbArray[i].number3)"
            tx[9] =  dbArray[i].pictureName ?? "pict00"
            tx[10] = dbArray[i].producent ?? ""
            tx[11] = dbArray[i].productName ?? ""
            tx[12] = dbArray[i].searchTag ?? ""
            tx[13] = "pict_\(dbArray[i].eanCode ?? "")"
            tx[14] = "\(dbArray[i].weight)"

            tekst += "("
            for t in 0..<tx.count-1 {
                isNumber = find(forArray: integerFields, findElement: t)
                tekst += (isNumber ? "" : "'")+"\(tx[t])"+(isNumber ? "," :"', ")
            }
            isNumber = find(forArray: integerFields, findElement: tx.count-1)
            tekst += (isNumber ? "" : "'")+"\(tx[tx.count-1])"+(isNumber ? "" :"'")
            tekst += (i < dbArray.count-1) ? "),  \n " : "); \n"
        }
        return tekst
    }
    func find(forArray arr: [Int], findElement el: Int)  -> Bool {
        var val = false
        for tmp in arr {
            if tmp == el {
                val = true
            }
        }
        return val
    }
    func getStringDate(forDate myDate: Date?) -> String {
        var date: Date!
        if myDate == nil {
            date = Date()
        }
        else {
            date = myDate
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let todaysDate = dateFormatter.string(from: date)
        print(todaysDate)
        return todaysDate
    }
//-----------------------
func xxxxxx() -> String{
    let sqlText = "CREATE TABLE `persons7` (`Personid` int(11) NOT NULL, `LastName` varchar(255) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL, `FirstName` varchar(255) CHARACTER SET utf8 COLLATE utf8_polish_ci DEFAULT NULL, `Age` int(11) DEFAULT NULL );"
    return sqlText
}
    func sqlExec(forId id: String, sqlText: String)  {
    //let parameters: [String: String] = ["firstName": "nametextField.text", "lastName": "passwordTextField.text"]
    let configuration=URLSessionConfiguration.default
    let session=URLSession(configuration: configuration)
    //let session2 = URLSession.shared
    let url=URL(string: "\(httpProtocol)://http://skurczewski.myqnapcloud.com/testapi/start.php/sql/")!
    var urlRequest=URLRequest(url: url)
    
    urlRequest.httpMethod="POST"
    urlRequest.timeoutInterval = 60
    
    // let id = idNumberInsertTextView.text ?? "0"
    //let sqlText =  sqlTextField.text ?? ""
    print("\(sqlText)")
    let keyValues = "id=\(id)&sqltext=\(sqlText)"
    urlRequest.httpBody = keyValues.data(using: String.Encoding.utf8)
    
    let task = session.dataTask(with: urlRequest) { (data, response, error) in
        guard let data = data, error == nil else { return }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
        }
        do {
            //create json object from data
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]  {
                print(json)  }
        } catch let error {
            print(error.localizedDescription)
        }
        print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "default value")
    }
    task.resume()
}
    func insert(id:String, firstName: String, lastName: String) {
    //  let parameters: [String: String] = ["firstName": "nametextField.text", "lastName": "passwordTextField.text"]
    let configuration=URLSessionConfiguration.default
    let session=URLSession(configuration: configuration)
    //let session2 = URLSession.shared
    let url=URL(string: "\(httpProtocol)://skurczewski.myqnapcloud.com/testapi/start.php/insert/test/")!
    var urlRequest=URLRequest(url: url)
    
    urlRequest.httpMethod="POST"
    urlRequest.timeoutInterval = 60
    
    print("\(firstName) \(lastName)")
    
    let keyValues = "id=\(id)&firstName=\(firstName)&lastName=\(lastName)"
    urlRequest.httpBody = keyValues.data(using: String.Encoding.utf8)
    
    let task = session.dataTask(with: urlRequest) { (data, response, error) in
        guard let data = data, error == nil else { return }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 { // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
        }
        
        do {
            //create json object from data
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]  {
                print(json)  }
        } catch let error {
            print(error.localizedDescription)
        }
        print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "default value")
    }
    task.resume()
}
func delete(idDeleteText: String)  {
    let configuration=URLSessionConfiguration.default
    let session=URLSession(configuration: configuration)
    let fullUrlString = "\(httpProtocol)://skurczewski.myqnapcloud.com/testapi/start.php/delete/test//\(idDeleteText)"
    let url = URL(string: fullUrlString)
    var urlRequest = URLRequest(url: url!)
    
    urlRequest.httpMethod = "POST"
    urlRequest.timeoutInterval = 60
    let task = session.dataTask(with: urlRequest) { (data, response, error) in
        guard let data = data, error == nil else { return }
        print("data-------------")
        print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "default value")
        print("end data-------------")        }
    task.resume()
}

//--------------------------
    func xxxxx(urlString: String, fieldsValues: [String: String], images: [UIImage]?) {
    //http://www.webpage.com/folder/start.php/upload/"destination folder"/"max picture size in kb"
    let url = URL(string: "http://skurczewski.myqnapcloud.com/testapi/start.php/upload/pictures/900")!
    let param = ["firstName":"Jan", "lastName":"Kobuszewski", "userId":"1967"]
    let fileNames = ["user-profile1.jpg", "user-profile2.jpg"]
    //let images = [imageView2.image!, imageView1.image!]
    guard images != nil else {   return        }
    imageUploadRequest(images: images!, uploadUrl: url, param: param, fileNames: fileNames)
}
func imageUploadRequest(images: [UIImage], uploadUrl: URL, param: [String:String]?,  fileNames: [String], filePathKeys: String = "filesToUpload[]") {
    // var imagesData: [UIImage] = [UIImage]()
    let boundary = generateBoundaryString()
    var request = URLRequest(url: uploadUrl)
    
    request.httpMethod = "POST"
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    request.httpBody = createBodyWithParameters(parameters: param, filePathKey: filePathKeys, images: images, boundary: boundary)
    
    //myActivityIndicator.startAnimating();
    let task =  URLSession.shared.dataTask(with: request as URLRequest)
    {
        (data, response, error) -> Void in
        if let myError = error {
            print(myError.localizedDescription)
            exit(0)
        }
        if let data = data {
            // Print out reponse body
            let responseString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            print("response data = \(responseString!)")
            ///let json =  try!JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            //print("json value: \(String(describing: json)) end json")
            //var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err)
            DispatchQueue.main.async () {
                //self.myActivityIndicator.stopAnimating()
                //self.imageView.image = nil;
            }
        }
    }
    task.resume()
}
func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, images: [UIImage], boundary: String, fileNames: [String] = ["picture.jpg","picture-min.jpg"]) -> Data {
    let mimeType = "image/jpg"
    var body = Data()
    
    if parameters != nil {
        for (key, value) in parameters! {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        let imageDataKey: Data? = images[0].jpegData(compressionQuality: 1.0)
        putPicture(&body, boundary: boundary, filePathKey: filePathKey, fileName: fileNames[0], mimeType: mimeType, imageDataKey: imageDataKey)
        let imageDataKey2: Data? = images[1].jpegData(compressionQuality: 1.0)
        putPicture(&body, boundary: boundary, filePathKey: filePathKey, fileName: fileNames[1], mimeType: mimeType, imageDataKey: imageDataKey2)
    }
    return body
}
func putPicture(_ body: inout Data, boundary: String, filePathKey: String?, fileName: String, mimeType: String, imageDataKey: Data?) {
    if let imageData = imageDataKey {
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(fileName)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(imageData)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        }
}
func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
    }
}
extension Data {
    mutating func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

 //   func xxx() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
//        let date = Date()
//        print(date)
        
//        let date : Date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let todaysDate = dateFormatter.string(from: date)
//        print(todaysDate)
    
//    }

    
    
//    var currentDay="2017-06-11"
//    var dvds = [Dvd]()
//    var currencies = [String: Double]()
//    var valuteExchange: [String: Double] = ["USD": 0.0, "EUR" : 0.0]
//    var errrorDvdsNet: Bool = false
//    var errorCurrencyNet: Bool = false
    
    // exchange rate link NBP http://api.nbp.pl/api/exchangerates/rates/c/eur/2017-06-14/?format=json
    // var nbpFullExchangeLink = "http://api.nbp.pl/api/exchangerates/tables/c/?format=json"
    
//    init() {
//        self.urlString = "http://skurczewski1.myqnapcloud.com/dvdshop/api.php/dvds/"
//        self.pictureUrlString = "http://skurczewski1.myqnapcloud.com/dvdshop/img/"
//        getValuteExchangeRate()
//        getLatestDvds()
//        print("Status error NET dvds:\(self.errrorDvdsNet), valuta: \(self.errorCurrencyNet)")
//    }
//
//    func getLatestDvds() {
//        print("-------- Geting Film data from NET ---------")
//        print("url:\(self.urlString)")
//        guard let url = URL(string: urlString) else {
//            return        }
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request, completionHandler:
//        { (data, response, error) -> Void in
//
//            if let error = error {
//                print(error)
//                self.errrorDvdsNet=true
//                return   }
//            // Parse JSON data
//            if let data = data {
//                self.dvds = self.parseJsonData(data: data)
//            }
//        }
//        )
//        task.resume()
//    }
//
//    func getValuteExchangeRate() {
//        print("-------- Geting currency rate from NET (USD, EUR) ---------")
//        let urlCurrencyString = self.nbpFullExchangeLink
//        print("url:\(urlCurrencyString)")
//        guard let url = URL(string: urlCurrencyString) else {
//            return      }
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request, completionHandler:
//        { (data, response, error) -> Void in
//            if let error = error {
//                print(error)
//                self.errorCurrencyNet=true
//                return   }
//
//            // Parse JSON data
//            if let data = data {   self.parseJsonValuteData(data: data)    }
//        })
//        task.resume()
//    }
//
//
//    func parseJsonData(data: Data) -> [Dvd] {
//        var dvds = [Dvd]()
//        do {
//            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
//
//            // Parse JSON data
//            let jsonDvds = jsonResult?["dvds"] as! [AnyObject]
//            for jsonDvd in jsonDvds {
//                let dvd = Dvd()
//
//                dvd.actors          = jsonDvd["title"] as! String
//                dvd.filmDescription = jsonDvd["filmDescription"] as! String
//                dvd.filmDirector    = jsonDvd["filmDirector"] as! String
//                dvd.filmId          = jsonDvd["filmId"] as! String
//                dvd.filmImageName   = jsonDvd["filmImageName"] as! String
//                dvd.filmImageData   =  getPictureWeb(pictureName: dvd.filmImageName)
//                dvd.isLiked         = (jsonDvd["isLiked"] as! String)=="1" ? true : false
//                dvd.price           = jsonDvd["price"] as! String
//                dvd.title           = jsonDvd["title"] as! String
//                dvd.type            = jsonDvd["type"] as! String
//                dvd.youtubeUrl      = jsonDvd["youtubeUrl"] as! String
//                dvds.append(dvd)
//            }
//        } catch {   print(error)
//            self.errrorDvdsNet=true }
//        return dvds
//    }
//
//    func parseJsonValuteData(data: Data)  {
//        var elem: [String: Any]
//        currencies.removeAll(keepingCapacity: false)
//        var key: String
//        var value: Double = 0.0
//
//        do {
//            let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
//            if let array = jsonResult as? [Any] {
//                if let firstObject=array.first as? [String: Any]{
//                    let day=firstObject["tradingDate"]
//                    self.currentDay = day as? String ?? "2017-06-13"
//                    let rates = firstObject["rates"] as?  [Any]
//                    if let  maxElem = rates?.count {
//                        for i in 0..<maxElem {
//                            elem = rates![i] as! [String : Any]
//                            key = elem["code"] as! String
//                            value = elem["ask"] as! Double
//                            self.currencies[key] = value
//                            self.currencies.updateValue(elem["ask"] as! Double, forKey: elem["code"] as! String)
//                            print("$ \(self.currentDay)   \(elem["code"] ?? 0.0):  \(elem["ask"] ?? 0.0)")
//                            self.valuteExchange["USD"]=self.currencies["USD"] ?? 0.0
//                            self.valuteExchange["EUR"]=self.currencies["EUR"] ?? 0.0
//                        }
//                    }
//                }
//            }
//
//        } catch {   self.errorCurrencyNet=true
//            print(error)     }
//        return
//
//        // Parse JSON data
//
//    }
//
//
//    //                dvd.actors          = jsonDvd["title"] as! String
//    //                dvd.filmDescription = jsonDvd["filmDescription"] as! String
//    //                dvds.append(dvd)
//
//    func makeJsonTxt(database db : Database) -> String {
//        var tekst: String = ""
//        var tx: [String] = ["","","","","","","","","","",""]
//        let brak = "brak"
//
//        tekst =  "{ \"dvds\" : ["
//        for i in 0..<db.flimsbaseFull.count  {
//            tx[0] = "  {\"filmId\":\"\(db.flimsbaseFull[i].filmId ??  brak)\""
//            tx[1] = ", \"title\":\"\(db.flimsbaseFull[i].title ?? "")\""
//            tx[2] = ", \"filmDirector\":\"\(db.flimsbaseFull[i].filmDirector ?? "")\""
//            tx[3] = ", \"actors\":\"\(db.flimsbaseFull[i].actors ?? "")\""
//            tx[4] = ", \"type\":\"\(db.flimsbaseFull[i].type ?? "")\""
//            tx[5] = ", \"filmDescription\":\"\(db.flimsbaseFull[i].filmDescription ?? "")\""
//            tx[6] = ", \"filmImageName\":\"\(db.flimsbaseFull[i].pictureName ?? "")\""
//            tx[7] = ", \"youtubeUrl\":\"\(db.flimsbaseFull[i].youtubeUrl ?? "")\""
//            tx[8] = ", \"price\":\"\(db.flimsbaseFull[i].price )\""
//            tx[9] = ", \"isLiked\":\"\(db.flimsbaseFull[i].isLiked ? "1" : "0")\"}"
//            tx[10] = (i < db.flimsbaseFull.count-1) ? ",  \n " : " \n"
//            for t in 0..<tx.count {
//                tekst += tx[t]
//            }
//        }
//        tekst += "]}"
//        return tekst
//    }
//
//    func makeSqlTxt(database db : Database) -> String  {
//        var tekst: String = ""
//        var tx: [String] = ["","","","","","","",""]
//        let brak = "brak"
//        
//        tekst =  "INSERT INTO `dvds` (`filmId`, `title`, `filmDirector`, `actors`, `type`, `filmDescription`, `filmImageName`, `youtubeUrl`, `price`, `isLiked`) VALUES \n"
//
//        for i in 0..<db.flimsbaseFull.count  {
//            tx[0] = db.flimsbaseFull[i].filmId ??  brak
//            tx[1] = db.flimsbaseFull[i].title ?? ""
//            tx[2] = db.flimsbaseFull[i].filmDirector ?? ""
//            tx[3] = db.flimsbaseFull[i].actors ?? ""
//            tx[4] = db.flimsbaseFull[i].type ?? ""
//            tx[5] = db.flimsbaseFull[i].filmDescription ?? ""
//            tx[6] = db.flimsbaseFull[i].pictureName ?? ""
//            tx[7] = db.flimsbaseFull[i].youtubeUrl ?? ""
//            print("SQL picName:"+db.flimsbaseFull[i].pictureName!)
//
//            tekst += "("
//            for t in 0..<tx.count {
//                tekst += "'\(tx[t])', "
//            }
//            tekst += kantor.doubleToString(db.flimsbaseFull[i].price)+", "
//            tekst += db.flimsbaseFull[i].isLiked ? "1" : "0"
//            tekst += (i < db.flimsbaseFull.count-1) ? "),  \n " : "); \n"
//        }
//        return tekst
//    }
//
//    func getPictureWeb(pictureName: String) -> Data? {
//        var data:Data?
//        let url = URL(string: "\(pictureUrlString)\(pictureName).jpg")
//
//        do {  data = try Data(contentsOf: url!)
//        } catch {
//            data = nil
//            if let img = UIImage(named: "placeholder.jpg"){
//                data = UIImagePNGRepresentation(img)
//            }
//        }
//        return data
//    }
//
//    func fillDatabaseFromWeb() {
//
//    }


