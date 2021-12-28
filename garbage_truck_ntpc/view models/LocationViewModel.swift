//
//  LocationViewModel.swift
//  garbage_truck_ntpc
//
//  Created by 廖晨維 on 2021/12/27.
//

import Foundation
class LocationViewModel: ObservableObject {
    @Published var city:String = ""
    @Published var suburb:String = ""
    
    init() {
        fetchItems()
    }
    
    func fetchItems() {
        let urlStr = "https://nominatim.openstreetmap.org/reverse?lat=25.0061&lon=121.460777&format=json"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, response , error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        //decoder.dateDecodingStrategy = .iso8601
                        let searchResponse = try decoder.decode(LocationResponse.self, from:data)
                        DispatchQueue.main.async {
                            self.city = searchResponse.address.city
                            self.suburb = searchResponse.address.suburb
                            print(searchResponse)
                        }
                    } catch {
                        print("Location error",error)
                    }
                }
            }.resume()
        }
    }
}
