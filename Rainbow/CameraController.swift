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
    
    var image: UIImage?
    
    let camera: UIButton = {
        let camera = UIButton(type: .custom)
        camera.backgroundColor = UIColor.clear
        camera.setImage(UIImage(named: "capture"), for: .normal)
//        camera.setBackgroundImage(UIImage(named: "capture"), for: .normal)
        // Button dimensions
//        let cameraButtonDimension = CGFloat(75.0)
//        camera.frame.size.height = cameraButtonDimension
//        camera.frame.size.width = cameraButtonDimension
//        camera.layer.cornerRadius = cameraButtonDimension/2
//        camera.layer.borderWidth = 10
        camera.addTarget(self, action: #selector(captureImage), for: .touchUpInside)
        return camera
    }()
    
    @objc func captureImage() {
        print("camera clicked")
        let settings = AVCapturePhotoSettings()
        // Capture photo
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prompt user with choice of camera vs photos from album
        
        //prompt user with camera
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setuptPreviewLayer()
        startRunningCaptureSession()
        
        // Buttons and Views subview
        self.view.addSubview(camera)
        
        // Setup Layout
        setupCameraButtonLayout()
        
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
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.isHighResolutionCaptureEnabled = true
            // Set output on the capture session
            captureSession.addOutput(photoOutput!)
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
    
    func setupCameraButtonLayout(){
        // Button layout
        camera.translatesAutoresizingMaskIntoConstraints = false
        camera.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        camera.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
//        camera.widthAnchor.constraint(equalToConstant: 75).isActive = true
//        camera.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
}

extension UIViewController: AVCapturePhotoCaptureDelegate{
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print("capture photo")
        if let imageData = photo.fileDataRepresentation(){
            guard let image = UIImage(data: imageData) else {return}
            // Save Image
            // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            let vc = PreviewController()
            vc.image = image
            self.present(vc, animated: true, completion: nil)
        }
        
    }
}
