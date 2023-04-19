//
//  MockPBTransactions.swift
//  WorldOfPAYBACKTests
//
//  Created by Ramkrishna Baddi on 15/04/2023.
//

import Foundation
import Combine
@testable import WorldOfPAYBACK

extension PBTransactions {
    
    static var mock: PBTransactions {
        Bundle.main.decode(self, from: "PBTransactions.json")
    }
}
