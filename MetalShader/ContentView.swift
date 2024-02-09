//
//  ContentView.swift
//  MetalShader
//
//  Created by Sparsh Paliwal on 2/7/24.
//

import SwiftUI

struct ContentView: View {
    var start = Date.now
    
    var body: some View {
        ScrollView {
            TimelineView(.animation) { tl in
                let elapsed = start.distance(to: tl.date)
                Image(systemName: "globe")
                    .font(.system(size: 200)).bold()
                    .foregroundStyle(.tint)
                    .colorEffect(
                        /// Swift dynamically looks at all of our shaders in all of our metal files and then addes them to ShaderLibrary, where we can access them.
                        /// ShaderLibrary.makeRed()
                        
                        ShaderLibrary.rainbow(.float(elapsed))
                    )
                Text("Color Effect")
                
                Image(systemName: "globe")
                    .font(.system(size: 200)).bold()
                    .foregroundStyle(.tint)
                    .distortionEffect(
                        /// colorEffect is used to just chnage color, to move pixels around we use distortion effect.
                        ShaderLibrary.wave(.float(elapsed)),
                        maxSampleOffset: .zero
                    )
                Text("Distortion Effect / Clips a bit")
                
                Image(systemName: "globe")
                    .font(.system(size: 200)).bold()
                    .foregroundStyle(.tint)
                    .padding(20)
                    .background(.white)
                    .drawingGroup()
                    .distortionEffect(
                        ShaderLibrary.wave(.float(elapsed)),
                        maxSampleOffset: .zero
                    )
                Text("Distortion Effect / drawing group to avoid clipping")
                
                Image(systemName: "globe")
                    .font(.system(size: 200)).bold()
                    .foregroundStyle(.tint)
                    .padding(20)
                    .background(.white)
                    .drawingGroup()
                    /// visualEffect is a new modifier in iOS17 that gives us size of current frame
                    .visualEffect { content, proxy in
                            content.distortionEffect(
                                ShaderLibrary.edgeFixedWave(.float(elapsed), .float2(proxy.size)),
                                maxSampleOffset: .zero
                            )
                    }

                Text("Distortion Effect / avoid clipping / edge fixed")
                
                Image(systemName: "globe")
                    .font(.system(size: 200)).bold()
                    .foregroundStyle(.tint)
                    .padding(20)
                    .background(.white)
                    .drawingGroup()
                    .distortionEffect(
                        ShaderLibrary.wave(.float(elapsed)),
                        maxSampleOffset: .zero
                    )
                Text("Distortion Effect / drawing group to avoid clipping")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
