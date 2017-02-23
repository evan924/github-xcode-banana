//
//  NinjaViewController.swift
//  NINJA
//
//  Created by Annie Wang on 26/12/16.
//  Copyright © 2016 Annie Wang. All rights reserved.
//

import UIKit
import Photos

class NinjaViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var NavigationBar: UINavigationBar!

    @IBOutlet weak var NavigationButton1: UIButton!
    
    @IBOutlet weak var NavigationButton2: UIButton!
    
    var PhotoCollectionView: UICollectionView?
    var ScrollView: UIScrollView?
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    var photo:UIImage?
    var images=[UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationButton1.setTitle("Back", for: .normal)
        NavigationButton2.setTitle("Select", for: .normal)
        
        NavigationBar.barStyle = UIBarStyle.default
        NavigationBar.tintColor = UIColor.blue
        NavigationButton1.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        //FetchCustomAlbumPhotos()
        FetchAllPhotos()
        
        InitView()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func InitView(){
        ScrollView = UIScrollView(frame:CGRect(x: 0, y: 64, width: width, height: height-64))
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        PhotoCollectionView = UICollectionView(frame: CGRect(x:0,y:0,width:width,height:height*20), collectionViewLayout: layout)
        PhotoCollectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        PhotoCollectionView?.delegate = self
        PhotoCollectionView?.dataSource = self
        PhotoCollectionView?.backgroundColor = UIColor.white
        layout.itemSize = CGSize(width:(width-9)/4,height:80)
        ScrollView?.contentSize = CGSize(width:width,height:height*5)
        ScrollView?.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        ScrollView?.addSubview(PhotoCollectionView!)
        self.view.addSubview(ScrollView!)
    }
    
    func goBack(){
        self.navigationController?.popViewController(animated:true)
    }
   
    
    func numberOfSections(in PhotoCollectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ PhotoCollectionView: UICollectionView, numberOfItemsInSection Section:Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = PhotoCollectionView!.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!PhotoCollectionViewCell
        
        let Image = images[indexPath.row]
        cell.ImageView?.image = Image
        
        
        return cell
    }
    func addImgToArray(uploadImage:UIImage)
    {
        self.images.append(uploadImage)
        
    }
    
/*    func FetchCustomAlbumPhotos()
    {
        var albumName = "You Doodle"
        var assetCollection = PHAssetCollection()
        var photoAssets = PHFetchResult<AnyObject>()
        
        let fetchOptions = PHFetchOptions()
        //fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        //fetchOptions.predicate = NSPredicate(format: "mediaType=%d", PHAssetMediaType.image.rawValue)
        //let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        let collection:PHFetchResult = PHAssetCollection.fetchMoments(with: nil)
        if let first_Obj:AnyObject = collection.firstObject{
            //found the album
            assetCollection = collection.firstObject!
        }
        photoAssets = PHAsset.fetchAssets(in: assetCollection, options: nil) as! PHFetchResult<AnyObject>
        let imageManager = PHCachingImageManager()
        photoAssets.enumerateObjects({(object: AnyObject!,
            count: Int,
            stop: UnsafeMutablePointer<ObjCBool>) in
            
            if object is PHAsset{
                let asset = object as! PHAsset
                let imageSize = CGSize(width: asset.pixelWidth,
                                       height: asset.pixelHeight)
                
                /* For faster performance, and maybe degraded image */
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset,
                                                  targetSize: imageSize,
                                                  contentMode: .aspectFill,
                                                  options: options,
                                                  resultHandler: {
                                                    (image, info) -> Void in
                                                    self.photo = image!
                                                    self.addImgToArray(uploadImage: self.photo!)
                                                    
                })
                
            }
        })
    
    }*/
    func FetchAllPhotos(){
        var photoAssets = [PHFetchResult<AnyObject>]()
        let imageManager = PHCachingImageManager()
        
        let collection:PHFetchResult = PHAssetCollection.fetchMoments(with: nil)
        for i:Int in 0..<10 {
            photoAssets.append(PHAsset.fetchAssets(in: collection.object(at: i), options: nil)as! PHFetchResult<AnyObject>)
        }
        for i:Int in 0..<photoAssets.count {
        photoAssets[i].enumerateObjects({(object: AnyObject!,
            count: Int,
            stop: UnsafeMutablePointer<ObjCBool>) in
            
            if object is PHAsset{
                let asset = object as! PHAsset
                let imageSize = CGSize(width: asset.pixelWidth,
                                       height: asset.pixelHeight)
                
                /* For faster performance, and maybe degraded image */
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                options.normalizedCropRect = CGRect(x: 0, y: 0, width: 5, height: 5)
                
                imageManager.requestImage(for: asset,
                                          targetSize: imageSize,
                                          contentMode: .aspectFill,
                                          options: options,
                                          resultHandler: {
                                            (image, info) -> Void in
                                            self.photo = image!
                                            self.addImgToArray(uploadImage: self.photo!)
                                            
                })
                
            }
        })
        }
    }
    
    
    
    
 /*
    func presentImagePicker(){
        imagePicker!.delegate = self
        imagePicker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        ImageView.image = info[UIImagePickerControllerOriginalImage] as! UIImage?
    }
    */

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
