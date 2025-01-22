//
//  HomeView.swift
//  Sandboxer
//
//  Created by Davide Benini on 21/10/24.
//

import SwiftUI
import YRobotConfigurator

enum HomeRoute: Hashable {
    case form
    case list
    case images
    case controls
    case pickers
    case datePickers
    case alerts
}
struct HomeView: View {
    @State var showRunningTestsLabel: Bool = false
    @State var title = "🤖 YRobot Demo"
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(value: HomeRoute.form) {
                    Label("Form", systemImage: "text.bubble")
                }
                NavigationLink(value: HomeRoute.list) {
                    Label("List", systemImage: "list.star")
                }
                NavigationLink(value: HomeRoute.images) {
                    Label("Images", systemImage: "photo")
                }
                NavigationLink(value: HomeRoute.controls) {
                    Label("Controls", systemImage: "dial.high")
                }
                NavigationLink(value: HomeRoute.pickers) {
                    Label("Pickers", systemImage: "list.dash")
                }
                NavigationLink(value: HomeRoute.datePickers) {
                    Label("Date Pickers", systemImage: "calendar")
                }
                NavigationLink(value: HomeRoute.alerts) {
                    Label("Alerts", systemImage: "rectangle")
                }
            } .onAppear {
                showRunningTestsLabel =  isRunningYRobotTests()
                if isRunningWith(argument: "ciccio") {
                    print("--")
                }
                Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                    title = "🤖 YRobot DemoApp"
                }
            }
            .navigationTitle(title)
                .navigationDestination(for: HomeRoute.self) { route in
                    switch route {
                    case .form:
                        FormView()
                    case .list:
                        PlainListView()
                    case .images:
                        ImagesView()
                    case .controls:
                        ControlsView()
                    case .datePickers:
                        DatePickersView()
                    case .pickers:
                        PickersView()
                    case .alerts:
                        AlertsView()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Menu {
                            Button(action: {
                                toast("Item 1")
                            }) {
                                Label("Item 1", systemImage: "1.circle")
                            }
                            
                            Button(action: {
                                toast("Item 2")
                            }) {
                                Label("Item 2", systemImage: "2.circle")
                            }
                            
                            Button(action: {
                                toast("Item 3")
                            }) {
                                Label("Item 3", systemImage: "3.circle")
                            }
                            
                            Menu {
                                Button(action: {
                                    toast("Item 4")
                                }) {
                                    Label("Item 4", systemImage: "4.circle")
                                }
                                Button(action: {
                                    toast("Item 5")
                                }) {
                                    Label("Item 5", systemImage: "5.circle")
                                }
                            } label: {
                                Label("Sub Items", systemImage: "folder")
                            }
                        }
                        label: {
                            Label("Menu", systemImage: "list.dash")
                        }
                    }
                }
                .overlay {
                    VStack {
                        Spacer()
                        Text("YRobot Tests Running")
                            .font(.caption)
                            .monospaced()
                            .foregroundStyle(Color.gray)
                    }.opacity(showRunningTestsLabel ? 1.0 : 0.0)
                }
        }
    }
    func toast(_ text: String) {
        Toaster.toast("📋 \(text)", duration: 1.0)
    }
}

#Preview {
    HomeView()
}
