//
//  VideoPlayerView.swift
//  Setareh's Workout App
//
//  Video player for exercise demonstrations
//

import SwiftUI
import WebKit

struct VideoPlayerView: View {
    let videoId: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        Spacer()

                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                        }
                    }

                    Spacer()

                    // WebView for YouTube video
                    WebView(url: URL(string: "https://www.youtube.com/embed/\(videoId)")!)
                        .frame(height: 300)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)

                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}

#Preview {
    VideoPlayerView(videoId: "L7FV0Z7k4No")
}