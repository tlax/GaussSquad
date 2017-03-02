#include <metal_stdlib>
using namespace metal;

static constant float3 kLightScale(0.299, 0.587, 0.114);
static constant float kLightThreshold = 0.14;
static constant float kMinColor = 0;
static constant float kMaxColor = 1;

kernel void
filter_highcontrast_kernel(texture2d<float, access::read> originalTexture [[texture(0)]],
                           texture2d<float, access::write> filteredTexture [[texture(1)]],
                           uint2 gridId [[thread_position_in_grid]])
{
    float4 gridColor = originalTexture.read(gridId);
    float lightValue = dot(gridColor.rgb, kLightScale);
    float4 outColor;
    
    if (lightValue >= kLightThreshold)
    {
        outColor = float4(kMaxColor);
    }
    else
    {
        outColor = float4(kMinColor);
    }
    
    filteredTexture.write(outColor, gridId);
}
