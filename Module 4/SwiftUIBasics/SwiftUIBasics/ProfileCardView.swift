//
//  ProfileCardView.swift
//  SwiftUIBasics
//
//  Created by Diplomado on 08/12/23.
//

import SwiftUI

struct ProfileCardView: View {
    @State var followerCount = 99
    @State var isFollowed = false
    var vm = ProfileCardVM
    var body: some View {
            HStack{
                //            scaledToFit o aspectRatio ... .fit son lo mismo (?)
    //            Image("avatarProfile")
    //            Image(person.image)
    //                .resizable()
    //                .scaledToFit()
    ////                .aspectRatio(contentMode: .fit)
    //                .frame(width: 92)
    //                .opacity(0.8)
    ////                .overlay {
    ////                    Color
    ////                        .black
    ////                        .opacity(0.4)
    ////                        .overlay {
    ////                            Text("JD")
    ////                                .font(.largeTitle)
    ////                                .fontWeight(.black)
    ////                                .foregroundStyle(.white)
    ////                        }
    ////                }
    //                .clipShape(.circle)
    //                .overlay {
    //                    RoundedRectangle(cornerRadius: 100)
    //                        .stroke(.white, lineWidth: 4)
    //                }
    //                .shadow(radius: 10)
                
                //        por defecto, SwiftUI alinea todo al centro
                //        puede usarse alignment: .trailing, .center, .leading, etc en el stack, los elementos agregados a ese stack van a alinearse a la opcion seleccionada
                
                CircularImage(imageName: vm.name, size: 92)
                VStack(alignment: .leading) {
                    //            Text("Some really large text")
                    ////                .fontWeight(.bold)
                    ////                .font(.system(size: 32, weight: .regular, design: .rounded))
                    //                .font(.body)
                    ////                .fontWeight(.medium)
                    //                .fontDesign(.rounded)
                    //                .lineLimit(5)
                    //                .lineSpacing(30)
                    //                .padding()
                    
                    //            El orden de los .font .fontDesign, .etc importa, son modificadores (como en Blender).
                    //            Por ejemplo: si pones un bgColor antes de un padding, el bgColor tomará todo el espacio antes del padding, por lo que vas a ver el bgColor junto al espacio, si lo pones después, el bgColor solo estará en el elemento después de aplicar los espacios.
                    
                    Text(vm.name)
                        .font(.headline)
                        .fontDesign(.rounded)
                        .foregroundStyle(.primary)
                    Text(vm.bio)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    HStack {
//                        Button(isFollowed ? "Unfollow" : "Follow"){
                        Button("Follow"){
                            vm.followers += 1
//                            if isFollowed {
//                                vm.followerCount -= 1
//                            } else {
//                                vm.followerCount += 1
//                            }
//                            isFollowed = !isFollowed
                        }
                        .buttonStyle(.bordered)
                        Spacer()
                        Text("\(vm.followers) followers")
                    }
                }
            }
            .padding()
    }
}

#Preview {
//    ProfileCardView(vm: ProfileCardVM(image: "avatarProfile", name: "John Doe", bio: "Amateur photographer and hobbist", followers: 97))
    ProfileCardView()
}
