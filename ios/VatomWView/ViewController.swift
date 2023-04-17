//
//  ViewController.swift
//  VatomWView
//
//  Created by Sebastian Sanchez on 23/01/23.
//

import UIKit
import VatomWallet

class ViewController: UIViewController, UIScrollViewDelegate {
    var vatom: VatomWallet?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Get the access token & refresh token after the token-exchange and pass it to the VatomWallet
        let vatomAccessToken = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6bG9nZ2VkLWluLXZpYSI6Im1hZ2ljLWNvZGUiLCJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiclQ2WWo1VmZEclVWSGhEVGozZnFCIiwic3ViIjoiajJobnN2dCIsImlhdCI6MTY3OTUwODc3NSwiZXhwIjoxNjc5NTEyMzc1LCJzY29wZSI6Im9wZW5pZCBlbWFpbCBwcm9maWxlIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiIzSDVxcHlpUXU5In0.kgKgh8rKODtTD4NrnC1ej8IpfVIRtJThmSNgEcllPncty4vCOxlyglgawuGz-HSfF--SbAYwpeYhveDTRwT2u7b-KSk6HNtKOIjKiQMnZJX7PbugDcTmEIomTbxiy-jnohKmLd0nHBe9iVrcILKzVBmFabbtBp871weUfkq4pckIfntFYvX9XW94xyOPYTi2CvY3gFx38c3P3cm_WN8Vw9JC4b5CKFxVZsCMBIx4VCAvEV8xfbl9eHMPg6Pn-KbHtOCRhB5aF5j_voW1hdGwXdATKTVYtgHIMQgDHa2m1wEf3Bnyo_-ExUwUP_pnwNvlFq9DvhBCHkXUbC4REx8KCQ"
        self.vatom = VatomWallet(accessToken:vatomAccessToken,view: self.view)
        view.addSubview(vatom!)
        
        vatom?.scrollView.delegate = self
        vatom?.scrollView.bounces = false
        vatom?.scrollView.bouncesZoom = false
                
        vatom?.load()
    }


}

