//
//  NewViewController.swift
//  Informantion&Followers
//
//  Created by itisioslab on 22.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameNavigationItem: UINavigationItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var infoScrollView: UIScrollView!
    
    var user: User!
    let barNavigationBackGroundImage = #imageLiteral(resourceName: "bar-navigation-background-image")
    let years = " years"
    let sidebarImage = #imageLiteral(resourceName: "icon-menu")
    let pointsImage = #imageLiteral(resourceName: "icon-points")
    let borderWidth: CGFloat = 1
    let borderColour = UIColor.init(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
    let buttonWidth = 35
    let buttonHeight = 35
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackgroundNavagation()
        user = createUser()
        setInfo(for: user)
        roundImage(for: avatarImageView)
        //setupNavigationBarItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeBackgroundNavagation() {
        self.navigationController?.navigationBar.barTintColor = UIColor.blue
    }
    
    func roundImage(for image: UIImageView) {
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
    }
    
    func createUser() -> User {
        var user = UserInfo.createInfo()
        for _ in 0 ..< 10 {
            user.followers.append(UserInfo.createInfo())
        }
        return user 
    }
    
    func changeBorder(for view: UIView) {
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColour
    }
    
    func setupNavigationBarItems() {
        let sidebarButton = UIButton(type: .system)
        sidebarButton.setImage(sidebarImage, for: .normal)
        sidebarButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: 10)
        sidebarButton.contentMode = .scaleAspectFit
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: sidebarButton)
        
        let pointsButton = UIButton(type: .system)
        pointsButton.setImage(pointsImage, for: .normal)
        pointsButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        pointsButton.contentMode = .scaleAspectFit
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pointsButton)
    }
    
    func setInfo(for user: User) {
        avatarImageView.image = user.avatar
        nameNavigationItem.title = user.name
        nameLabel.text = user.name
        nameLabel.sizeToFit()
        surnameLabel.text = user.surname
        surnameLabel.sizeToFit()
        ageLabel.text = String(user.age) + years
        ageLabel.sizeToFit()
        cityLabel.text = user.city
        cityLabel.sizeToFit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "followersIdentifier" {
            let followersVC = segue.destination as! FollowersTableViewController
            followersVC.followers = user.followers
        }
        if segue.identifier == "ownInfoIdentifier" {
            let ownInfoVC = segue.destination as! OwnInfoTableViewController
            ownInfoVC.nameUser = user.name
            ownInfoVC.surnameUser = user.surname
            ownInfoVC.avatarUser = user.avatar
            ownInfoVC.ageUser = String(user.age) + years
            ownInfoVC.cityUser = user.city
        }
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
