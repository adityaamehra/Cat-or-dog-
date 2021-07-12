//
//  AnimalModel.swift
//  Cat or dog?
//
//  Created by Adityaa Mehra on 12/07/21.
//

import Foundation

class AnimalModel:ObservableObject{
    @Published var animal = Animal()
    func getAnimal(){
        
        let stringUrl = Bool.random() ? catUrl : dogUrl
        
        // Create a URL object
        let url = URL(string: stringUrl)
        
        // Check that the URL isn't nil
        guard url != nil else {
            print("No url")
            return
        }
        // Get the URL session
        let session  = URLSession.shared
        
        // Create a data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil{
                
                // Attemp to parse the JSON
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]{
                        let item = json.isEmpty ? [:] : json[0]
                        
                        if let animal = Animal(json: item){
                            DispatchQueue.main.async {
                                while animal.results.isEmpty{}
                                self.animal = animal
                            }
                        }
                        
                        
                    }
                    
                }catch{
                    print("cannot parse")
                }
                
            }
        }
        // Start the data task
        dataTask.resume()
    }
}
