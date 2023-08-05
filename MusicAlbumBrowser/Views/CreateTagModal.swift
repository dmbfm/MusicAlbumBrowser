//
//  CreateTagModal.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 04/08/23.
//

import SwiftUI

struct CreateTagModal: View {
    
    @State private var tagName = ""
    
    @Binding var showModal: Bool
    
    let confirmAction: (String) -> ()
    
    var body: some View {
        VStack {
            Text("Create New Tag")
                .font(.headline)
            TextField("Tag Name", text: self.$tagName)
                .onSubmit {
                    self.submit()
                }
                .frame(width: 200)
            
                HStack {
                    Spacer()
                    Button("Cancel") {
                        showModal = false
                    }
                    Button("OK") {
                        
                        
                        tagName = tagName.trimWhitespaces()
                        
                        if tagName != "" {
                            self.showModal = false
                            confirmAction(tagName)
                        }
                        
                       
                    }
                }
        }
        .padding()
    }
    
    func submit() {
        tagName = tagName.trimWhitespaces()
        
        if tagName != "" {
            self.showModal = false
            confirmAction(tagName)
        }
    }
}

struct CreateTagModal_Previews: PreviewProvider {
    static var previews: some View {
        CreateTagModal(showModal: .constant(true), confirmAction: { _ in })
            .previewLayout(.sizeThatFits)
    }
}
