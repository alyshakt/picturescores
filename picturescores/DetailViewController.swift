//
//  DetailViewController.swift
//  picturescores
//
//  Created by Alysha Kester-Terry on 12/26/20.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var artworkDesc: UITextView!
    @IBOutlet var locationLink: UITextView!
    @IBOutlet var contactLink: UITextView!
    
    //    @IBOutlet var artworkDesc: UITextView!
//    @IBOutlet var imageView: UIImageView!
//    @IBOutlet var locationLink: UITextView!
//    @IBOutlet var contactLink: UITextView!
    
    
    var artworkTitle: String?
    var selectedImage: String?
    var prefix = "AMT-"
    var suffix = ".png"
    
    /*Load the detail view controller layout from our storyboard.
     Set its selectedImage property to be the correct item from the pictures array.
     Show the new view controller.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artworkDesc.textContainerInset = UIEdgeInsets(top:0,left:20,bottom:0,right:10)
        locationLink.textContainerInset = UIEdgeInsets(top:0,left:20,bottom:0,right:10)
        contactLink.textContainerInset = UIEdgeInsets(top:0,left:20,bottom:0,right:10)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationController?.navigationBar.prefersLargeTitles = false
        let pictureName = selectedImage?.description.replacingOccurrences(of: prefix, with: "").replacingOccurrences(of: suffix, with: "")
        title = pictureName
        artworkTitle = pictureName
            //getTitle(pictureName: pictureName!)
        // We can check that selectedImage has a value, and if so pull it out for usage; otherwise, do nothing.
        if let imageToLoad = selectedImage {
            //If for some reason selectedImage is nil (which it should never be, in theory) then the imageView.image line will never be executed. If it has a value, it will be placed into imageToLoad, then passed to UIImage and loaded.
            imageView.image = UIImage(named: imageToLoad)
        }
        artworkDesc =  getDescription(artworkTitle: artworkTitle!)
        locationLink =  getLocationCoords(artworkName: artworkTitle!)
        contactLink = getContactInfo(artworkTitle: artworkTitle!)
        imageView.accessibilityIdentifier = "Arwork image"
        artworkDesc.accessibilityIdentifier = "Artwork description"
        locationLink.accessibilityIdentifier = "GPS location link"
        contactLink.accessibilityIdentifier = "Contact link"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        guard let location = locationLink.text else {
            print("No location found")
            return
        }

        let vc = UIActivityViewController(activityItems: [image, location], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
//    private func getMusic(pictureName: String) -> String{
//        var artworkName = "No Music Found"
//
//        if pictureName.lowercased().contains("1"){
//            artworkName = "Dornn Harris"
//        }
//        if pictureName.lowercased().contains("2"){
//            artworkName = "Brianna Davis"
//        }
//        if pictureName.lowercased().contains("3"){
//            artworkName = "Oksana Gritsaeva"
//        }
//        if( pictureName.lowercased().contains("4")){
//            artworkName = "Samantha (Moyer) Lange"
//        }
//        if( pictureName.lowercased().contains("5")){
//            artworkName = "Jessica Bryan"
//        }
//        if( pictureName.lowercased().contains("6")){
//            artworkName = "Lana Abuhudra"
//        }
//        if( pictureName.lowercased().contains("7")){
//            artworkName = "Becca Barratt"
//        }
//        return artworkName
//    }

    private func getDescription(artworkTitle: String) -> UITextView{
        let lowerTitle = artworkTitle.lowercased()
        var intro = "No Decription Found"
        if lowerTitle.contains("1"){
            intro = "\(artworkTitle) is a Software Developer at Medici Ventures"
        }
        if lowerTitle.contains("2"){
            intro = "\(artworkTitle) is an Integration Project Manager at SAP"
        }
        if lowerTitle.contains("3"){
            intro = "\(artworkTitle) is a Senior Manager in Strategic Business Development at Adobe"
        }
        if lowerTitle.contains("4"){
            intro = "\(artworkTitle) is an Access Specialist at University of Utah Health"
        }
        else if( lowerTitle.contains("5")){
            intro = "\(artworkTitle) is a Senior Project Manager for CIRRUS/V2X at Panasonic North America"
        }
        else if( lowerTitle.contains("6")){
            intro = "\(artworkTitle) is the VP of Sales and Business Development at Service Robotics & Technologies"
        }
        else if( lowerTitle.contains("7")){
            intro = "\(artworkTitle) is a Enterprise Employee Experience Product Specialist at Qualtrics"
        }
        artworkDesc.text = intro
        artworkDesc.isUserInteractionEnabled = true
        artworkDesc.isEditable = false
        return artworkDesc
    }

    private func getLocationCoords(artworkName: String)-> UITextView{
        let lowerTitle = artworkName.lowercased()
        var coords = "40.057357,-109.3932191"
        if lowerTitle.contains("1"){
            coords = "40.057357,-109.3932191"
        }
        if lowerTitle.contains("2"){
            coords = "40.057357,-109.3932191"
        }
        if lowerTitle.contains("3"){
            coords = "40.057357,-109.3932191"
        }
        if lowerTitle.contains("4"){
            coords = "40.057357,-109.3932191"
        }
        if( lowerTitle.contains("5")){
            coords = "40.057357,-109.3932191"
        }
        if( lowerTitle.contains("6")){
            coords = "40.057357,-109.3932191"
        }
        if( lowerTitle.contains("7")){
            coords = "40.057357,-109.3932191"
        }
        if( lowerTitle.contains("8")){
            coords = "40.057357,-109.3932191"
        }
        locationLink.isUserInteractionEnabled = true
        let locationString = "Map \(coords)"
        let stringLength = locationString.count
        let locationAttString = NSMutableAttributedString(string: locationString)
        locationAttString.addAttribute(.link, value: "https://goo.gl/maps/JfWfKVineH1wZ6Vk6", range: NSRange(location: 0, length: stringLength))
        locationLink.attributedText = locationAttString
        return locationLink
    }
    
    func locationLink(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }

    private func getContactInfo(artworkTitle: String)-> UITextView{
        contactLink.isUserInteractionEnabled = true
        let contactString = "Inquire @ Modern West Fine Art"
        let stringLength = contactString.count
        let contactAttString = NSMutableAttributedString(string: contactString)
        contactAttString.addAttribute(.link, value: "https://www.modernwestfineart.com/search/?search=Adam+Terry", range: NSRange(location: 0, length: stringLength))
        contactLink.attributedText = contactAttString
        return contactLink
    }
    
    func contactLink(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    
}
