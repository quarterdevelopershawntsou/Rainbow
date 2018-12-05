//
//  ViewController.swift
//  Rainbow
//
//  Created by Shawn on 29/11/2018.
//  Copyright © 2018 Shawn. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prompt user with choice of camera vs photos from album
        
        
        //prompt user with camera
        setupCaptureSession()
        print("setup capture session")
        setupDevice()
        print("setup Device")
        setupInputOutput()
        print("sentup input output")
        setuptPreviewLayer()
        print("setupt Preview layer")
        startRunningCaptureSession()
        print("start running capture session")
        
        // Camera button
        cameraButton()
        
    }

    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInDualCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back{
                backCamera = device
            }else if device.position == AVCaptureDevice.Position.front{
                frontCamera = device
            }
        }
        currentCamera = backCamera
    }
    
    func setupInputOutput(){
        do {
        let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
        captureSession.addInput(captureDeviceInput)
        photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])] , completionHandler: nil)
        
        } catch{
            print(error)
        }
    }
    
    func setuptPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
    
    func cameraButton(){
        let camera = UIButton(type: .custom)
        let cameraButtonDimension = CGFloat(75.0)
        camera.backgroundColor = UIColor.clear
        // Button dimensions
        camera.frame.size.height = cameraButtonDimension
        camera.frame.size.width = cameraButtonDimension
        camera.layer.cornerRadius = cameraButtonDimension/2
        camera.layer.borderWidth = 10
        // Button position
        camera.center.x = view.center.x
        camera.center.y = view.center.y*1.7
        self.view.addSubview(camera)
        
        // Button action
        camera.addTarget(self, action: #selector(self.captureImage), for: .touchUpInside)
        
    }
    
    @objc func captureImage() {
        print("camera clicked")
    }
}

