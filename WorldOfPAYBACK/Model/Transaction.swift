//
//  Transaction.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 15/04/2023.
//

import Foundation

struct PBTransactions: Codable {
    let transactions: [Transaction]
    
    private enum CodingKeys: String, CodingKey {
        case transactions = "items"
    }
}

struct Transaction: Codable, Identifiable, Hashable  {
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    
    var id: String
    let partnerDisplayName: String
    let alias: Alias
    let category: Int
    let transactionDetail: TransactionDetail
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decode all the properties
           partnerDisplayName = try container.decode(String.self, forKey: .partnerDisplayName)
           alias = try container.decode(Alias.self, forKey: .alias)
           category = try container.decode(Int.self, forKey: .category)
           transactionDetail = try container.decode(TransactionDetail.self, forKey: .transactionDetail)
           
           // Check if "id" is present in the JSON, otherwise assign a default value
           if let idValue = try container.decodeIfPresent(String.self, forKey: .id) {
               id = idValue
           } else {
               id = UUID().uuidString
           }
    }
    
    struct Alias: Codable {
        let reference: String
    }
    
    struct TransactionDetail: Codable {
        let description: String?
        let bookingDate: Date
        let value: Value
        
        struct Value: Codable {
            let amount: Int
            let currency: String
        }
        
        private enum CodingKeys: String, CodingKey {
            case description, bookingDate, value
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            description = try? container.decode(String.self, forKey: .description)
            
            let dateString = try container.decode(String.self, forKey: .bookingDate)
            let dateFormatter = ISO8601DateFormatter()
            bookingDate = dateFormatter.date(from: dateString)!
            
            value = try container.decode(Value.self, forKey: .value)
        }
    }
    
    
    
}
