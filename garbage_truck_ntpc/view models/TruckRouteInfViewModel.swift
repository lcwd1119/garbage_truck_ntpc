//
//  TruckRouteInfListViewModel.swift
//  garbage_truck_ntpc
//
//  Created by 廖晨維 on 2021/12/25.
//

import Foundation
import SwiftUI

class TruckRouteInfListViewModel: ObservableObject {
    @Published var truckRouteInfList = [TruckRouteInfResponse]()
    
    init() {
    fetchItems(term: 0)
    }
    
    func fetchItems(term: Int) {
        let urlStr = "https://data.ntpc.gov.tw/api/datasets/EDC3AD26-8AE7-4916-A00B-BC6048D19BF8/json?page=\(term)&size=100"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, response , error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        //decoder.dateDecodingStrategy = .iso8601
                        let searchResponse = try decoder.decode([TruckRouteInfResponse].self, from:data)
                        DispatchQueue.main.async {
                            self.truckRouteInfList = searchResponse
                            print(searchResponse)
                        }
                    } catch {
                        print("TruckRouteInf error",error)
                    }
                }
            }.resume()
        }
    }
}
