//
//  AsyncImageEx.swift
//  CupCakeCorner
//
//  Created by Andres Gutierrez on 4/19/22.
//

import SwiftUI

/* 1) Add image from a webserve using Async.
 - Configure its size by using scale.
 2) Configure size of image by using a closure
 3) Capture any errors by checking in on different phases in downloading the image.
 */

//MARK: - AsyncImage using Scale

struct AsyncImageEx: View {
    var body: some View {
        //1) This will wait to load.
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
    }
}
//MARK: - Async using modifiers

struct AsyncImageExTwo: View {
    var body: some View {
        //2) This will show progressView while waiting for image to download from server.
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            //ProgressView provides spinning wheel
            ProgressView()
        }
        // add frame for image to fit in here
        .frame(width: 200, height: 200)
    }
}

//MARK: - Async using cases for error handeling.

// Alternatively, add error message in case problems arise.
struct AsyncImageExThree: View {
    var body: some View {
        
        //3) This will do different actions depending on which phase of the downloading process is being done.
        
        AsyncImage(url: URL(string: "https://hws.dev/img/BAD.png")) { phase in
            if let image = phase.image {
                // if an image was retrieved successfully:
            image
                .resizable()
                .scaledToFit()
            }
                //if there was an error
            else if phase.error != nil {
                Text("There was an error loading the image.")
            }else {
                //If no error or image yet, show progressView.
                ProgressView()
            }
        }
        // add frame for image to fit in here
        .frame(width: 200, height: 200)
    }
}

struct AsyncImageEx_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageEx()
    }
}
