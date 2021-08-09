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
    @IBOutlet var locationLink: UIButton!
    @IBOutlet var contactLink: UITextView!
    @IBOutlet var audioSwitch: UISwitch!
    
    
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
//        locationLink.textContainerInset = UIEdgeInsets(top:0,left:20,bottom:0,right:10)
        contactLink.textContainerInset = UIEdgeInsets(top:0,left:20,bottom:0,right:10)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationController?.navigationBar.prefersLargeTitles = false

        artworkTitle = getArtworkTitle()
        MusicPlayer.shared.startBackgroundMusic(artworkTitle: artworkTitle!)
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
        audioSwitch.accessibilityIdentifier = "Audio On/Off"
        audioSwitch.addTarget(self, action: #selector(stateChanged), for: .valueChanged)
    }
    
    func getArtworkTitle()-> String{
        let pictureName = selectedImage?.description.replacingOccurrences(of: prefix, with: "").replacingOccurrences(of: suffix, with: "")
        title = pictureName
        return pictureName!
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
        let desc = getDescriptionText(artworkTitle: artworkTitle!)
        let contactlink = getContactText(artworkTitle: artworkTitle!)
        let textToSend = "\(artworkTitle ?? "") by Adam Michael Terry \n \(desc) \n \(contactlink)"

        let vc = UIActivityViewController(activityItems: [image, textToSend], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        if audioSwitch.isOn {
            MusicPlayer.shared.stopBackgroundMusic()
            audioSwitch.setOn(false, animated:true)
        } else {
            audioSwitch.setOn(true, animated:true)
        }
    }
    
    @objc func stateChanged(switchState: UISwitch, artworkTitle: String) {
        if switchState.isOn {
            MusicPlayer.shared.startBackgroundMusic(artworkTitle: getArtworkTitle())
        } else {
            MusicPlayer.shared.stopBackgroundMusic()
        }
    }
    
    private func getDescription(artworkTitle: String) -> UITextView{
        artworkDesc.text = getDescriptionText(artworkTitle: artworkTitle)
        artworkDesc.isUserInteractionEnabled = true
        artworkDesc.isEditable = false
        return artworkDesc
    }
    
    private func getDescriptionText(artworkTitle: String) -> String{
        let lowerTitle = artworkTitle.lowercased()
        var intro = "No Decription Found"
        if lowerTitle.contains("1"){
            intro = "\(artworkTitle) is a mythological soundscape with a percussive foot-trail that guides you through synthesizer crevices, woodwind hoodoos and archaic bassline phrases. \n A pre-conceived multi media work, Fantasy Canyon was completed with medium format photography to picture score the music. The esoteric canyon is located in the middle of the remote desert and desolate oil fields of Vernal, Utah. Shapes of sounds and melodic phrases combo and complement each other, stringing together a syntax of fantasy and reality... synthetic and acoustic."
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
        return intro
    }

    private func getLocationCoords(artworkName: String)-> UIButton{
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
        locationLink.isUserInteractionEnabled = true
        let locationString = "Map Location"
        locationLink.setTitle(locationString, for: .normal)
        return locationLink
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let url = URL(string: "https://goo.gl/maps/JfWfKVineH1wZ6Vk6")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }


    private func getContactInfo(artworkTitle: String)-> UITextView{
        contactLink.isUserInteractionEnabled = true
        contactLink.attributedText = getContactText(artworkTitle: artworkTitle)
        return contactLink
    }
    
    private func getContactText(artworkTitle: String) -> NSAttributedString{
        let contactString = "Inquire @ Modern West Fine Art"
        let stringLength = contactString.count
        let contactAttString = NSMutableAttributedString(string: contactString)
        contactAttString.addAttribute(.link, value: "https://www.modernwestfineart.com/search/?search=Adam+Terry", range: NSRange(location: 0, length: stringLength))
        return contactAttString
    }
    
    func contactLink(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    
}
