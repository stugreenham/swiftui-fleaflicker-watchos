//
//  RosterView.swift
//  Fleaflicker Watch WatchKit Extension
//
//  Created by Stu Greenham on 24/05/2021.
//

import SwiftUI

struct RosterView: View {
    
    //: MARK: - PROPERTIES
    
    // VAR TO HOLD JSON RESULTS
    @State var groups = [Group]()
    
    // VARS TO HOLD DATA PASSED INTO THE VIEW
    let leagueId: Int
    let teamId: Int
    let teamName: String
    
    
    var body: some View {
        
        ScrollView {
            
            ForEach(groups, id: \.group) { group in
            
                VStack(alignment: .leading, spacing: 4) {

                    // ROSTER GROUP
                    Text(getGroupTitle(groupName: group.group ?? ""))
                        .font(.headline)
                        .padding(.bottom, 4)
                        .padding(.horizontal)

                    VStack {

                        // ROSTER PLAYER LIST
                        ForEach(group.slots, id: \.self) { slot in

                            if slot.leaguePlayer != nil {
                                HStack {
                                    // PLAYER NAME
                                    Text(slot.leaguePlayer!.proPlayer!.nameFull)

                                    Spacer()

                                    // PLAYER POSITION
                                    Text(slot.leaguePlayer!.proPlayer!.position)
                                        .font(.footnote)
                                        .foregroundColor(Color(.gray))
                                }
                                .padding(.bottom, 2)
                                .padding(.horizontal)
                            }

                        } //: LOOP

                    }

                } //: VSTACK
                .padding(.vertical, 8)

            } //: LIST
            .onAppear(perform: loadTeamData)
            
        } //: SCROLL
//        .navigationTitle("Leagues")
        
    }
    
    
    //: MARK: - FUNCTIONS
    func loadTeamData() {
        guard let url = URL(string: "https://www.fleaflicker.com/api/FetchRoster?sport=NFL&league_id=\(leagueId)&team_id=\(teamId)") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedReponse = try JSONDecoder().decode(RosterResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.groups = decodedReponse.groups
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

struct RosterView_Previews: PreviewProvider {
    static var previews: some View {
        RosterView(leagueId: 320927, teamId: 1626358, teamName: "Soldier Fields")
    }
}
