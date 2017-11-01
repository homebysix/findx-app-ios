//
//  FindxCookiesHandler.swift
//  Findx
//
//  Created by Мар'ян Шкурда on 8/23/17.
//  Copyright © 2017 Mozilla. All rights reserved.
//

import Foundation

class FindxCookiesHandler{
    
    private let KEY = "FINDX_COOKIES"
    
    private init(){}
    
    public static var shared = FindxCookiesHandler()
    
    func loadCookies(){
        print("> try to load cookies")
        if let cookieDictionary = UserDefaults.standard.dictionary(forKey: KEY){
            print("<FOUND DICT with \(cookieDictionary.count) elements>")
            for (name, cookieProperties) in cookieDictionary {
                print("\(name) - \(cookieProperties)")
                if let cookie = HTTPCookie(properties: cookieProperties as! [HTTPCookiePropertyKey : Any] ) {
                    HTTPCookieStorage.shared.setCookie(cookie)
                    print("> LOADED cookie: \(cookie.name)")
                }
            }
        }
    }
    
    func saveCookies(_ cookies:[HTTPCookie]){
        
        var cookieDict = [String:Any]()
        if let cookieDictionary = UserDefaults.standard.dictionary(forKey: KEY){
            cookieDict = cookieDictionary
        }
        for cookie in cookies{
            if cookie.isSessionOnly != true{
                cookieDict[cookie.name] = cookie.properties as Any?
            }
        }
        UserDefaults.standard.setValue(cookieDict, forKey: KEY)
        cookieDict.forEach { (cookie) in
            print("> saved cookie: \(cookie.key) : \(cookie.value)")
        }
        DispatchQueue.global().async {
            UserDefaults.standard.synchronize()
        }
    }
    
    func removeAllCookies(){
        UserDefaults.standard.setValue([:], forKey: KEY)
        DispatchQueue.global().async {
            UserDefaults.standard.synchronize()
        }
    }
    
}
