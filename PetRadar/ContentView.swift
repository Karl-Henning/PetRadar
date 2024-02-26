//
//  ContentView.swift
//  PetRadar
//
//  Created by Karl Henning on 25.02.24.
//

import SwiftUI
import SwiftData

// Define structs to represent your JSON data

struct AnimalData: Codable {
    let animalAltered: String
    let animalBirthdate: String
    let animalBreed: String
    let animalColor: String
    let animalID: String
    let animalName: String
    let animalPictureUrl: String
    let animalRescueID: String
    let animalSex: String
    let animalSpecies: String
    let animalStatus: String
}

struct AnimalDatum: Codable {
    let _data: AnimalData
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    // JSON data
    let jsonData = """
    [{"_data":{"animalAltered":"No","animalBirthdate":"6/1/2018","animalBreed":"Domestic Short Hair / Mixed (short coat)","animalColor":"Black and White","animalID":"13401044","animalName":"Banjo","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13401/13401044/59463354.jpg","animalRescueID":"","animalSex":"Male","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"3/17/2017","animalBreed":"Maine Coon / Tabby / Mixed (medium coat)","animalColor":"Brown Tabby","animalID":"13419888","animalName":"Cary","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13419/13419888/64435203.jpg","animalRescueID":"A1073046","animalSex":"Male","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"3/17/2017","animalBreed":"Maine Coon / Tabby / Mixed (medium coat)","animalColor":"Brown Tabby","animalID":"13420043","animalName":"Grant","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13420/13420043/64435290.jpg","animalRescueID":"A1073045","animalSex":"Male","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"1/23/2010","animalBreed":"Domestic Short Hair / Calico / Mixed (short coat)","animalColor":"Calico or Dilute Calico","animalID":"13437587","animalName":"Isobel","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13437/13437587/64268822.jpg","animalRescueID":"A1069917","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"10/15/2017","animalBreed":"Domestic Short Hair / Mixed (medium coat)","animalColor":"Gray, Blue or Silver Tabby","animalID":"13455556","animalName":"Willow","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13455/13455556/59849423.jpg","animalRescueID":"","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"7/8/2012","animalBreed":"Siamese (short coat)","animalColor":"Cream (Mostly)","animalID":"13456082","animalName":"Layla","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13456/13456082/59885137.jpg","animalRescueID":"A (DC)","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Passed Away"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"7/17/2017","animalBreed":"Domestic Short Hair / Mixed (short coat)","animalColor":"Black and White","animalID":"13456111","animalName":"Twinkle","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13456/13456111/59850654.jpg","animalRescueID":"A (DC)","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"4/6/2012","animalBreed":"Dilute Calico / Domestic Short Hair / Mixed (short coat)","animalColor":"Calico or Dilute Calico","animalID":"13459714","animalName":"Saffron","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13459/13459714/59967985.jpg","animalRescueID":"A0080799 (DC)","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"3/10/2013","animalBreed":"Domestic Short Hair / Calico / Mixed (short coat)","animalColor":"Calico or Dilute Calico","animalID":"13459729","animalName":"Amber","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13459/13459729/61191393.jpg","animalRescueID":"A059702 (DC)","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"7/18/2013","animalBreed":"Domestic Short Hair / Tabby / Mixed (short coat)","animalColor":"Gray, Blue or Silver Tabby","animalID":"13459909","animalName":"Mila","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13459/13459909/59884554.jpg","animalRescueID":"A0921619 (DC)","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"7/18/2013","animalBreed":"Domestic Short Hair / Tabby / Mixed (short coat)","animalColor":"Gray, Blue or Silver Tabby","animalID":"13461007","animalName":"Zinga","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13461/13461007/59884551.jpg","animalRescueID":"A0921620 (DC)","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"5/21/2017","animalBreed":"Domestic Short Hair / Mixed (short coat)","animalColor":"Black","animalID":"13461731","animalName":"Venus","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13461/13461731/60070667.jpg","animalRescueID":"A1071616 (DC)","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"7/17/2015","animalBreed":"Domestic Short Hair / Tabby / Mixed (short coat)","animalColor":"Brown Tabby","animalID":"13465886","animalName":"Panther","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13465/13465886/59989817.jpg","animalRescueID":"A1088506 (DC)","animalSex":"Male","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"7/1/2017","animalBreed":"Domestic Short Hair / Tabby / Mixed (short coat)","animalColor":"Gray and White","animalID":"13465891","animalName":"Jody","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13465/13465891/59989686.jpg","animalRescueID":"1060599 (DC)","animalSex":"Male","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"4/19/2011","animalBreed":"Domestic Short Hair / Mixed (short coat)","animalColor":"Gray and White","animalID":"13465901","animalName":"Errol","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13465/13465901/59989944.jpg","animalRescueID":"A1076876 (DC)","animalSex":"Male","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"4/30/2016","animalBreed":"Tabby / Mixed (short coat)","animalColor":"White (Mostly)","animalID":"13465927","animalName":"Banksy","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13465/13465927/59990153.jpg","animalRescueID":"A1078704 (DC)","animalSex":"Male","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"1/9/2009","animalBreed":"Domestic Medium Hair / Mixed (medium coat)","animalColor":"Black and White","animalID":"13466091","animalName":"Athena","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13466/13466091/60648472.jpg","animalRescueID":"A10121490 (DC)","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"5/31/2013","animalBreed":"Tortoiseshell / Mixed (short coat)","animalColor":"Tortoiseshell","animalID":"13466138","animalName":"Rochelle","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13466/13466138/59990463.jpg","animalRescueID":"Community A0834820 (DC)","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"1/13/2012","animalBreed":"Domestic Short Hair / Tabby / Mixed (short coat)","animalColor":"Brown Tabby","animalID":"13466174","animalName":"Gypsy","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13466/13466174/59990490.jpg","animalRescueID":"A1068614 (DC)","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}},{"_data":{"animalAltered":"Yes","animalBirthdate":"8/27/2017","animalBreed":"Domestic Medium Hair / Dilute Tortoiseshell / Mixed (medium coat)","animalColor":"Tortoiseshell","animalID":"13470918","animalName":"Penny","animalPictureUrl":"https://cdn.rescuegroups.org/8960/pictures/animals/13470/13470918/60179139.jpg","animalRescueID":"A1094015","animalSex":"Female","animalSpecies":"Cat","animalStatus":"Adopted"}}]
    """.data(using: .utf8)!

    var animals: [AnimalDatum] = []

    init() {
        do {
            self.animals = try JSONDecoder().decode([AnimalDatum].self, from: jsonData)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(animals.indices, id: \.self) { index in
                AnimalCardView(animal: animals[index])
            }
        }
    }
    
    // Function to load JSON data
    func loadJson<T: Decodable>(filename fileName: String) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

struct AnimalCardView: View {
    let animal: AnimalDatum
    
    var body: some View {
        if let imageUrl = URL(string: animal._data.animalPictureUrl) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 400)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            } placeholder: {
                PlaceholderImageView()
            }
        } else {
            PlaceholderImageView()
        }
    }
}

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 400)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}
