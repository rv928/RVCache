//
//  UserCell.swift
//  MVRCache
//
//  Created by Admin on 25/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    //IBOutlet Properties : -

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userlikeLabel: UILabel!
    @IBOutlet weak var userLinkTextView: UITextView!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setUserDetails(currentUser:UserList?) {
        
        self.userNameLabel.text = currentUser?.user?.username!
        self.userlikeLabel.text = String(currentUser!.likes!) + " likes"
        self.userLinkTextView.text = currentUser?.links?.selfString!
        
       // Caching image from CacheManager
        
        CacheManager.manage.cacheResponseFromURL(sourceURL: currentUser?.user?.profile_image?.medium!, shouldStoreInCache: true, cacheType: .Image) { (outputObject, error, CurrentCacheType) in
            
            switch CurrentCacheType {
            case .Image:
                DispatchQueue.main.async {
                    self.userImageView.image = outputObject as? UIImage
                }
                break
            case .JSON:
                break
            case .Zip:
                break
            }
            
        }
    }
    
     // To redirect to web browser on click on link
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }
}
