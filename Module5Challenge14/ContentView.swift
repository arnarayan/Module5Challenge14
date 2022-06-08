//
//  ContentView.swift
//  Module5Challenge14
//
//  Created by Anand Narayan on 2022-06-08.
//

import SwiftUI

struct ContentView: View {
    
    @State var sageAdvice: String = ""
    var session: URLSession = URLSession.shared
    var body: some View {
        
        VStack(spacing:20) {
            Text(sageAdvice)
            Button(action: {
                self.getRemoteData()
            }, label: {
                Text("Get a new Fact!")
            })
        }.padding()
        
        
        
    }
    
    func getRemoteData()  {
        let remoteDataUrl = "http://numbersapi.com/random/trivia"
        let sendingUrl = URL(string: remoteDataUrl)
        var request = URLRequest(url: sendingUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.allHTTPHeaderFields = setHeaders()
        request.httpMethod = "GET"

        let dataTask = self.session.dataTask(with: request) { (data, response, error) in
            self.responseHandler(data: data, response: response, error: error)
        }
        dataTask.resume()


    }
    
    
    func responseHandler(data:Data?, response: URLResponse?, error: Error?)  {
         if (error == nil && data != nil) {
             let res = String(data: data!, encoding: .utf8) ?? "blah"
             DispatchQueue.main.async {
                 self.sageAdvice = res

                 
             }
    
         }
        
     }
    
    func setHeaders() -> [String:String] {
        return [:]
    }
}

