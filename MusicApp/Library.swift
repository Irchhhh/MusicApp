//
//  Library.swift
//  MusicApp
//
//  Created by Ирина on 14.03.2022.
//

import SwiftUI

struct Library: View {
    var tracks = UserDefaults.standard.savedTracks()
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button { print("123") }
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
                        
                        Button { print("1323") }
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
                List(tracks) { track in
                    LibraryCell(cell: track)
                        
                }.listStyle(.plain)
            }
        }
    }
}

struct LibraryCell: View {
    var cell: SearchViewModel.Cell
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(cell.trackName)")
            Text("\(cell.artistName)")
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
