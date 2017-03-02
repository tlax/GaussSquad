#include <metal_stdlib>

using namespace metal;
#include "MetalShaderPlotStructs.h"

static constant float destination_position = 1;
static constant float coord_z = 0;

vertex vertex_destination
plot_vertex(constant vertex_source* vertex_array [[buffer(0)]],
            constant projection_matrix& projection [[buffer(1)]],
            constant position_matrix& position [[buffer(2)]],
            unsigned int vid [[vertex_id]])
{
    vertex_source source = vertex_array[vid];
    vertex_destination destination;
    
    float coords_x = source.coords[0];
    float coords_y = source.coords[1];
    float projection_width = projection.project_width;
    float projection_height = projection.project_height;
    float move_x = position.move_x;
    float move_y = position.move_y;
    
    float projected_x = coords_x / projection_width;
    float projected_y = coords_y / projection_height;
    float projected_move_x = move_x / projection_width;
    float projected_move_y = move_y / projection_height;
    float final_x = projected_x + projected_move_x;
    float final_y = projected_y + projected_move_y;
    float4 coords = float4(final_x, final_y, coord_z, destination_position);
    
    destination.coords = coords;
    destination.texture = source.texture;
    
    return destination;
}
