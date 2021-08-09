//
//  ViewController.swift
//  picturescores
//
//  Created by Alysha Kester-Terry on 8/8/21.
//

import UIKit

class ViewController: UITableViewController {

    //To create a property, you need to declare it outside of methods
    var pictureList = [String]() //That pictures array will be created when the ViewController screen is created, and exist for as long as the screen exists.
    var prefix = "AMT-"
    var suffix = ".png"
    let fontSize = UIFont.systemFont(ofSize: 24.0)
    
       override func viewDidLoad() {
           super.viewDidLoad()
           navigationController?.navigationBar.prefersLargeTitles = true
           title = "picturescores"
           let fm = FileManager.default //declares a constant called fm and assigns it the value returned by FileManager.default. This is a data type that lets us work with the filesystem
           let path = Bundle.main.resourcePath! //declares a constant called path that is set to the resource path of our app's bundle. Remember, a bundle is a directory containing our compiled program and all our assets. So, this line says, "tell me where I can find all those images I added to my app."
           let items = try! fm.contentsOfDirectory(atPath: path) //declares a third constant called items that is set to the contents of the directory at a path. Which path? Well, the one that was returned by the line before.
           for item in items{ //starts a loop that will execute once for every item we found in the app bundle.
               if item.hasPrefix(prefix){
                   //What we really want is to add to the pictures array all the files we match inside our loop.
                   pictureList.append(item)
               }
           }
        pictureList.sort()
       }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countOfRows = pictureList.count
        //method that sets how many rows should appear in the table
        //tableView is the name that we can use to reference the table view inside the method, and UITableView is the data type
        return countOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //indexPath This is a data type that contains both a section number and a row number.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) //That creates a new constant called cell by dequeuing a recycled cell from the table
        let cellLabel = pictureList[indexPath.row]
        return assignCellAccessibility(cell: cell, label: cellLabel)
    }
    
    
    func assignCellAccessibility(cell: UITableViewCell, label: String)->UITableViewCell{
        //Function to assign text lable and accessibility to each cell
        let pictureName = label.description.replacingOccurrences(of: prefix, with: "").replacingOccurrences(of: suffix, with: "")
        cell.textLabel?.text = pictureName
        cell.accessibilityIdentifier = "Picture"
        cell.accessibilityLabel = pictureName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vController.selectedImage = pictureList[indexPath.row]
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vController, animated: true)
        }
        else{
            print("Oh no! There was an error.")
        }
    }

}

