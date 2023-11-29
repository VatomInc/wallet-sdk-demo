//
//  ViewController.swift
//  VatomWView
//
//  Created by Sebastian Sanchez on 23/01/23.
//

import UIKit
import vatom_wallet_sdk




class ViewController: UIViewController, UIScrollViewDelegate {
    var wallet: VatomWallet?
    let floatingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vatomAccessToken = ""
        let refreshToken = ""
        let businessId = "nQwtevgfOa"
        let experienceUrl = "https://vatom.com"
        let mapStyles = self.loadMapStyles()

        
        let config = VatomConfig(
            baseUrl: "https://wallet.vatominc.com",
            hideNavigation: false,
            hideDrawer: false,
            hideTokenActions: true,
            language: "en",
            disableNewTokenToast: true,
            scanner: .init(enabled: false),
            pageConfig: .init(
                theme: .init(
                    header: ["logo": "https://resources.vatom.com/a8BxS4bNj9/UR_Logo.png"],
                    iconTitle: [:],
                    icon: [:],
                    main: [:],
                    emptyState: [:],
                    mode: "dark",
                    pageTheme: "dark"
                ),
                text: ["emptyState": ""],
                features: .init(
                    notifications: [:],
                    card: [:],
                    footer: .init(
                        enabled: true,
                        icons: [
                            .init(link: experienceUrl, title: "Home", id: "home"),
                            .init(title: "Connect", id: "connect"),
                            .init(title: "Map", id: "map")
                        ]
                    )
                )
            ),
            mapStyle: mapStyles
        )
        
        
        
        self.wallet = VatomWallet(businessId: businessId, accessToken:vatomAccessToken,view: self.view, config: config, refreshToken: refreshToken)
        view.addSubview(wallet!)
        
        wallet?.scrollView.delegate = self
        wallet?.scrollView.bounces = false
        wallet?.scrollView.bouncesZoom = false
        
        wallet?.load()
        
        // Setup the floating button
        setupFloatingButton()
    }
    
    private func loadMapStyles () ->  [VatomConfig.MapStyleElement]? {
        var mapStyles: [VatomConfig.MapStyleElement]?

         if let mapStylesUrl = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
            do {
                mapStyles = try VatomConfig.loadMapStyles(from: mapStylesUrl)
            } catch {
                print("Error loading map styles: \(error)")
            }
            
        }
        
        return mapStyles
    }
    
    private func setupFloatingButton() {
        // Set the button image, if you have an image asset
        // floatingButton.setImage(UIImage(named: "YourButtonImage"), for: .normal)
        
        // Or set a title for the button
        floatingButton.setTitle("U", for: .normal)
        
        // Style the button
        floatingButton.backgroundColor = .systemBlue
        floatingButton.layer.cornerRadius = 25 // Half the height to create a circular shape
        
        // Add targets to the button
        floatingButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        
        // Disable autoresizing masks, enable autolayout
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the button to the view
        view.addSubview(floatingButton)
        
        // Set constraints for the button (e.g., bottom right corner)
        NSLayoutConstraint.activate([
            floatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            floatingButton.widthAnchor.constraint(equalToConstant: 50),
            floatingButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func floatingButtonTapped()   {
        
        
        Task {
            try await wallet?.navigateToTab("Connect")
        }
    }
    
    private func getUser (){
        Task {
            if let userData = await wallet?.getUser()  {
                // Now that we have casted userData to a dictionary, we can access its "name" key
                
                // Show an alert with the user's name
                print(userData)
                let alertController = UIAlertController(
                    title: "User Found",
                    message: "Hello, \(userData.name)!",
                    preferredStyle: .alert
                )
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                present(alertController, animated: true)
                
            } else {
                print("Could not retrieve user data.")
            }
        }
    }
    
    private func isLoggedIn (){
        Task {
            if let isLoggedIn = await wallet?.isLoggedIn()  {
                print("isLoggedIn",isLoggedIn)
                // Now that we have casted userData to a dictionary, we can access its "name" key
                // Show an alert with the user's name
                
                let alertController = UIAlertController(
                    title: "Is logged in?",
                    message: "\(isLoggedIn)!",
                    preferredStyle: .alert
                )
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                present(alertController, animated: true)
                
            } else {
                print("Could not retrieve user data.")
                
                
            }
        }
    }
    
    private func navigate(_ to: String) {
        Task {
            try await wallet?.navigateToTab(to)
        }
    }
    
    private func listTokens() {
        Task {
            let tokens =  try await self.wallet?.listTokens()
            let alertController = UIAlertController(
                title: "Tokens",
                message: "You got, \(tokens?.count) tokens!",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true)
            
        }
    }
    
    func trashFirstToken  (){
        Task {
            let tokens =  try await self.wallet?.listTokens()
            if let firstToken = tokens?.first as? [String : Any?] {
                if let id = firstToken["id"] as? String {
                    await self.wallet?.trashToken(tokenId: id)
                }
                
            }
            
        }
    }
    
    func logOut (){
        Task {
          try await self.wallet?.logOut()
        }
        
    }
    
    
    
    
    // MARK: - Action Handlers
    @objc func showActionSheet() {
        let actionSheet = UIAlertController(title: "Select an Option", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Navigate to Connect", style: .default, handler: { _ in
            self.navigate("Connect")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Log out", style: .default, handler: { _ in
            self.logOut()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Navigate to Wallet", style: .default, handler: { _ in
            self.navigate("Wallet")
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Navigate to Map", style: .default, handler: { _ in
            self.navigate("Map")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Navigate to Home", style: .default, handler: { _ in
            self.navigate("Home")
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Get User", style: .default, handler: { _ in
            self.getUser()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "How many tokens?", style: .default, handler: { _ in
            self.listTokens()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "isLoggedIn?", style: .default, handler: { _ in
            self.isLoggedIn()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Trash first token", style: .default, handler: { _ in
            self.trashFirstToken()
        }))
        
        
        
        // Cancel action
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(actionSheet, animated: true)
    }
    
}


