//// ACiiL
//// Citations in readme and in source.
//// https://github.com/ACIIL/ACLS-Shader
Shader "ACiiL/toon/extra/ACLS_Cutout_Write_Depth" {
    CGINCLUDE
    #include "UnityCG.cginc"
    #include "AutoLight.cginc"
    #include "Lighting.cginc"
    #include "./ACLS_HELPERS.cginc"
    #include "./ACLS_VERT_FRAG.cginc"
    ENDCG
    Properties
    {
        [Enum(OFF,0,FRONT,1,BACK,2)] _CullMode("Cull Mode", int) = 2
        _Color("_Color", Color) = (0,0,0,0)
        _Cutoff("_Cutoff",Range(0,1)) = 1
        _DepthZoneMask("Depth Zone Mask (G)",2D) = "White" {}
    }

    SubShader
    {
        Tags{
            "Queue"="Geometry+50"
            "IgnoreProjector"="True" 
            "ForceNoShadowCasting"="True"
        }
        Stencil
        {
            Ref 421
            Comp Always
            Pass Replace
        }
        Pass
        {
            Tags { "LightMode" = "Always" }
            Cull [_CullMode]
            ColorMask 0
            ZWrite On
            //// ref: 
            /////https://github.com/HhotateA/FakeSSS_UnityShader/blob/master/Assets/HOTATE_FakePBSSS/SSS.shader
            ZTest LEqual
            CGPROGRAM
            #pragma vertex emptyVert
            #pragma fragment emptyFrag
            ENDCG
        }
    }
}

