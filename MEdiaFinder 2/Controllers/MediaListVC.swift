//
//  MediaListVC.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 5/25/23.
//  Copyright © 2023 Nasser Co. All rights reserved.


import UIKit
import SDWebImage
import AVKit

class MediaListVC: UIViewController {


    @IBOutlet weak var segmentcontrol:UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var MediaTableView: UITableView!
    // MARK: - Propireties
    private let placeholderImageView = UIImageView()
    let placeholderImage = UIImage(named: "11")
    var player: AVPlayer?
    let playerViewController = AVPlayerViewController()
    let profileBtn = UIBarButtonItem(title: "Profile", style: .done, target:self, action:#selector(goProfile))
    private let def = UserDefaults.standard
    var listOfArtist = [Artist]()
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        placeholderImageView.image = placeholderImage
        MediaTableView.backgroundView = placeholderImageView
        MediaTableView.tableFooterView = UIView()
        MediaTableView.separatorStyle = .none
        navigationItem.title = "Media List"
        navigationItem.rightBarButtonItem = profileBtn
        profileBtn.target = self
        profileBtn.action = #selector(goProfile)
        def.setValue(true, forKey: UserDefaultsKeys.isLoggedIn)
        searchBar.delegate = self
        setUpTableView()
        setTableViewHight()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        if let w = UserDefaults.standard.object(forKey: "search") as? String{
            let para: [String:String] = ["term" : w]
            ApiManger.shared().getdata(mypara: para) { (error, artist) in
                if let error = error{
                    self.showAlert(msg: error.localizedDescription)
                }else if let arr = artist {
                    self.listOfArtist = arr
                    self.MediaTableView.reloadData()
                }
            }
            
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
      //  annnny()
     def.set(searchBar.text ?? "", forKey: "search")
    print(UserDefaults.standard.object(forKey: "search")!)
    }
  

    // MARK: - Actions
    @IBAction func segmentControlBtnChanged(_ sender: UISegmentedControl) {
        print(segmentcontrol.selectedSegmentIndex)
        fetchMediaData()
    }
    // MARK: - Methods
    
    @objc func goProfile(){
        let mainStory:UIStoryboard = UIStoryboard(name:StoryBoards.main, bundle: nil)
        let profile: ProfileVC = mainStory.instantiateViewController(withIdentifier: Views.profile) as! ProfileVC
        self.navigationController?.pushViewController(profile, animated: true)
        
    }
    // MARK: - Methods Api
    
  private func relodDataFromApi(){
        let para:[String:String] = ["term" :searchBar.text ?? "" ]
       let act = activtyIndicator.showActivtyIndicator(view: self.view)
        ApiManger.shared().getdata(mypara:para){[weak self] (error, artArr) in
            if let error = error {
               self?.showAlert(msg:error.localizedDescription)
            activtyIndicator.stopActivtyIndicator(activty: act)
            } else if let mediaData = artArr {
                self?.listOfArtist = mediaData
           activtyIndicator.stopActivtyIndicator(activty: act)
                self?.MediaTableView.reloadData()
            }
        }

    }
   private func fetchMediaData() {
        let mediaType: String?
        
        switch segmentcontrol.selectedSegmentIndex {
        case 0:
            mediaType = ""
        case 1:
            mediaType = "tvShow"
        case 2:
            mediaType = "music"
        case 3:
            mediaType = "movie"
        default:
            mediaType = nil
        }
        
        let parameters = ["term": searchBar.text ?? "",
                          "media": mediaType ?? ""]
         let act = activtyIndicator.showActivtyIndicator(view: self.view)
        ApiManger.shared().getFilterData(mypara: parameters) { [weak self] (error, artArr) in
            if let error = error {
                self?.showAlert(msg: error.localizedDescription)
                activtyIndicator.stopActivtyIndicator(activty: act)
            } else if let mediaData = artArr {
                print(mediaData)
                self?.listOfArtist = mediaData
                activtyIndicator.stopActivtyIndicator(activty: act)
                self?.MediaTableView.reloadData()
            }
        }
    }
}
// MARK: - UITableViewDelegate,UITableViewDataSource

extension MediaListVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfArtist.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let myCell = cell as? ArtistCell else { return }
        myCell.artistImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut], animations: {
            myCell.artistImage.transform = CGAffineTransform.identity
        }, completion: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previewURL = URL(string:listOfArtist[indexPath.row].previewUrl ?? "")
        let playerItem = AVPlayerItem(url: previewURL!)
        self.player = AVPlayer(playerItem: playerItem)
        self.playerViewController.player = self.player
        self.MediaTableView.reloadData()
        present(self.playerViewController, animated: true) {
            self.player?.play()
            }
        MediaTableView.reloadData()
        }
    //For Testing
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Alert", message: "Are You Sure ?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.listOfArtist.remove(at: indexPath.row)
            self.MediaTableView.reloadData()
        }
        let action2 = UIAlertAction(title: "No", style: .destructive, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:ArtistCell = MediaTableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as? ArtistCell else { return UITableViewCell()}
        let tapGesture = UITapGestureRecognizer(target: cell, action: #selector(cell.imageTapped))
        cell.artistImage.addGestureRecognizer(tapGesture)
        cell.artistImage.isUserInteractionEnabled = true
        switch segmentcontrol.selectedSegmentIndex {
        case 0 , 2 :
           
    cell.trackNameLabel.text = listOfArtist[indexPath.row].trackName
    cell.artistNameLabel.text = listOfArtist[indexPath.row].artistName
    cell.artistImage.sd_setImage(with: URL(string:listOfArtist[indexPath.row].artworkUrl100! ), placeholderImage: UIImage(named: "searchImg"))
            
        case 1 , 3:
    cell.trackNameLabel.text = listOfArtist[indexPath.row].trackName
    cell.artistNameLabel.text = listOfArtist[indexPath.row].longDescription
    cell.artistImage.sd_setImage(with: URL(string:listOfArtist[indexPath.row].artworkUrl100! ), placeholderImage: UIImage(named: "searchImg"))
            
        default:
            break

    }
    return cell
}
    private func setTableViewHight(){
        MediaTableView.rowHeight = UITableView.automaticDimension
        MediaTableView.estimatedRowHeight = 100
    }
    private func setUpTableView(){
        MediaTableView.delegate = self
        MediaTableView.dataSource = self
        MediaTableView.register(UINib(nibName: "ArtistCell", bundle: nil), forCellReuseIdentifier: "ArtistCell")
    }
    
}
// MARK: - UISearchBarDelegate
extension MediaListVC:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     relodDataFromApi()
       
    }
    
}

