//
//  Library.swift
//  MusicApp
//
//  Created by Ирина on 14.03.2022.
//

import SwiftUI
import URLImage


struct Library: View {
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerProtocol?
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button { self.track = self.tracks[0]
                            self.tabBarDelegate?.maximizeTrackDetailController(
                                viewModel: self.track
                            ) }
                    label: { Image(systemName: "play.fill")
                            .frame(
                                width: abs(geometry.size.width / 2 - 10),
                                height: abs(50)
                            )
                            .foregroundColor(Color(
                                red: 1.0, green: 0.0,
                                blue: 0.0
                            ))
                            .background(Color(
                                hue: 0.0, saturation: 0.016,
                                brightness: 0.958, opacity: 0.915
                            ))
                            .cornerRadius(10)
                    }
                        
                        Button { self.tracks = UserDefaults.standard.savedTracks() }
                    label: { Image(systemName: "arrow.2.circlepath")
                            .frame(
                                width: abs(geometry.size.width / 2 - 10),
                                height: abs(50)
                            )
                            .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0))
                            .background(Color(
                                hue: 0.0, saturation: 0.016,
                                brightness: 0.958, opacity: 0.915
                            ))
                            .cornerRadius(10)
                    }
                 }
            }.padding().frame(height: 58)
                    .navigationBarTitle("Library")
                Divider().padding(.leading).padding(.trailing)
                List {
                    ForEach(tracks) { track in
                        LibraryCell(cell: track)
                            .gesture(LongPressGesture()
                                        .onEnded { _ in
                                print("Pressed")
                                self.track = track
                                self.showAlert = true
                            }.simultaneously(
                                with: TapGesture().onEnded { _ in
                                    let keyWindow = UIApplication.shared.connectedScenes
                                        .filter({$0.activationState == .foregroundActive})
                                        .map({$0 as? UIWindowScene})
                                        .compactMap({$0})
                                        .first?.windows
                                        .filter({$0.isKeyWindow}).first
                                    let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                                    tabBarVC?.trackDetailView.delegate = self
                                    
                                    self.track = track
                                    self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                                }))
                        
                    }.onDelete(perform: delete)
                }.listStyle(.plain)
            }
            .actionSheet(isPresented: $showAlert, content: {
                ActionSheet(
                    title: Text("Are you sure you want delete this track?"),
                    buttons: [.destructive(Text("Delete"), action: {
                        self.delete(track: self.track)
                    }), .cancel()
                             ])
            })
        }
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedTracks = try? NSKeyedArchiver.archivedData(
            withRootObject: tracks, requiringSecureCoding: false
        ) {
            let defaults = UserDefaults.standard
            defaults.set(savedTracks, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        
        if let savedTracks = try? NSKeyedArchiver.archivedData(
            withRootObject: tracks, requiringSecureCoding: false
        ) {
            let defaults = UserDefaults.standard
            defaults.set(savedTracks, forKey: UserDefaults.favouriteTrackKey)
        }
    }
}

struct LibraryCell: View {
    var cell: SearchViewModel.Cell
    var body: some View {
        HStack {
            URLImage(URL(string: cell.iconUrlString ?? "")!)
                .frame(width: 60, height: 60)
                .cornerRadius(2)
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}

extension Library: TrackMovingDelegate {
    func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        
        if myIndex - 1 == -1 {
            nextTrack = tracks[tracks.count - 1]
        } else {
            nextTrack = tracks[myIndex - 1]
        }
        self.track = nextTrack
        return nextTrack
    }
    
    func moveForwardForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
        }
        self.track = nextTrack
        return nextTrack
    }
    
    
}
