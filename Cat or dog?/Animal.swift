//
//  Animal.swift
//  Cat or dog?
//
//  Created by Adityaa Mehra on 12/07/21.
//

import Foundation
import CoreML
import Vision

struct Result:Identifiable {
    var imageLabel:String
    var confidence:Double
    var id = UUID()
}
class Animal{
    
    // URL for the image
    var imageUrl:String
    
    // The image data
    var imageData:Data?
    // Classified results
    var results:[Result]
    
    let modelFile = try! MobileNetV2(configuration: MLModelConfiguration())
    init(){
        self.imageUrl = ""
        self.imageData = nil
        self.results = []
    }
    init?(json: [String:Any]){
        
        // Check that the JSON has an URL
        guard let imageUrl = json["url"] as? String else {
            return nil
        }
        // Set the animal properties
        self.imageUrl = imageUrl
        self.imageData = nil
        self.results = []
        // Download the Image data
        getImage()
        
    }
    func getImage(){
        // Create URL object
        let url = URL(string: imageUrl)
        
        // Check that the URL isn;t nil
        guard url != nil else {
            print("no url")
            return
        }
        // Get URL session
        let session = URLSession.shared
        // Create the data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil{
                self.imageData = data
                self.classifyAnimal()
            }
        }
        // Start the data task
        dataTask.resume()
    }
    func classifyAnimal(){
        
        // Get a reference to the model
        let model = try! VNCoreMLModel(for: modelFile.model)
        // Create an image handler
        let handler = VNImageRequestHandler(data: imageData!)
        // Create a request to the model
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else{
                return
            }
            // Update the results
            for classification in results{
                var identifier = classification.identifier
                identifier = identifier.prefix(1).capitalized + identifier.dropFirst()
                self.results.append(Result(imageLabel: identifier, confidence: Double(classification.confidence)))
            }
        }
        // Execute the request
        do {
            try handler.perform([request])
        }catch{
            print("invalid image")
        }
    }
}
