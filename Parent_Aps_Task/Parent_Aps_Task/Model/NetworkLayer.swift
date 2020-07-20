//
//  NetworkLayer.swift
//  MREC
//
//  Created by developer on 07/05/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation
import Alamofire
class NetworkLayer {
    
    
       var AnyModel :Any!
    typealias CompletionHandler = (Any,State) -> Void
    init() {
        
    }
    //swicher
   func Request<T:Decodable>( ResponseModel: T.Type,RequestConfiq: NetworkRouter,completionHandler: @escaping  CompletionHandler)
    {
        switch RequestConfiq.GetMethod() {
      
      case "Get":
             GetRequest(Model: ResponseModel, RequestConfiq: RequestConfiq, completionHandler: completionHandler)
              print("Get Request Proceed")
        default:
            print("No Method setted")
        }
    }
    public  func GetRequest<T:Decodable>( Model: T.Type,RequestConfiq: NetworkRouter,completionHandler: @escaping  CompletionHandler)
      {
        
  
        let request = AF.request(RequestConfiq.GetUrl())
       // var utf8Text = ""
        
       request.responseJSON
        {
            data  in
         
            print(RequestConfiq.GetUrl())
            print("mydata")
            print(data)
                print(Model)
          
            switch data.result {
            case .failure(let error):
             // self.NetworkErrorHandle(ErrorMessage :" Check your Internet Connection ")
               print(error)
                completionHandler(self.AnyModel,.error)
              return
                // Do your code here...

            case .success(_):
                print("Success")
                if data.data == nil
                          {
                              print("NoData")
                           completionHandler(self.AnyModel,.empty)
                            return
                          }
            }
        
            do{
                self.AnyModel =  try  JSONDecoder().decode(Model, from: data.data!)


           }


           catch{


               print("error im parsssssing")


           }
           
        //    MinValue = self.Intro.MinYesToPass!
        //print(self.Intro.MinYesToPass)
            completionHandler(self.AnyModel,.Success)
      }
     
     //   return MinValue
    }
    /*
    func PostRequest<T:Decodable>(Model: T.Type , RequestConfiq :NetworkRouter,completionHandler: @escaping  CompletionHandler)->Any  {
               print("PostRequest")
             var Result :Any
             Result = ""
          var request = URLRequest(url: URL(string: RequestConfiq.GetUrl())!)
                var postString = ""
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             request.setValue("PATCH", forHTTPHeaderField: "X-HTTP-Method-Override")
        guard let PostData = RequestConfiq.GetPostObj() else {
            print("Requiered postData in nil")
            return ""
        }
           postString = String(decoding: PostData, as: UTF8.self)
        print(postString)
        print("Posting..")
                  request.httpMethod = "POST"
                  request.httpBody = postString.data(using: .utf8)
                  let task = URLSession.shared.dataTask(with: request) { data, response, error in
                  guard let data = data, error == nil else {                                                 // check for fundamental networking error
                  print("error=\(error)")
                             completionHandler(Result,false)
                  return
                  }
                  
                  if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                  print("statusCode should be 200, but is \(httpStatus.statusCode)")
                  print("response = \(response)")
                  }
                     do{
                        Result =  try  JSONDecoder().decode(Model, from: data)
                      //  PostRequest
                          print(Result)
                        }
                    catch{
                  print("error im parsssssing")
                             }
                  let responseString = String(data: data, encoding: .utf8)
                  print("responseString = \(responseString)")
                       completionHandler(Result,true)
                  }
                  task.resume()
             return Result
         }
    */

}
