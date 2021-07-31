//
//  AvtarVC.swift
//  Assignment1
//
//  Created by Drashti Akbari on 2020-02-19.
//  Copyright © 2020 Drashti Akbari. All rights reserved.
//

import UIKit

class avtar : UICollectionViewCell {
    
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var checkbox: UIImageView!
}

class AvtarVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrOfPic = [UIImage(named: "thumbImg"),UIImage(named: "thumbImg1"),UIImage(named: "thumbImg2"),UIImage(named: "thumbImg3"),UIImage(named: "thumbImg4"),UIImage(named: "thumbImg5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK:- CollectionView Delegates & DataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // CollectionCell Size
        
        let cellWidth = (collectionView.frame.size.width / 2) 
        let cellHeight = (collectionView.frame.size.height / 3) 
        return CGSize(width:cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrOfPic.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avtar", for: indexPath as IndexPath) as! avtar
        
        cell.imgThumb.image = arrOfPic[indexPath.row]
        cell.checkbox.isHidden = true
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? avtar {
        
        if cell.checkbox.isHidden == true{
            cell.checkbox.isHidden = false

            let a = indexPath.row
            UserDefaults.standard.set(a, forKey: "thumb")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "FirstPageVC") as! FirstPageVC
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else{
           cell.checkbox.isHidden = true
        }
    }
    }
    
    @IBAction func back(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }

}
