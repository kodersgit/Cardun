//
//  webServ.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 2/15/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

class webServ: NSObject {
    
    let name: String
    let params: Array<Any>
    
    
    init(name: String, params: Array<Any>) {
        self.name = name
        self.params = params
    }
    
    func POST(name: String, params: Array<Any>) -> NSMutableURLRequest {
        
        var headers: Dictionary<String, String> = ["": ""]
        var URL: String = "http://cardun.ir/api/"
        var parameters: Dictionary<String, Any> = ["": ""]
        
        switch name {
        case "checkPhoneNumber":
            headers = [
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.11.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "43ac4280-c01d-4b79-a2c0-5eaa06e796c1,68f869a0-b705-4544-9054-7e81668a0778",
                "Host": "cardun.ir",
                "accept-encoding": "gzip, deflate",
                "content-length": "38",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            URL = "127.0.0.1/recipient/account/checkPhoneNumber"
            parameters = ["phoneNumber": params[0] as Any]
        case "sendOTP":
            headers = [
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.11.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "db5b5f3d-6e56-45ef-b5bd-a6116993bf26,c8342d15-5845-4db3-8db1-97f99e27227b",
                "Host": "cardun.ir",
                "accept-encoding": "gzip, deflate",
                "content-length": "38",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            URL = "127.0.0.1/recipient/account/sendOTP"
            parameters = ["phoneNumber": params[0] as Any]
        case "ValidateOTP":
            headers = [
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.11.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "4d685b00-6eef-4c2c-9fee-dae00740abb9,0622d65e-5b31-4638-b203-63645fa2684a",
                "Host": "www.cardun.ir",
                "accept-encoding": "gzip, deflate",
                "content-length": "80",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            URL = "127.0.0.1/recipient/account/validateOTP"
            parameters = ["phoneNumber": params[0], "otp": params[1], "oneSignalUserID": params[2] as Any]
        case "getUserData":
            headers = [
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.11.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "530b6fe1-510e-43b3-b13e-9eb3bee2aef9,58cfc518-5851-4dfd-b344-0391f2f93692",
                "Host": "cardun.ir",
                "accept-encoding": "gzip, deflate",
                "content-length": "116",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            URL = "127.0.0.1/generic/getUserData"
            parameters = ["token": params[0] as Any]
        case "Search":
            headers = [
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "ecfb3c47-959b-457b-8e1f-efbefe01d2c5,b78414d9-4495-482d-b0fb-d299a482266b",
                "Host": "cardun.ir",
                "accept-encoding": "gzip, deflate",
                "content-length": "48",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            URL = "http://cardun.ir/recipient/search"
            parameters = ["search_id": params[0], "keyword": params[1] as Any]
        case "FinalizeRequest":
            headers = [
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "bf250627-2423-47d5-814b-d3df1964d085,7fe51a9a-f855-4d93-84ef-12708078168c",
                "Host": "www.cardun.ir",
                "accept-encoding": "gzip, deflate",
                "content-length": "251",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            URL = "http://cardun.ir/recipient/finalizeRequest"
            parameters = ["token": params[0], "description": params[1], "address": params[2], "image": params[3], "location_lat": params[4], "location_lng": params[5], "radius": params[6], "service_id": params[7] ]
        case "DepositGift":
            headers = [
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "7a15e494-91ac-4a83-b880-8c8ff3474bc6,ddeb584d-def8-401c-85d6-799455b0650c",
                "Host": "cardun.ir",
                "accept-encoding": "gzip, deflate",
                "content-length": "139",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            URL = "http://cardun.ir/generic/depositGift"
            parameters = ["token": params[0], "giftCode": params[1]]
        case "CancelRequest":
            headers = [
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "95da8fbf-8102-4d59-abf4-2736c85fdb46,43106de8-0bf4-484b-a2e2-44a377b075d5",
                "Host": "cardun.ir",
                "accept-encoding": "gzip, deflate",
                "content-length": "138",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            URL = "http://cardun.ir/recipient/cancelRequest"
            parameters = ["token": params[0], "order_id": params[1] as Any]
            
        case "UpdateProfile":
            headers = [
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "f5ad9d38-c18c-4845-b959-debcf2664c90,426bdb62-e6d8-4c31-997e-322be8680c29",
                "Host": "cardun.ir",
                "accept-encoding": "gzip, deflate",
                "content-length": "200",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            URL = "http://cardun.ir/recipient/updateProfile"
            parameters = ["token": params[0], "first_name": params[1], "last_name": params[2], "username": params[3], "address": params[4] as Any]
        case "loginRecipient":
            headers = [
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "5741f37c-933c-4da6-b526-d73fb70884da,75f48bbb-e4da-4ec9-ae97-71dccecabdd3",
                "Host": "cardun.ir",
                "cookie": "PHPSESSID=561c5a73445eb21d217c53108234a591",
                "accept-encoding": "gzip, deflate",
                "content-length": "68",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            parameters = ["method": "loginRecipient", "phoneNumber": params[0] as Any]
        case "validateOtpRecipient":
            headers = [
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "dd7c56c3-65be-4633-ba63-42e7b5c551f6,7e4d26ce-df96-4725-8909-5589b5aa51e8",
                "Host": "cardun.ir",
                "cookie": "PHPSESSID=561c5a73445eb21d217c53108234a591",
                "accept-encoding": "gzip, deflate",
                "content-length": "128",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            parameters = [
                "method": "validateOtpRecipient",
                "phoneNumber": params[0],
                "otp": params[1],
                "notificationId": params[2]
                ] as [String : Any]
        case "getRecipientData":
            headers = [
                "Content-Type": "application/x-www-form-urlencoded",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "afff3194-fcb3-4a43-b62e-87d8e5bee040,5cf9e8a6-fa58-4cbb-9870-b412f0c17db3",
                "Host": "cardun.ir",
                "cookie": "PHPSESSID=561c5a73445eb21d217c53108234a591",
                "accept-encoding": "gzip, deflate",
                "content-length": "153",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            parameters = [
                "method": "getRecipientData",
                "token": params[0]
                ] as [String : Any]
        case "getServices":
            headers = [
                "Content-Type": "application/x-www-form-urlencoded",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "d084d70b-0a53-4e3f-90c0-25868b5c6b64,163700e6-00cf-4da8-aef3-f858d3889b44",
                "Host": "cardun.ir",
                "cookie": "PHPSESSID=561c5a73445eb21d217c53108234a591",
                "accept-encoding": "gzip, deflate",
                "content-length": "31",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            parameters = [
                "method": "getServices"
                ] as [String : Any]
        case "depositGift":
            headers = [
                "Content-Type": "application/x-www-form-urlencoded",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "58c44406-6ea0-4f00-b68c-42920d64f2de,fddafd58-3867-42ce-baca-0152e138d013",
                "Host": "cardun.ir",
                "cookie": "PHPSESSID=561c5a73445eb21d217c53108234a591",
                "accept-encoding": "gzip, deflate",
                "content-length": "184",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            parameters = [
                "method": "depositGift",
                "token": params[0],
                "giftCode": params[1]
                ] as [String : Any]
        case "newOrder":
            headers = [
                "Content-Type": "application/x-www-form-urlencoded",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "13552622-3503-4f66-9625-a8f5b2ee8203,e1689177-416b-4c27-828e-4ad63b5568b1",
                "Host": "cardun.ir",
                "cookie": "PHPSESSID=561c5a73445eb21d217c53108234a591",
                "accept-encoding": "gzip, deflate",
                "content-length": "284",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            parameters = [
                "method": "newOrder",
                "token": params[0],
                "description": params[1],
                "address": params[2],
                "lat": params[3],
                "lng": params[4],
                "serviceId": params[5],
                "notificationId": params[6],
                "image": params[7]
                ] as [String : Any]
        case "cancelOrderRecipient":
            headers = [
                "Content-Type": "application/x-www-form-urlencoded",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "ff3f6a22-04a5-44c9-bb20-c8c2bfb1592d,f8ae3310-f411-4baf-9fd8-08c841d10f53",
                "Host": "cardun.ir",
                "cookie": "PHPSESSID=561c5a73445eb21d217c53108234a591",
                "accept-encoding": "gzip, deflate",
                "content-length": "179",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            parameters = [
                "method": "cancelOrderRecipient",
                "token": params[0],
                "orderId": params[1]
                ] as [String : Any]
        case "getOrdersRecipient":
            headers = [
                "Content-Type": "application/x-www-form-urlencoded",
                "User-Agent": "PostmanRuntime/7.15.0",
                "Accept": "*/*",
                "Cache-Control": "no-cache",
                "Postman-Token": "e03b7343-fd65-465d-b13d-a9213bd38424,d1ce1328-8638-4949-b915-f9b6002e82a3",
                "Host": "cardun.ir",
                "cookie": "PHPSESSID=561c5a73445eb21d217c53108234a591",
                "accept-encoding": "gzip, deflate",
                "content-length": "155",
                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            parameters = [
                "method": "getOrdersRecipient",
                "token": params[0]
                ] as [String : Any]
            
        default:
            print(name)
        }
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: URL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
         return request
                
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
