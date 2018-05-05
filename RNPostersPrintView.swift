//
//  RNPostPrintView.swift
//  Ocus
//
//  Created by Elf on 03.02.2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

import UIKit
import KiteSDK

class RNPostersPrintView: UIView, OLKiteDelegate {
  weak var postersPrintViewController: OLKiteViewController?
  var onDidFinish: RCTBubblingEventBlock?
  
  var assets: [String] = [] {
    didSet {
      if let postersVc = postersPrintViewController {
        postersVc.addCustomPhotoProvider(
          with: [OLImagePickerProviderCollection(array: assets.map { OLAsset(filePath: $0) }, name: nil)],
          name: "Crafted Arts",
          icon: UIImage(named: "ic_album")
        )
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("nope") }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if postersPrintViewController == nil {
      embed()
    } else {
      postersPrintViewController?.view.frame = bounds
    }
  }
  
  private func embed() {
    guard let parentVC = parentViewController else {
      return
    }
    
    OLKitePrintSDK.setAPIKey("", with: .sandbox)
    guard let vc = OLKiteViewController.init(assets: []) else {
      return
    }
    
    parentVC.addChildViewController(vc)
    addSubview(vc.view)
    vc.view.frame = bounds
    vc.delegate = self
    vc.didMove(toParentViewController: parentVC)
    vc.addCustomPhotoProvider(
      with: [OLImagePickerProviderCollection(array: assets.map { OLAsset(filePath: $0) }, name: nil)],
      name: "Crafted Arts",
      icon: UIImage(named: "ic_album")
    )
    self.postersPrintViewController = vc
  }
  
  func kiteControllerDidFinish(_ controller: OLKiteViewController) {
    guard let onDidFinishCallback = self.onDidFinish else {
      return
    }
    
    onDidFinishCallback([:])
  }
}

extension UIView {
  var parentViewController: UIViewController? {
    var parentResponder: UIResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder!.next
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
    }
    
    return nil
  }
}
