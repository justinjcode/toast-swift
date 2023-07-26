//
//  SwiftUIToast.swift
//  ToastViewSwift
//
//  Created by justin zhang on 2023/7/16.
//
import SwiftUI

@available(iOS 16.0, *)
struct JCToast: UIViewRepresentable {
    
    typealias UIViewType = AppleToastView
    
    @Binding var show: Bool
    var title: String
    var subTitle: String?
    
    func makeUIView(context: Context) -> AppleToastView {
        let toast = Toast.text(title, subtitle: subTitle)
        let toastView = toast.view as! AppleToastView
        toastView.makeConstraintsForSwiftUI()
        toastView.isHidden = !show
        print("\(#function)")
        return toastView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("\(#function) show: \(show)")
        uiView.isHidden = !show
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: AppleToastView, context: Context) -> CGSize? {
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

@available(iOS 16.0, *)
struct JCToast_Previews: PreviewProvider {
    
    @State static var show: Bool = true
    
    static var previews: some View {
        Color(.red).jcToast(isPresented: $show, title: "哈哈哈哈哈").frame(width: 200, height: 300).position(.init(x: 230, y: 310))
    }
}

@available(iOS 16.0, *)
extension View {
    
    func jcToast(isPresented: Binding<Bool>, title: String, subTitle: String? = nil) -> some View {
        
        self.overlay {
            JCToast(show: isPresented, title: title, subTitle: subTitle)
        }
    }
    
}

