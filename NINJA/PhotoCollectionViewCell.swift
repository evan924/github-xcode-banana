//
//  PhotoCollectionViewCell.swift
//  NINJA
//
//  Created by Annie Wang on 4/1/17.
//  Copyright © 2017 Annie Wang. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    var titleLabel:UILabel?
    var ImageView:UIImageView?
    
    override init(frame:CGRect){
        super.init(frame:frame)
        initView()
    }
    
    required init?(coder aDecoder:NSCoder){
        fatalError("init not implemented")
    }
    
    func initView(){
        //titleLabel = UILabel(frame: CGRect(x: 5, y: 5, width: (width-40)/2, height: 50))
        
        ImageView = UIImageView()
        ImageView?.frame = CGRect(x: 0,y: 0,width: (width-9)/4,height: 80)
        
        self .addSubview(ImageView!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
