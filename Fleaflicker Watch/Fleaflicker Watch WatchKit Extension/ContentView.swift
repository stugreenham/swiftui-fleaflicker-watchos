//
//  ContentView.swift
//  Fleaflicker Watch WatchKit Extension
//
//  Created by Stu Greenham on 24/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    //: MARK: - PROPERTIES
    // VAR TO STORE LEAGUE JSON DATA
    @State var leagues = [League]()
    
    
    //: MARK: - BODY
    var body: some View {
        
        NavigationView {
            
            List(leagues, id: \.id) { item in
                
                NavigationLink(destination: RosterView(
                    leagueId: item.id,
                    teamId: item.ownedTeam.id,
                    teamName: item.ownedTeam.name
                )) {
                    Text(item.name)
                        .font(.headline)
                }
                
            } //: LIST
            .onAppear(perform: loadLeagueData)
            
        } //: NAV
        .navigationBarTitle("Leagues")
        
    }
    
    
    //: MARK: - FUNCTIONS
    private func loadLeagueData() {
        guard let url = URL(string: "https://www.fleaflicker.com/api/FetchUserLeagues?sport=NFL&user_id=1034407") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedReponse = try JSONDecoder().decode(LeagueResponse.self, from: data)
                    DispatchQueue.main.async {
                            self.leagues = decodedReponse.leagues
                    }
                    
                    return
                } catch {
                    print(error)
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    } //: FUNC
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
