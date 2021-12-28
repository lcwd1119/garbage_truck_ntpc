//
//  ContentView.swift
//  garbage_truck_ntpc
//
//  Created by 廖晨維 on 2021/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var networkMonitor = NetworkMonitor()
    @State var showalert = false
    var body: some View {
        if(networkMonitor.network_status){
            TabView{
                NavigationView{
                    VStack(spacing:70){
                        NavigationLink {
                            TruckRouteInfView()
                        } label: {
                            Text("查看路線")
                                .font(.largeTitle)
                        }
                        NavigationLink {
                            TruckLocationView()
                        } label: {
                            Text("查詢出勤\n車輛")
                                .font(.largeTitle)
                            
                        }
                    }.buttonStyle(.borderedProminent)
                }.tabItem({
                    Label("首頁",systemImage: "house.fill")})
                LocationView()
                    .tabItem{Label("位置",systemImage: "location.fill")}
            }
        }
        else{
            NetworkView(networkMonitor: networkMonitor)
                .onAppear {
                    showalert = true
                }.alert("斷網了GG", isPresented: $showalert) {
                    Button("confirm"){}
                }
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
