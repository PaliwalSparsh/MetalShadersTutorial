//
//  Shaders.metal
//  MetalShader
//
//  Created by Sparsh Paliwal on 2/7/24.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 passthrough(float2 pos, half4 color) {
    return color;
}

[[ stitchable ]] half4 makeRed(float2 pos, half4 color) {
    return half4(1, 0, 0, color.a);
}

[[ stitchable ]] half4 rainbow(float2 pos, half4 color, float time) {
    float angle = atan2(pos.y, pos.x) + time;
    return half4(sin(angle), sin(angle+2), sin(angle+4), color.a);
}

[[ stitchable ]] float2 wave(float2 pos, float time) {
    pos.y += sin(time * 5 + pos.y/20) * 5;
    return pos;
}

[[ stitchable ]] float2 edgeFixedWave(float2 pos, float time, float2 size) {
    float2 distance = pos/size;
    pos.y += sin(time * 5 + pos.y/20) * distance.x * 20;
    return pos;
}

/// layer is actualy swiftUI view that we have access to, touch gives where user touches
[[ stitchable ]] half4 loupe(float2 pos, SwiftUI::Layer layer, float2 size, float2 touch) {
    float maxDistance = 0.05;
    
    float2 uv = pos/size;
    float2 center = touch/size;
    float2 delta = uv - center;
    float aspectRatio = size.x / size.y;
    
    float distance = (delta.x + delta.x) + (delta.y * delta.y) / aspectRatio;
    
    float totalZoom = 1;
    
    if (distance < maxDistance) {
        totalZoom /= 2;
    }
    
    float2 newPos = delta * totalZoom + center;
    
    return layer.sample(newPos * size);
}


