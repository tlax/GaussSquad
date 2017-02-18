#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

kernel void
kernel_effects(texture2d<float, access::write> base_texture [[texture(0)]],
                   uint2 grid_id [[thread_position_in_grid]])
{
    int width = base_texture.get_width();
    int height = base_texture.get_height();
    float2 uv = float2(grid_id) / float2(width, height);
    
    float3 color = float3(0.7);
    if(fmod(uv.x, 0.1) < 0.005 || fmod(uv.y, 0.1) < 0.005) color = float3(0,0,1);
    float2 uv_ext = uv * 2.0 - 1.0;
    if(abs(uv_ext.x) < 0.02 || abs(uv_ext.y) < 0.02) color = float3(1, 0, 0);
    if(abs(uv_ext.x - uv_ext.y) < 0.02 || abs(uv_ext.x + uv_ext.y) < 0.02) color = float3(0, 1, 0);
    base_texture.write(float4(color, 1), grid_id);
}
