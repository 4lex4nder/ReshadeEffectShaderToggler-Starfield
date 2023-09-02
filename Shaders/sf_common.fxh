#pragma once

namespace Starfield {
    texture texNormals : NORMALS;
    sampler sNormals { Texture = texNormals; };
    
    texture texNativeMotionVectors : MOTIONVECTORS;
    sampler sNativeMotionVectorTex { Texture = texNativeMotionVectors; };
    
    texture texAlbedo : ALBEDO;
    sampler sAlbedo { Texture = texAlbedo; };

    // https://knarkowicz.wordpress.com/2014/04/16/octahedron-normal-vector-encoding/
    float2 _octWrap( float2 v )
    {
        //return ( 1.0 - abs( v.yx ) ) * ( v.xy >= 0.0 ? 1.0 : -1.0 );
        return float2((1.0 - abs( v.y ) ) * ( v.x >= 0.0 ? 1.0 : -1.0),
            (1.0 - abs( v.x ) ) * ( v.y >= 0.0 ? 1.0 : -1.0));
    }
    
    float2 _encode( float3 n )
    {
        n /= ( abs( n.x ) + abs( n.y ) + abs( n.z ) );
        n.xy = n.z >= 0.0 ? n.xy : _octWrap( n.xy );
        n.xy = n.xy * 0.5 + 0.5;
        return n.xy;
    }
    
    float3 _decode( float2 f )
    {
        f = f * 2.0 - 1.0;
        float3 n = float3( f.x, f.y, 1.0 - abs( f.x ) - abs( f.y ) );
        float t = saturate( -n.z );
        n.xy += n.xy >= 0.0 ? -t : t;
        return normalize( n );
    }
    
    float3 get_normal(float2 texcoord)
    {
        float2 normal = tex2Dlod(sNormals, float4(texcoord, 0, 0)).xy;
        return (_decode(normal) + 1.0) / 2.0;
    }
    
    float2 get_motion(float2 texcoord)
    {
        return tex2Dlod(sNativeMotionVectorTex, float4(texcoord, 0, 0)).xy * float2(-1.0, 1.0) * 0.5;
    }
    
    float3 get_albedo(float2 texcoord)
    {
        return tex2Dlod(sAlbedo, float4(texcoord, 0, 0)).rgb;
    }
}