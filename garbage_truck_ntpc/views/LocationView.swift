//
//  LocationView.swift
//  garbage_truck_ntpc
//
//  Created by 廖晨維 on 2021/12/28.
//

import SwiftUI

struct LocationView: View {
    @StateObject var locationViewModel =  LocationViewModel()
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(locationViewModel.city)
            Text(locationViewModel.suburb)
        }.refreshable {
            locationViewModel.fetchItems()
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
