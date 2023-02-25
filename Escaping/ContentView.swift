//
//  ContentView.swift
//  Escaping
//
//  Created by Prathamesh Araikar on 20/06/22.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct ShoeModel: Codable, Identifiable {
    let imageurl: String
    let price: String
    let title: String
    var id = UUID().uuidString
}

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    @Published var allShoes: [ShoeModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        guard let url = URL(string: "https://zaptos-server.herokuapp.com/adidas") else { return }
        
        downloadData(fromURL: url) { (returnedData) in
            if let data = returnedData {
                guard let newShoes = try? JSONDecoder().decode([ShoeModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.allShoes = newShoes
                }
            } else {
                print("No data returned.")
            }
        }
    }
    
    func downloadData(fromURL url: URL, completionHandler: @escaping DownloadableData) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data.")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
            
        }.resume()
    }
    
}

typealias DownloadableData = (_ data: Data?) -> ()

struct ContentView: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.allShoes) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.price)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
