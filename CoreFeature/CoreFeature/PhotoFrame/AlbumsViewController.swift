//
//  AlbumsViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 

import UIKit
import Photos

class AlbumsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    enum Section: Int {
        case autoAlbums = 0
        case userCollections
    
        static let count = 2
    }
    
    var defaultAlbums: PHFetchResult<PHAssetCollection>!
    var userCollections: PHFetchResult<PHCollection>!
    let sectionTitles = ["Default Albums", "User Albums"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        initPhotoProperties()
    }
    
    func initPhotoProperties(){
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        defaultAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        PHPhotoLibrary.shared().register(self)
    }

    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }

}

extension AlbumsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionTitles[section]
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
                    case .autoAlbums: return defaultAlbums.count
                    case .userCollections: return userCollections.count
                    }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         print("section")
        switch Section(rawValue: indexPath.section)! {
                    case .autoAlbums:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "collection", for: indexPath)
                        let collection = defaultAlbums.object(at: indexPath.row)
                        cell.textLabel!.text = collection.localizedTitle
                        return cell
            
                    case .userCollections:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "collection", for: indexPath)
                        let collection = userCollections.object(at: indexPath.row)
                        cell.textLabel!.text = collection.localizedTitle
                        return cell
                    }
    }
}

extension AlbumsViewController: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
    
        DispatchQueue.main.sync {

            if let changeDetails = changeInstance.changeDetails(for: defaultAlbums) {
                defaultAlbums = changeDetails.fetchResultAfterChanges
                tableView.reloadSections(IndexSet(integer: Section.autoAlbums.rawValue), with: .automatic)
            }
            if let changeDetails = changeInstance.changeDetails(for: userCollections) {
                userCollections = changeDetails.fetchResultAfterChanges
                tableView.reloadSections(IndexSet(integer: Section.userCollections.rawValue), with: .automatic)
            }
            
        }
    }
}




