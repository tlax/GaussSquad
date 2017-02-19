#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

static constant float4 color_white = float4(1,1,1,0);
static constant float4 color_black = float4(0,0,0,0);

kernel void
kernel_effects(texture2d<float, access::read> read_texture [[texture(0)]],
               texture2d<float, access::write> write_texture [[texture(1)]],
               uint2 grid_id [[thread_position_in_grid]])
{
    float4 current_color = read_texture.read(grid_id);
    
    if (all(current_color != color_white))
    {
        if (all(current_color != color_black))
        {
            float4 new_color = current_color;
            uint pos_x = grid_id.x;
            uint pos_y = grid_id.y;
            float divisor = 1;
            
            for (uint index_x = pos_x - 1; index_x <= pos_x + 1; index_x++)
            {
                for (uint index_y = pos_y - 1; index_y <= pos_y + 1; index_y++)
                {
                    uint2 other_id = uint2(index_x, index_y);
                    float4 other_color = read_texture.read(other_id);
                    
                    if (any(current_color != other_color))
                    {
                        divisor++;
                    }
                }
            }
            
            new_color[3] = 1 / divisor;
            write_texture.write(new_color, grid_id);
        }
    }
    else
    {
//        write_texture.write(float4(1,0,0,1), grid_id);
    }
}
