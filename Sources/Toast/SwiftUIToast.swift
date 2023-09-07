//
//  SwiftUIToast.swift
//  ToastViewSwift
//
//  Created by justin zhang on 2023/7/16.
//
import SwiftUI

@available(iOS 13.0, *)
public struct JCToast: UIViewRepresentable {
    
    public typealias UIViewType = AppleToastView
    
    @Binding var show: Bool
    var title: String
    var subTitle: String?
    
    public init(show: Binding<Bool>, title: String, subTitle: String? = nil) {
        _show = show
        self.title = title
        self.subTitle = subTitle
    }
    
    public func makeUIView(context: Context) -> AppleToastView {
        let toast = Toast.text(title, subtitle: subTitle)
        let toastView = toast.view as! AppleToastView
        toastView.makeConstraintsForSwiftUI()
        toastView.isHidden = !show
        print("\(#function)")
        return toastView
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        print("\(#function) show: \(show)")
        uiView.updateTitle(title: title, subTitle: subTitle)
        uiView.sizeToFit()
        uiView.isHidden = !show
    }
    
    @available(iOS 16.0, *)
    public func sizeThatFits(_ proposal: ProposedViewSize, uiView: AppleToastView, context: Context) -> CGSize? {
        print(proposal)
        var containerSize = CGSize(width: 200, height: 80)
        if
            let width = proposal.width,
            let height = proposal.height {
            containerSize = CGSize(width: width, height: height)
        }
        let size = uiView.sizeThatFits(containerSize)
        return size
    }
    
}

@available(iOS 13.0, *)
struct JCToast_Previews: PreviewProvider {
    
    @State static var show: Bool = true
    
    static var previews: some View {
        Color(.red).jcToast(isPresented: $show, title: "哈哈哈哈哈").frame(width: 200, height: 300).position(.init(x: 230, y: 310))
    }
}

@available(iOS 13.0, *)
public extension View {
    
    func jcToast(isPresented: Binding<Bool>, title: String, subTitle: String? = nil) -> some View {
        if #available(iOS 15.0, *) {
            return self.overlay {
                if #available(iOS 16.0, *) {
                    JCToast(show: isPresented, title: title, subTitle: subTitle)
                } else {
                    // Fallback on earlier versions
                }
            }
        } else {
            return ZStack {
                self
                JCToast(show: isPresented, title: title, subTitle: subTitle)
            }
        }
    }
    
}

