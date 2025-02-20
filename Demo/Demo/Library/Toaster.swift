//
//  Toaster.swift
//  Toaster
//
//  Created by Intesys on 02/12/2019.
//  Copyright © 2019 Intesys. All rights reserved.
//

import SwiftUI
import Combine

struct ToastAppender: ViewModifier {
    @ObservedObject var manager = Toaster.shared

    @State var offset: CGFloat = Toaster.defaultOffscreenOffset

    var alignment: VerticalAlignment

    var offsetMultiplier: CGFloat {
        return alignment == .bottom ? 1 : -1
    }
    var toastPadding: Edge.Set {
        return alignment == .bottom ? .bottom : .top
    }
    func body(content: Content) -> some View {
        ZStack {
            content
            toastLayout
        }
    }

    var toastLayout: some View {
        return VStack {
            if alignment == .bottom {
                Spacer()
            }
            toast
                .offset(x: 0, y: offset * self.offsetMultiplier)
                .padding(toastPadding)
                .onReceive(Toaster.shared.offsetSubject) { (off) in
                    withAnimation(.spring()) {
                        self.offset = off
                    }
            }
            if alignment == .top {
                Spacer()
            }
        }

    }

    var toast: some View {
        VStack {
            manager.displayedToast()
        }.edgesIgnoringSafeArea(.bottom)

    }
}

extension View {
    func withToasts(alignment: VerticalAlignment) -> some View {
        self.modifier(ToastAppender(alignment: alignment))
    }
}

class Toaster: NSObject, ObservableObject {

    static let shared: Toaster = Toaster()

    static let defaultOffscreenOffset: CGFloat = 300

    /// ⛔️ Never remove this or changes won't be published
    let objectWillChange = ObservableObjectPublisher()

    let offsetSubject = PassthroughSubject<CGFloat, Never>()

    var text: String?

    static var defaultForegroundColor: Color = .white
    static var defaultBackgroundColor: Color = .green
    static var defaultCornerRadius: CGFloat = 6.0
    static var defaultDuration: TimeInterval = 2.0

    var foregroundColor: Color = .white
    var backgroundColor: Color = .green
    var cornerRadius: CGFloat = 6.0

    var image: UIImage?

    var duration: TimeInterval = 3.0
    var offset: CGFloat = Toaster.defaultOffscreenOffset

    static func toast(_ text: String, image: UIImage? = nil, duration dur: TimeInterval = defaultDuration, foregroundColor fc: Color = defaultForegroundColor, backgroundColor bc: Color = defaultBackgroundColor, cornerRadius cr: CGFloat = defaultCornerRadius) {
        Toaster.shared.toast(text, image: image, duration: dur, foregroundColor: fc, backgroundColor: bc, cornerRadius: cr)
    }

    func toast(_ text: String, image: UIImage? = nil, duration: TimeInterval, foregroundColor: Color, backgroundColor: Color, cornerRadius: CGFloat) {
        guard self.text == nil else {
            return
        }
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.duration = duration
        self.image = image
        self.text = text
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.objectWillChange.send()
            strongSelf.offsetSubject.send(0)
            Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { (_) in
                strongSelf
                    .offsetSubject.send(strongSelf.offset)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    strongSelf.text = nil
                })
        }
        }
    }

    func nonnulImage() -> Image? {
        if let img = self.image {
            return  Image(uiImage: img)
        }
        return nil
    }
    func displayedToast() -> some View {
        HStack {
            nonnulImage()

            Text(text ?? "")
                .font(.body)
        }
        .padding()
        .background(backgroundColor)
        .clipped()
        .cornerRadius(cornerRadius)
        .foregroundColor(foregroundColor)
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.1), radius: 10)
    }
}

extension Notification.Name {

    static let onPostToast = Notification.Name("onPostToast")
}
