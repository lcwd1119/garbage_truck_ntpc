//
//  TruckRouteInfView.swift
//  garbage_truck_ntpc
//
//  Created by 廖晨維 on 2021/12/27.
//

import SwiftUI
import RefreshableScrollView

struct TruckRouteInfView: View {
    @StateObject var truckRouteInfListViewModel =  TruckRouteInfListViewModel()
    @State var refresh = false
    @State var selectedRoute: TruckRouteInfResponse?
    private var column = Array(repeating: GridItem(), count: 1)
    var body: some View {
        RefreshableScrollView(refreshing: $refresh, action: {
            truckRouteInfListViewModel.fetchItems(term: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.refresh = false
            }
        }){
            LazyVGrid(columns: column, content: {
                ForEach(truckRouteInfListViewModel.truckRouteInfList) {
                    item in
                    Button{
                        selectedRoute = item
                    }label: {
                        TruckRouteInfRowView(truckRouteInf: item)
                            .foregroundColor(.white)
                    }
                }
                
            })
        }.overlay {
            if(truckRouteInfListViewModel.truckRouteInfList.isEmpty){
                ProgressView()
            }
        }
        .sheet(item: $selectedRoute) {item in
            TruckRouteInfDetailView(truckRouteInfDetail: item)
        }
    }
}

struct TruckRouteInfView_Previews: PreviewProvider {
    static var previews: some View {
        TruckRouteInfView()
    }
}
