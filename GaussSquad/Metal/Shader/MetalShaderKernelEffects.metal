#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

static constant float3 color_white = float3(1,1,1);
static constant float3 color_black = float3(0,0,0);
static constant float delta_color = 0.3;
static constant uint margin = 3;

kernel void
kernel_effects(texture2d<float, access::read> read_texture [[texture(0)]],
               texture2d<float, access::write> write_texture [[texture(1)]],
               uint2 grid_id [[thread_position_in_grid]])
{
    float4 textel = read_texture.read(grid_id);
    float3 current_color = float3(textel[0], textel[1], textel[2]);
    
    if (all(current_color != color_white))
    {
        if (all(current_color != color_black))
        {
            float3 new_color = current_color;
            uint pos_x = grid_id.x;
            uint pos_y = grid_id.y;
            float divisor = 1;
            
            for (uint index_x = pos_x - margin; index_x <= pos_x + margin; index_x++)
            {
                for (uint index_y = pos_y - margin; index_y <= pos_y + margin; index_y++)
                {
                    uint2 other_id = uint2(index_x, index_y);
                    float4 other_textel = read_texture.read(other_id);
                    float3 other_color = float3(other_textel[0], other_textel[1], other_textel[2]);
                    
                    if (any(current_color != other_color))
                    {
                        divisor += delta_color;
                    }
                }
            }
            
            write_texture.write(float4(new_color, 1 / divisor), grid_id);
        }
    }
    else
    {
        write_texture.write(float4(0,1,0,1), grid_id);
    }
}
