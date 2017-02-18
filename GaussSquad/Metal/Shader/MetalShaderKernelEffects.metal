#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

kernel void
kernel_effects(texture2d<float, access::read> read_texture [[texture(0)]],
               texture2d<float, access::write> write_texture [[texture(1)]],
               uint2 grid_id [[thread_position_in_grid]])
{
    int width = read_texture.get_width();
    int height = read_texture.get_height();
    float2 uv = float2(grid_id) / float2(width, height);
    
    float4 current_texture = read_texture.read(grid_id);
    float3 color = float3(current_texture[0], current_texture[1], current_texture[2]);
    if(fmod(uv.x, 0.1) < 0.005 || fmod(uv.y, 0.1) < 0.005) color = float3(0,0,1);
    float2 uv_ext = uv * 2.0 - 1.0;
    if(abs(uv_ext.x) < 0.02 || abs(uv_ext.y) < 0.02) color = float3(1, 0, 0);
    if(abs(uv_ext.x - uv_ext.y) < 0.02 || abs(uv_ext.x + uv_ext.y) < 0.02) color = float3(0, 1, 0);
    write_texture.write(float4(color, 1), grid_id);
}
