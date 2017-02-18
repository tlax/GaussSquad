#ifndef MetalShaderStructs_h
#define MetalShaderStructs_h

struct vertex_source
{
    float2 vector_start;
    float2 vector_end;
    float line_width;
};

struct vertex_destination
{
    float4 vector_start_a [[position]];
    float4 vector_start_b [[position]];
    float4 vector_end_a [[position_end_a]];
    float4 vector_end_b [[position_end_b]];
};

struct projection_matrix
{
    float project_width;
    float project_height;
};

struct fragment_color
{
    float red;
    float green;
    float blue;
    float alpha;
};

#endif
