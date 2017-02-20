#ifndef MetalShaderStructs_h
#define MetalShaderStructs_h

struct vertex_source
{
    float2 coords;
    packed_float2 texture;
};

struct vertex_destination
{
    float4 coords [[position]];
    float2 texture;
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
