//
//  UserListViewController.swift
//  MVRCache
//
//  Created by Admin on 26/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import MVCacheManager

//Height Constant for UITableViewCell Height
struct UserListCellHeight {
    static let cellHeight = 110
}


class UserListViewController: UIViewController {

    //IBOutlet Properties : -
    @IBOutlet weak var userListTableView: UITableView!

    //Properties : -
    var userListArray:Array<UserList> = Array()
    var refreshControl = UIRefreshControl()

    // MARK:- ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    
    override func didReceiveMemoryWarning() {
        CacheManager.manage.clearMemoryCache()
    }
    
    
    // MARK:- UI Methods
    
    func setupUI() {
        self.registerNibs()
        self.setupNavigationBar()
        self.setupPullToRefresh()
        self.userListTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.userListTableView.accessibilityIdentifier = "table--userListTableView"
        self.callWSTofetchUsers()
        self.initilizeCacheHandler()
    }
    
    /*
     * This method will setup NavigationBar
     */
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appColor, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.navTextColor, alpha: 1.0)]
        self.title = "Users"
    }
    
    /*
     * This method will setup PullToRefreshControl
     */
    func setupPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Loading Data")
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appColor, alpha: 1.0)
        self.userListTableView.addSubview(refreshControl)

    }
    
    /*
     * Observer method for pull to refresh
     */
    @objc func pullToRefresh(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            SharedClass.sharedInstance.hasConnectivity(completion: { (checkConnection:String?) -> Void in
                if  checkConnection == "Not reachable" {
                    DispatchQueue.main.async {
                        self.refreshControl.endRefreshing()
                    }
                }
            })
        }
        self.callWSTofetchUsers()
    }
    
    /*
     * This method will setup nib for UITableViewCell
     */
    func registerNibs() {
        let nib1 = UINib(nibName: TagIDConstant.cellIDs.UserCell, bundle: nil)
        userListTableView.register(nib1, forCellReuseIdentifier: TagIDConstant.cellIDs.UserCell)
        userListTableView.tableFooterView = UIView()
    }
    
    
    /*
     * This method will setup initilize CacheManager Handler
     */
    func initilizeCacheHandler() {
        CacheManager.manage.initWithNameSpace(specifiedSpace: "app", shouldEvict: true, delegate: self)
        CacheManager.manage.setMaxCountLimit(count: 10)
    }
    
    // MARK:- WebService Methods
    /*
     * This method will use to fetch users from user_list API
     */
    func callWSTofetchUsers() {
     
        UserManager.manage.fetchUsers(vc: self,completion:{(userList) -> Void in
            if userList != nil  {
               ///print(userList)
                self.userListArray.removeAll()
                self.userListArray = userList!
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.userListTableView.reloadData()
                }
            }
        })
    }
   
}


// MARK:- UITableView Delegate Methods

extension UserListViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(UserListCellHeight.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TagIDConstant.cellIDs.UserCell, for: indexPath) as! UserCell
        let currentUser:UserList = self.userListArray[indexPath.row]
        cell.setUserDetails(currentUser: currentUser)
        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
}

// MARK:- NSCache Delegate Methods

extension UserListViewController:NSCacheDelegate {
    
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        print(obj)
    }
}
