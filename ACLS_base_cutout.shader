//// ACiiL
//// Citations in readme and in source.
//// https://github.com/ACIIL/ACLS-Shader
Shader "ACiiL/toon/ACLS_Toon_Cutout" {
    CGINCLUDE
    #include "UnityCG.cginc"
    #include "AutoLight.cginc"
    #include "Lighting.cginc"
    #define IsClip
    #include "./ACLS_HELPERS.cginc"
    ENDCG

    Properties {
        [ShaderOptimizerLockButton] _ShaderOptimizerEnabled ("", Int) = 0
        [Enum(OFF,0,FRONT,1,BACK,2)] _CullMode("Cull Mode", int)    = 2  //OFF/FRONT/BACK
        [HDR] _backFaceColorTint("Backface Color Tint",Color)   = (1,1,1,1)

        // [Header(Toon ramp)]
        _MainTex("Main Tex", 2D) = "white" {}
        [ToggleUI] _useToonRampSystem("_useToonRampSystem", Int) = 1
        [ToggleUI] _useDiffuseAlbedoTexturesSet("_useDiffuseAlbedoTexturesSet", Int) = 0
        [Enum(Swap As,0,Multiply Over,1)] _toonRampTexturesBlendMode("_toonRampTexturesBlendMode", Int) = 0
        [Enum(Self,0,MainTex,1,Backward,2)] _Use_BaseAs1st("1st shade source", Int) = 1
        [NoScaleOffset] _1st_ShadeMap("--1st shade Tex", 2D) = "white" {}
        [Enum(Self,0,Core,1,MainTex,2)] _Use_1stAs2nd("2nd shade source", Int) = 2
        [NoScaleOffset] _2nd_ShadeMap("--2nd shade Tex", 2D) = "white" {}
        _Color("Base color", Color) = (1,1,1,1)
        [HDR] _0_ShadeColor("--Foward color", Color) = (0.97,0.97,0.97,1)
        [HDR] _1st_ShadeColor("--Core color", Color) = (0.94,0.94,0.94,1)
        [HDR] _2nd_ShadeColor("--Back color", Color) = (0.9,0.9,0.9,1)
        _BaseColor_Step("Step: forward ", Range(0, 1))  = 0.6
        _BaseShade_Feather("--Feather: forward", Range(0.0001, 1))  = 0.001
        _ShadeColor_Step("Step: back", Range(0, 1))  = 0.4
        _1st2nd_Shades_Feather("--Feather: back", Range(0.0001, 1))  = 0.001
        [Enum(All Light,0,Natural Indirect,1)] _ToonRampLightSourceType_Backwards("Toon ramp Backface light source type:",Int) = 0
        _diffuseIndirectDirectSimMix("Backward (In)Direct Mix", Range(0, 1)) = 0
        // _Set_SystemShadowsToBase("shadows mix core tone mix",Range(0,1)) = 0
        // [Space(18)]
        [Enum(Off,0,On,1)] _Diff_GSF_01("Toon ramp GSF effect", Int) = 0
        _DiffGSF_Offset("--Offset",Range(0,2)) = 1
        _DiffGSF_Feather("--Feather",Range(0.0001,2)) = 0.2
        //
        [Enum(Off,0,On,1)] _useCrossOverRim("_useCrossOverRim", Int) = 0
        _crossOverMask("_crossOverMask", 2D) = "white" {}
        _crossOverAlbedo("_crossOverAlbedo", 2D) = "white" {}
        _crossOverStep("_crossOverStep", Range(0,1)) = .5
        _crossOverFeather("_crossOverFeather", Range(0,1)) = .5
        _crosspOverRimPow("_crosspOverRimPow", Range(0,1)) = .5
        _crossOverPinch("_crossOverPinch", Range(0.1,.45)) = .1
        [HDR] _crossOverTint("_crossOverTint", Color) = (1,1,1,1)
        [Enum(Self,0,MainTex,1,Core,2,Backward,3)] _crossOverSourceTexSource("_crossOverSourceTexSource", Int) = 1
        [ToggleUI] _useAlbedoTexModding("_useAlbedoTexModding", Int) = 0
        _controllerAlbedoHSVI_1("_controllerAlbedoHSVI_1", Float) = (0,0,0,1)
        _controllerAlbedoHSVI_2("_controllerAlbedoHSVI_2", Float) = (0,0,0,1)
        _controllerAlbedoHSVI_3("_controllerAlbedoHSVI_3", Float) = (0,0,0,1)

        // [Header(Specular Shine)]
        [ToggleUI] _UseSpecularSystem("Use specular effects",Int)  = 0
        [Enum(Specular,0,Metallic,1,Roughness,2)] _WorkflowMode("_WorkflowMode", Int ) = 0
        [Enum(Off,0,On,1)] _SpecOverride("_SpecOverride", Int ) = 0
        [Enum(On,0,Off,1)] _UseDiffuseEnergyConservation("Energy conservation", Int ) = 1
        _SpecColor("Specular Primary Color",Color)    = (1,1,1,1)
        _Glossiness("Smoothness",Range(0,1))    = .3
        _Metallicness("_Metallicness",Range(0,1))    = 1
        _HighColor_Tex("--Specular Setup Tex: (RGB):Tint, (A):Smoothness", 2D)  = "white" {}
        _MetallicGlossMap("_MetallicGlossMap", 2D)  = "white" {}
        _SpecGlossMap("_SpecGlossMap", 2D)          = "white" {}
        _highColTexSource("----Multiply with albedo", Range(0,1))   = 0
        _SpecularMaskHSV("--Adjest (H)ue (S)sat (V)alue (I)ntensity",Vector) = (0,0,0,1)
        [HDR] _HighColor("Spec col 01", Color)  = (1,1,1,1)
        [Enum(Sharp,0,Soft,1,Unity,2)] _Is_SpecularToHighColor("Specular mode", Int )   = 0
        _TweakHighColorOnShadow("Spec shadow mask", Range(0, 1))    = 0.5

        // [Header(Reflection)]
        [ToggleUI] _useCubeMap("_useCubeMap",Int) = 0
        [Enum(Off,0,Mask,1,Replace,2)] _GlossinessMapMode("_GlossinessMapMode",Int) = 0
        _GlossinessMap("_GlossinessMap",2D) = "white" {}
        [Enum(Standard,1,Override,2)] _ENVMmode("Reflection Setup:",Int) = 1
        _ENVMix("--Reflection mix",Range(0,1))                                              = 1
        _envRoughness("--Reflection smoothness", Range(0, 1))                               = 0.5
        [Enum(Off,0,Smart,1,Always,2)] _CubemapFallbackMode("Fallback mix mode:",Int)      = 0
        [NoScaleOffset] _CubemapFallback("--Fallback Cubemap",Cube)                         = "black" {}
        // [Space(18)]
        [Enum(Off,0,On,1)] _EnvGrazeMix("Graze Natural mix",Int)                            = 0
        [Enum(Off,0,On,1)] _EnvGrazeRimMix("Graze RimLights Mask mix",Int)                  = 0
        _envOnRim("Mask on rimLights", Range(0,1))                                          = 0.0
        _envOnRimColorize("--Colorize rim lights", Range(0,1))                              = 1
        _rimLightLightsourceType("_rimLightLightsourceType", Range(0,1)) = 0

        // [Header(Rimlights)]
        [ToggleUI] _useRimLightSystem("_useRimLightSystem",Int)  = 1
        [Enum(Off,0,On,1)] _RimLight("RimLight blend",Int) = 1
        [Enum(Off,0,On,1)] _Add_Antipodean_RimLight("Ap RimLight blend",Int) = 1
        _rimAlbedoMix("Mix Albedo",Range(0,1)) = 0
        [Enum(Diffuse Tex,0,Specular Tex,1)] _RimLightSource("--Source albedo",Int) = 0
        [HDR] _RimLightColor("Color: RimLight",Color) = (0.8,0.8,0.8,1)
        [HDR] _Ap_RimLightColor("Color: Ap RimLight",Color) = (0.5,0.5,0.5,1)
        _RimLight_Power("Power: RimLight",Range(0, 1)) = 0.5
        _Ap_RimLight_Power("Power: Ap RimLight",Range(0, 1)) = 1
        _RimLight_InsideMask("Mask: Inside rimLight",Range(0.00001, 1)) = 0.3
        _RimLightAreaOffset("--Offset: RimLight",Range(-1, 1)) = 0
        [ToggleUI] _LightDirection_MaskOn("Use light direction",Int) = 1
        _Tweak_LightDirection_MaskLevel("--Mask: Light direction",Range(0, 1)) = 0
        //
        [Enum(Off,0,On,1)]	_useRimLightOverTone("_useRimLightOverTone", Int) = 0
        _rimLightOverToneLow("_rimLightOverToneLow",Range(0, 2)) = 0
        _rimLightOverToneHigh("_rimLightOverToneHigh",Range(0, 2)) = 1
        [HDR] _rimLightOverToneBlendColor1("_rimLightOverToneBlendColor1", Color) = (1,1,1,1)
        [HDR] _rimLightOverToneBlendColor2("_rimLightOverToneBlendColor2", Color) = (.5,.5,.5)

        // [Header(Matcap)]
        [ToggleUI] _MatCap("Use MatCap", Int ) = 0
        [ToggleUI] _useMCHardMult("_useMCHardMult", Int ) = 0
        [HDR] _MatCapColHardMult ("Multiply color", Color) = (1,1,1,1)
        [NoScaleOffset] _MatCapTexHardMult ("Multiply matcap", 2D) = "white" {}
        [HDR] _MatCapColMult ("Diffuse color", Color) = (1,1,1,1)
        [NoScaleOffset] _MatCapTexMult ("Diffuse matcap", 2D) = "black" {}
        [HDR] _MatCapColAdd ("Specular color", Color) = (1,1,1,1)
        [NoScaleOffset] _MatCapTexAdd ("Specular matcap", 2D) = "black" {}
        [HDR] _MatCapColEmis ("Emissive color", Color) = (0,0,0,1)
        [NoScaleOffset] _MatCapTexEmis ("Emissive matcap", 2D) = "black" {}
        [ToggleUI] _Is_NormalMapForMatCap("Use matcap normalMap ", Int) = 0
        [Normal] _NormalMapForMatCap("--MatCap normalMap", 2D) = "bump" {}
        // [Space(9)]
        _Tweak_MatCapUV("Zoom matCap", Range(-0.5, 0.5)) = 0
        _Rotate_MatCapUV("Rotate matCap", Range(-1, 1)) = 0
        _Rotate_NormalMapForMatCapUV("Rotate normalMap matCap", Range(-1, 1)) = 0
        _TweakMatCapOnShadow("Specular shadow mask", Range(0, 1)) = 0
        _Set_MatcapMask("Diffuse matcap mask (G)", 2D)  = "white" {}
        _Tweak_MatcapMaskLevel("--Tweak mask", Range(-1, 1)) = 0
        _McDiffAlbedoMix("MC diff albedo mix", Range(0,1)) = 0
        [Enum(Self,0,Smoothness,1)] _matcapSmoothnessSource0("_matcapSmoothnessSource0", Int) = 0
        [Enum(Self,0,Smoothness,1)] _matcapSmoothnessSource1("_matcapSmoothnessSource1", Int) = 0
        [Enum(Self,0,Smoothness,1)] _matcapSmoothnessSource2("_matcapSmoothnessSource2", Int) = 0
        [Enum(Self,0,Smoothness,1)] _matcapSmoothnessSource3("_matcapSmoothnessSource3", Int) = 0
        _BlurLevelMatcap0("_BlurLevelMatcap0", Range(0,1)) = 1
        _BlurLevelMatcap1("_BlurLevelMatcap1", Range(0,1)) = 1
        _BlurLevelMatcap2("_BlurLevelMatcap2", Range(0,1)) = 1
        _BlurLevelMatcap3("_BlurLevelMatcap3", Range(0,1)) = 1
        [ToggleUI] _CameraRolling_Stabilizer("_CameraRolling_Stabilizer", Int) = 0
        [Enum(SpecMask,0,MCMask,1)] _matcapSpecMaskSwitch("_matcapSpecMaskSwitch", Int) = 0
        [Enum(EmissionMasks,0,MCMask,1)] _matcapEmissMaskSwitch("_matcapEmissMaskSwitch", Int) = 0

        // [Header(Subsurface)]
        [ToggleUI] _useSSS("_useSSS", Int) = 0
        _SSSThicknessMask("_SSSThicknessMask", 2D) = "white" {}
        _SSSColThin("_SSSColThin", Color) = (1,1,1)
        _SSSColThick("_SSSColThick", Color) = (1,1,1)
        _SSSDepthColL("_SSSDepthColL", Range(0,1)) = 0
        _SSSDepthColH("_SSSDepthColH", Range(0,1)) = 1
        ////
        [ToggleUI] _useFakeSSS("_useFakeSSS", Int) = 0
        _SSSDensityFake("_SSSDensityFake", Range(0.0001,32)) = 1
        _SSSLensFake("_SSSLensFake", Range(0.5,1)) = .5
        ////
        _SSSLens("_SSSLens", Range(0,1)) = 0

        // [Header(Emission)]
        [ToggleUI] _emissionUseMask("_emissionUseMask", Int ) = 0
        _Emissive_Tex("Emissive mask (G)", 2D) = "white" {}
        [Enum(MainTex,0,Core,1,Backward,2)] _emisLightSourceType("_emisLightSourceType", Int) = 0
        _emissionMixTintDiffuseSlider("_emissionMixTintDiffuseSlider", Range(0,1)) = 0
        [HDR] _Emissive_Color("Emissive color", Color) = (0,0,0,1)
        _EmissionColorTex("Emissive color (RGB)", 2D) = "white" {}
        [ToggleUI] _emissionUse2ndTintRim("_emissionUse2ndTintRim", Int) = 0
        [HDR] _Emissive_Color2("Emissive color2", Color) = (0,0,0,1)
        _EmissionColorTex2("Emissive color 2 (RGB)", 2D) = "white" {}
        _emission2ndTintLow ("_emission2ndTintLow", Range(0, 1)) = 0.5
        _emission2ndTintHigh ("_emission2ndTintHigh", Range(0, 1)) = 1
        _emission2ndTintPow ("_emission2ndTintPow", Range(0.0001, 256.0)) = 1
        [ToggleUI] _emissiveUseMainTexA("Emissive Use MainTex A",Int) = 0
        // [ToggleUI] _emissiveUseMainTexCol("Emissive Use MainTex Color",Int) = 0
        _emissionUseMaskDiffuseDimming("_emissionUseMaskDiffuseDimming", Range(0,1)) = 0
        _emissionProportionalLum ("_emissionProportionalLum", Range(0, 2)) = 0

        // [Header(Lighting Behaviour)]
        _directLightIntensity("Direct light intensity",Range(0,1)) = 1
        _indirectAlbedoMaxAveScale("Indirect albedo maxAve Scale",Range(0.5,2)) = 1.5
        _indirectGIDirectionalMix("Indirect GI dir mix",Range(0,1)) = 0
        _indirectGIBlur("Indirect GI blur",Range(.5,4)) = 1
        [Enum(HDR,0,Limit,1)] _forceLightClamp("Force scene Lights Clamp",Int) = 1
        [Enum(Real ADD,0,Safe MAX,4)] _BlendOp("Additional lights blending", Int) = 0
        _shadowCastMin_black("Dynamic Shadow Removal",Range(0.0,1.0)) = 0.65
        [NoScaleOffset] _DynamicShadowMask("Dynamic Shadow mask",2D)         = "black" {}
        [ToggleUI] _shadowUseCustomRampNDL("_shadowUseCustomRampNDL",Int) = 0
        _shadowNDLStep("_shadowNDLStep",Range(0,1)) = 1
        _shadowNDLFeather("_shadowNDLFeather",Range(0,1)) = 0.5
        _shadowMaskPinch("_shadowMaskPinch",Range(0,.9)) = 0
        [IntRange] _shadowSplits("_shadowMaskPinch",Range(0,10)) = 0
        _shadeShadowOffset1("_shadeShadowOffset1",Range(0,1)) = 0
        _shadeShadowOffset2("_shadeShadowOffset2",Range(0,1)) = 0

        // [Header(Light Map Shift Masks)]
        [Enum(Off,0,On,1,Use Vertex Color Red,2)] _UseLightMap("Light Map mode", Int)   = 0
        _LightMap("Light map mask (G)", 2D)                                             = "linearGrey" {}
        _lightMap_remapArr("--Range: (Z):LOW, (W):HIGH", Vector)                        = (-1,-1,0,1)
        // _lightMapCenter("--Mask pivot",Range(-0.5, 0.5))                             = 0
        _toonLambAry_01("----forward regraph: (X)C1+(Y) | (Z)C2+(W)", Vector)           = (1.2, -0.1, -1, -1)
        _toonLambAry_02("----back regraph: (X)C1+(Y) | (Z)C2+(W)", Vector)              = (2.0, 0.1, -1, -1)
        [NoScaleOffset] _Set_1st_ShadePosition("Forward Toon Shadows (G)", 2D)          = "white" {}
        [NoScaleOffset] _Set_2nd_ShadePosition("Backward Toon Shadow (G)", 2D)          = "white" {}
        
        // [Header(Ambient Occlusion Maps)]
        _Set_HighColorMask("Specular Mask (G)", 2D)                     = "white" {}
        _Tweak_HighColorMaskLevel("--Tweak Mask", Range(-1, 1))         = 0
        _Set_RimLightMask("RimLight Mask (G)", 2D)                      = "white" {}
        _Tweak_RimLightMaskLevel("--Tweak Mask", Range(-1, 1))          = 0

        // [Header(Normal map)]
        [Normal] _NormalMap("NormalMap", 2D)                                 = "bump" {}
        _DetailNormalMapScale01("--Detail scale", Range(0,1))       = 0
        [Normal] _NormalMapDetail("----Detail Normal map", 2d)               = "bump" {}
        _DetailNormalMask("----Detail Mask (G)", 2d)                = "white" {}
        [ToggleUI] _Is_NormalMapToBase ("On Toon",Int)             = 1
        [ToggleUI] _Is_NormalMapToHighColor("On High Color",Int)   = 1
        [ToggleUI] _Is_NormalMapToRimLight("On Rims",Int)          = 1
        [ToggleUI] _Is_NormaMapToEnv("On Reflection",Int)          = 1
        // detail masks
        _DetailMap("_DetailMap",2D) = "linearGrey" {}
        _DetailMask("_DetailMask",2D) = "white" {}
        _DetailAlbedo("_DetailAlbedo", Range(0, 1)) = 0
        _DetailSmoothness("_DetailSmoothness", Range(0, 1)) = 0
        // uv sets
        [Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _uvSet_ShadePosition("_uvSet_ShadePosition", int) = 0
        [Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _uvSet_LightMap("_uvSet_LightMap", int) = 0
        [Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _uvSet_NormalMapDetail("_uvSet_NormalMapDetail", int) = 0
        [Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _uvSet_NormalMapForMatCap("_uvSet_NormalMapForMatCap", int) = 0
        [Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _uvSet_DetailMap("_uvSet_DetailMap", int) = 0
        [Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _uvSet_EmissionColorTex("_uvSet_EmissionColorTex", int) = 0
        // [Header(Alpha mask)]
        // [Space(18)]
        // [Enum(Off,0,On,1)] _ZWrite("Z Write Depth sorting (Recommend off)",Int)     = 1
        [Enum(Clipping Mask,0,Main Texture,1)] _IsBaseMapAlphaAsClippingMask("Alpha mask source",Int)   = 1
        _ClippingMask("--Clipping mask (G)",2D)                                     = "white" {}
        [ToggleUI] _Inverse_Clipping("Inverse clipping", Float )                   = 0
        _Clipping_Level("Clipping level", Range(0, 1))                              = 0.5
        _Tweak_transparency("--Tweak transparency", Range(-1, 1))                   = 0
        // [Space(18)]
        // [ToggleUI] _UseSpecAlpha("Use specular Alpha",Float)                       = 0
        [ToggleUI] _DetachShadowClipping("Separate Shadow Clipping Level",Int)     = 0
        _Clipping_Level_Shadow("--Shadow Clip", Range(0, 1))                        = 1
        // [Header(Stencil Helpers. Requires Queue Order Edits)]
        _Stencil("Stencil ID [0;255]", Range(0,255))                                        = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp("--Comparison", Int)     = 0
        [Enum(UnityEngine.Rendering.StencilOp)] _StencilOp("--Pass", Int)                   = 0
        [Enum(UnityEngine.Rendering.StencilOp)] _StencilFail("--Fail", Int)                 = 0
    }






    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }



        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One Zero
            Cull[_CullMode]
            ZWrite on

            Stencil
            {
                Ref [_Stencil]
                Comp [_StencilComp]
                Pass [_StencilOp]
                Fail [_StencilFail]
            }
            
            CGPROGRAM
            #pragma target 5.0
            #pragma vertex vert
            // #pragma geometry geom
            #pragma fragment frag
            #pragma multi_compile_fwdbase
            #pragma multi_compile_instancing
            #pragma multi_compile_fog
            #pragma multi_compile UNITY_PASS_FORWARDBASE
            // #pragma multi_compile _ UNITY_HDR_ON
            #include "ACLS_CORE.cginc"
            ENDCG
        }



        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            BlendOp[_BlendOp]
            Cull[_CullMode]
            ZWrite off

            Stencil
            {
                Ref [_Stencil]
                Comp [_StencilComp]
                Pass [_StencilOp]
                Fail [_StencilFail]
            }
            
            CGPROGRAM
            #pragma target 5.0
            #pragma vertex vert
            // #pragma geometry geom
            #pragma fragment frag
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_instancing
            #pragma multi_compile_fog
            #pragma multi_compile UNITY_PASS_FORWARDADD
            // #pragma multi_compile _ UNITY_HDR_ON
            #include "ACLS_CORE.cginc"
            ENDCG
        }



        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1 ,1
            Cull [_CullMode]
            ZWrite On ZTest LEqual
            
            CGPROGRAM
            #pragma target 5.0
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_instancing
            #include "ACLS_SHADOWCASTER.cginc"
            ENDCG
        }
    }
    FallBack "Legacy Shaders/VertexLit"
    CustomEditor "ACLSInspector"
}
