////
////  JsonModel.swift
////  CoreFeature
////
////  Created by Razib Mollick on 3/17/18.
////  Copyright © 2018 Ashley Furniture. All rights reserved.
////
//
//import Foundation
//
//struct Base_Model : Codable {
//    let model : Model?
//    
//    enum CodingKeys: String, CodingKey {
//        case model
//    }
//    
//    enum ModelCodingKeys: String, CodingKey {
//        
//        case submodel1
//    }
//    
//    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        let vals = try values.nestedContainer(keyedBy: ModelCodingKeys.self, forKey: .model)
//        print("Go down 1")
//        model = try Model(from: decoder)
//       
//    }
//    
//}
//
////struct Model : Codable {
////    let submodel1 : Submodel1?
////
////    enum CodingKeys: String, CodingKey {
////
////        case submodel1
////
////    }
////
////    enum RootCodingKeys: String, CodingKey {
////        case model
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder. .container(keyedBy: CodingKeys.self)
////        print(values.codingPath)
////        submodel1 = try Submodel1(from: decoder)
////        // submodel1 = try values.decodeIfPresent(Submodel1.self, forKey: .submodel1)
////    }
////
////}
//
//struct Submodel1 : Codable {
//    let property1 : Int?
//    let property2 : Int?
//    let subsubmodel : Subsubmodel?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case property1 = "property1"
//        case property2 = "property2"
//        case subsubmodel = "sub-submodel"
//    }
//    
//    
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: Base_Model.CodingKeys.self)
//        let vals = try values.nestedContainer(keyedBy: Model.CodingKeys.self, forKey: .model)
//        let valuseSelf = try vals.nestedContainer(keyedBy: CodingKeys.self, forKey: .submodel1)
//        
//        property1 = try valuseSelf.decodeIfPresent(Int.self, forKey: .property1)
//        property2 = try valuseSelf.decodeIfPresent(Int.self, forKey: .property2)
//        print("property1:",property1)
//        subsubmodel = try Subsubmodel(from: decoder)
//        //   subsubmodel = try values.decodeIfPresent(Subsubmodel.self, forKey: .subsubmodel)
//    }
//    
//}
//
//struct Subsubmodel : Codable {
//    let awesomeProperty : Int?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case awesomeProperty = "awesomeProperty"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        awesomeProperty = try values.decodeIfPresent(Int.self, forKey: .awesomeProperty)
//        print(awesomeProperty)
//    }
//    
//}

