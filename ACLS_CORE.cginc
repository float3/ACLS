//// ACiiL
//// Citations in readme and in source.
//// https://github.com/ACIIL/ACLS-Shader
#ifndef ACLS_CORE
#define ACLS_CORE
            ////
            #include "./ACLS_HELPERS.cginc"
#ifdef DepthDataContext
            UNITY_DECLARE_SCREENSPACE_TEXTURE(_BackDepthTexture);
            // sampler2D _BackDepthTexture;
#endif // DepthDataContext

            ////
            Texture2D _ClippingMask;    uniform float4 _ClippingMask_ST;

            Texture2D _NormalMap;       uniform float4 _NormalMap_ST;
            
            Texture2D _MainTex;         uniform float4 _MainTex_ST;
            Texture2D _1st_ShadeMap;    uniform float4 _1st_ShadeMap_ST;
            Texture2D _2nd_ShadeMap;    uniform float4 _2nd_ShadeMap_ST;

            Texture2D _Set_1st_ShadePosition;   uniform float4 _Set_1st_ShadePosition_ST;
            Texture2D _Set_2nd_ShadePosition;   uniform float4 _Set_2nd_ShadePosition_ST;
            Texture2D _LightMap;                uniform float4 _LightMap_ST;

            Texture2D _crossOverMask;       uniform float4 _crossOverMask_ST;
            Texture2D _crossOverAlbedo;     uniform float4 _crossOverAlbedo_ST;

            Texture2D _HighColor_Tex;       uniform float4 _HighColor_Tex_ST;
            Texture2D _Set_HighColorMask;   uniform float4 _Set_HighColorMask_ST;

            Texture2D _MetallicGlossMap;    uniform float4 _MetallicGlossMap_ST;
            Texture2D _SpecGlossMap;        uniform float4 _SpecGlossMap_ST;

            Texture2D _GlossinessMap;       uniform float4 _GlossinessMap_ST;

            Texture2D _SSSThicknessMask;    uniform float4 _SSSThicknessMask_ST;
            
            Texture2D _Set_RimLightMask;    uniform float4 _Set_RimLightMask_ST;
            
            Texture2D _MatCapTexAdd;        uniform float4 _MatCapTexAdd_ST;
            Texture2D _MatCapTexMult;       uniform float4 _MatCapTexMult_ST;
            Texture2D _MatCapTexEmis;       uniform float4 _MatCapTexEmis_ST;
            Texture2D _MatCapTexHardMult;   uniform float4 _MatCapTexHardMult_ST;
            Texture2D _NormalMapForMatCap;  uniform float4 _NormalMapForMatCap_ST;
            Texture2D _Set_MatcapMask;      uniform float4 _Set_MatcapMask_ST;

            Texture2D _Emissive_Tex;        uniform float4 _Emissive_Tex_ST;
            Texture2D _EmissionColorTex;    uniform float4 _EmissionColorTex_ST;
            Texture2D _EmissionColorTex2;   uniform float4 _EmissionColorTex2_ST;
            
            TextureCube _CubemapFallback; uniform float4 _CubemapFallback_HDR;

            Texture2D _DetailMap;   uniform float4 _DetailMap_ST;
            Texture2D _DetailMask;  uniform float4 _DetailMask_ST;

            Texture2D _NormalMapDetail; uniform float4 _NormalMapDetail_ST;
            Texture2D _DetailNormalMask; uniform float4 _DetailNormalMask_ST;

            Texture2D _DynamicShadowMask; uniform float4 _DynamicShadowMask_ST; uniform float4 _DynamicShadowMask_TexelSize;

            sampler3D _DitherMaskLOD;

            //// sample sets: normals, albedo(shades/masks), AOs, matcap, emissionTex
            SamplerState sampler_MainTex;
            SamplerState sampler_ClippingMask;
            SamplerState sampler_Set_1st_ShadePosition;
            SamplerState sampler_NormalMap;
            SamplerState sampler_MatCap_Trilinear_clamp;
            SamplerState sampler_EmissionColorTex;
            SamplerState sampler_EmissionColorTex2;
            SamplerState sampler_Emissive_Tex;
            SamplerState sampler_DetailMap;
            SamplerState sampler_CubemapFallback;
            // SamplerState sampler_MainTex_trilinear_repeat;
            // SamplerState sampler_Set_1st_ShadePosition_trilinear_repeat;
            // SamplerState sampler_NormalMap_trilinear_repeat;
            // SamplerState sampler_MatCap_Trilinear_clamp;
            // SamplerState sampler_EmissionColorTex_trilinear_repeat;
            // SamplerState sampler_DetailMap_trilinear_repeat;
            // SamplerState sampler_CubemapFallback_trilinear_clamp;

            //// alpha
            uniform half _Clipping_Level;
            uniform half _Tweak_transparency;
            uniform int _Inverse_Clipping;
            uniform int _IsBaseMapAlphaAsClippingMask;
            uniform int _UseSpecAlpha;
            //// diffuse, toon ramp
            uniform int _useToonRampSystem;
            uniform float4 _Color;
            uniform float4 _0_ShadeColor;
            uniform float4 _1st_ShadeColor;
            uniform float4 _2nd_ShadeColor;
            uniform int _Use_BaseAs1st;
            uniform int _Use_1stAs2nd;
            uniform half _BaseColor_Step;
            uniform half _ShadeColor_Step;
            uniform half _BaseShade_Feather;
            uniform half _1st2nd_Shades_Feather;
            uniform int _Diff_GSF_01;
            uniform float _DiffGSF_Offset;
            uniform float _DiffGSF_Feather;
            uniform int _useCrossOverRim;
            uniform half _crossOverPinch;
            uniform half _crossOverStep;
            uniform half _crossOverFeather;
            uniform half _crosspOverRimPow;
            uniform float4 _crossOverTint;
            uniform int _crossOverSourceTexSource;
            uniform float4 _lightMap_remapArr;
            uniform int _UseLightMap;
            uniform float4 _toonLambAry_01;
            uniform float4 _toonLambAry_02;
            uniform int _useDiffuseAlbedoTexturesSet;
            uniform int _toonRampTexturesBlendMode;
            //// spec
            uniform int _UseSpecularSystem;
            uniform int _WorkflowMode;
            uniform int _SpecOverride;
            uniform float4 _HighColor;
            uniform half _highColTexSource;
            uniform float4 _SpecularMaskHSV;
            uniform half _Tweak_HighColorMaskLevel;
            uniform half _HighColor_Power;
            uniform int _UseDiffuseEnergyConservation;
            uniform int _Is_SpecularToHighColor;
            uniform half _TweakHighColorOnShadow;
            uniform float _Metallicness;
            uniform float _Glossiness;
            uniform float _Anisotropic;
            //// rim light
            uniform int _useRimLightSystem;
            uniform float4 _RimLightColor;
            uniform float4 _Ap_RimLightColor;
            uniform half _Tweak_RimLightMaskLevel;
            uniform int _RimLight;
            uniform int _Add_Antipodean_RimLight;
            uniform int _RimLightSource;
            uniform half _RimLightMixMode;
            uniform int _LightDirection_MaskOn;
            uniform half _RimLightAreaOffset;
            uniform half _RimLight_Power;
            uniform half _Ap_RimLight_Power;
            uniform half _RimLight_InsideMask;
            uniform half _Tweak_LightDirection_MaskLevel;
            uniform int _EnvGrazeMix;
            uniform int _EnvGrazeRimMix;
            uniform float _rimAlbedoMix;
            uniform half _rimLightLightsourceType;
            uniform half _envOnRim;
            uniform float _envOnRimColorize;
            uniform int _useRimLightOverTone;
            uniform half _rimLightOverToneLow;
            uniform half _rimLightOverToneHigh;
            uniform half4 _rimLightOverToneBlendColor1;
            uniform half4 _rimLightOverToneBlendColor2;
            //// matcap
            uniform float4 _MatCapColAdd;
            uniform float4 _MatCapColMult;
            uniform float4 _MatCapColEmis;
            uniform float4 _MatCapColHardMult;
            uniform half _Is_NormalMapForMatCap;
            uniform int _MatCap;
            uniform half _Is_BlendAddToMatCap;
            uniform half _Tweak_MatCapUV;
            uniform half _Rotate_MatCapUV;
            uniform half _Rotate_NormalMapForMatCapUV;
            uniform half _Is_UseTweakMatCapOnShadow;
            uniform half _TweakMatCapOnShadow;
            uniform half _Tweak_MatcapMaskLevel;
            uniform int _matcapSmoothnessSource0;
            uniform int _matcapSmoothnessSource1;
            uniform int _matcapSmoothnessSource2;
            uniform int _matcapSmoothnessSource3;
            uniform half _BlurLevelMatcap0;
            uniform half _BlurLevelMatcap1;
            uniform half _BlurLevelMatcap2;
            uniform half _BlurLevelMatcap3;
            uniform int _CameraRolling_Stabilizer;
            uniform int _useMCHardMult;
            uniform half _McDiffAlbedoMix;
            uniform int _matcapSpecMaskSwitch;
            uniform int _matcapEmissMaskSwitch;
            //// emission
            uniform int _emissionUseMask;
            uniform int _emissionUseMaskDiffuseDimming;
            uniform float4 _Emissive_Color;
            uniform float4 _Emissive_Color2;
            uniform half _emissionProportionalLum;
            uniform int _emissiveUseMainTexA;
            uniform int _emisLightSourceType;
            uniform half _emissionMixTintDiffuseSlider;
            uniform int _emissionUse2ndTintRim;
            uniform half _emission2ndTintLow;
            uniform half _emission2ndTintHigh;
            uniform half _emission2ndTintPow;
            //// depth
            uniform half _depthMaxScale;
            //// sss
            uniform int _useSSS;
            uniform int _useFakeSSS;
            uniform int _useRealSSS;
            uniform half _SSSDensityReal;
            uniform half _SSSRim;
            uniform half _SSSLensFake;
            uniform half _SSSDensityFake;
            uniform half _SSSLens;
            uniform half _SSSDepthColL;
            uniform half _SSSDepthColH;
            uniform half3 _SSSColThin;
            uniform half3 _SSSColThick;
            uniform half3 _SSSColRim;
            uniform half _SSSRimMaskL;
            uniform half _SSSRimMaskH;
            //// normalmap
            uniform int _Is_NormalMapToBase;
            uniform int _Is_NormalMapToHighColor;
            uniform int _Is_NormalMapToRimLight;
            uniform int _Is_NormaMapToEnv;
            uniform int _Is_NormaMapEnv;
            uniform float _DetailNormalMapScale01;
            //// general lighting
            uniform float3 _backFaceColorTint;
            uniform half _shadowCastMin_black;
            uniform half _shadeShadowOffset1;
            uniform half _shadeShadowOffset2;
            uniform half _Is_UseTweakHighColorOnShadow;
            uniform half _Tweak_SystemShadowsLevel;
            uniform int _shadowUseCustomRampNDL;
            uniform half _shadowNDLStep;
            uniform half _shadowNDLFeather;
            uniform half _shadowMaskPinch;
            uniform int _shadowSplits;
            uniform int _ToonRampLightSourceType_Backwards;
            uniform half _diffuseIndirectDirectSimMix;
            uniform int _forceLightClamp;
            uniform float _directLightIntensity;
            uniform half _indirectAlbedoMaxAveScale;
            uniform half _indirectGIDirectionalMix;
            uniform half _indirectGIBlur;
            uniform int _useAlbedoTexModding;
            uniform half4 _controllerAlbedoHSVI_1;
            uniform half4 _controllerAlbedoHSVI_2;
            uniform half4 _controllerAlbedoHSVI_3;
            //// reflection
            uniform int _useCubeMap;
            uniform int _GlossinessMapMode;
            uniform int _ENVMmode;
            uniform half _ENVMix;
            uniform half _envRoughness; //// envSmoothness
            uniform int _CubemapFallbackMode;
            //// detail
            uniform half _DetailAlbedo;
            uniform half _DetailSmoothness;
            //// uv sets
            uniform int _uvSet_ShadePosition;
            uniform int _uvSet_LightMap;
            uniform int _uvSet_NormalMapDetail;
            uniform int _uvSet_NormalMapForMatCap;
            uniform int _uvSet_DetailMap;
            uniform int _uvSet_EmissionColorTex;







//// vert            
            g2f vert (appdata v) 
            {
                UNITY_SETUP_INSTANCE_ID(v);
                v2g o;
                // g2f o  = (g2f)0;
                UNITY_INITIALIZE_OUTPUT(v2g, o);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                AdaptorDPS(v);
                o.pos           = UnityObjectToClipPos(v.vertex);
                o.uv01          = float4(v.uv0.xy, v.uv1.xy);
                o.uv02          = float4(v.uv2.xy, v.uv3.xy);
                o.worldPos      = mul( unity_ObjectToWorld, v.vertex);
                o.center        = mul( unity_ObjectToWorld, float4(0,0,0,1));
                o.wNormal       = UnityObjectToWorldNormal( v.normal);
                o.tangent       = ( float4(UnityObjectToWorldDir(v.tangent.xyz), v.tangent.w));
                o.biTangent    = ( cross( o.wNormal, o.tangent.xyz ) * v.tangent.w);
                o.screenPos     = ComputeScreenPos(o.pos);
                o.color         = v.color;
#ifdef DepthDataContext
                o.grabPos = ComputeGrabScreenPos(o.pos);
#endif // DepthDataContext

                // TRANSFER_VERTEX_TO_FRAGMENT(o);
                UNITY_TRANSFER_SHADOW(o, 0);  // o.uv1 used for lightmap variants (dont exist)
                UNITY_TRANSFER_FOG(o, o.pos);

#ifdef VERTEXLIGHT_ON
                o.vertexLighting    = softShade4PointLights_Atten(
                    unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0
                    , unity_LightColor
                    , unity_4LightAtten0
                    , o.worldPos, o.wNormal, o.vertTo0);
#endif                    
#ifdef UNITY_PASS_FORWARDBASE
                o.dirGI       = GIDominantDir();
#endif
                return o;
            }

//// geom 
            //// cite:
            //// https://forum.unity.com/threads/is-it-possible-to-have-gpu-instancing-with-geometry-shader.898070/
            //// Cubed shader
            [maxvertexcount(3)]
            void geom(triangle v2g i[3],
                inout TriangleStream<g2f> tristream)
            {
                for (int v = 0; v < 3; v++)
                {
                    UNITY_SETUP_INSTANCE_ID(i[v]);
                    g2f o;
                    UNITY_INITIALIZE_OUTPUT(g2f, o);
                    UNITY_TRANSFER_INSTANCE_ID(i[v], o);
                    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                    
                    o.pos           = i[v].pos;
                    o.color         = i[v].color;
                    o.center        = i[v].center;
                    o.worldPos      = i[v].worldPos;

                    float3 worldviewPos     = StereoWorldViewPos();
                    float3 posDiff          = worldviewPos - i[v].worldPos.xyz;
                    float3 dirView          = normalize(posDiff);
                    float3 wNormalHard = normalize(cross(i[0].worldPos-i[1].worldPos, i[0].worldPos-i[2].worldPos));
                    float3 realNormal = i[v].wNormal;
                    float sign = 1;
                    if (dot(dirView, wNormalHard) < 0 ){ /// lazy backface check
                        sign = -sign;
                    }
                    o.wNormal       = lerp(wNormalHard, i[v].wNormal, saturate(saturate(dot(dirView, sign*realNormal))*2.+.75));
                    // o.wNormal       = wNormalHard; 
                    // o.wNormal       = i[v].wNormal;
                    // o.wNormal       = lerp( i[v].wNormal, lerp(wNormalHard, i[v].wNormal, saturate(dot(dirView, i[v].wNormal)+.75)), sin(_Time.y*3.15)*.5+.5);
                    ////
                    o.tangent       = i[v].tangent;
                    o.biTangent     = i[v].biTangent;
                    o.vertexLighting    = i[v].vertexLighting;
                    o.dirGI         = i[v].dirGI;
                    o.uv01          = i[v].uv01;
                    o.screenPos     = i[v].screenPos;
                    o.vertTo0       = i[v].vertTo0;
#ifdef DepthDataContext
                    o.grabPos       = i[v].grabPos;
#endif // DepthDataContext
                    UNITY_TRANSFER_SHADOW(o, 0);
                    UNITY_TRANSFER_FOG(o, o.pos);
                    
                    tristream.Append(o);
                }
                tristream.RestartStrip();
            }









//// frag
            float4 frag(
                // v2g i
                g2f i
                , bool frontFace : SV_IsFrontFace 
#ifdef UseAlphaDither //// cutout mode. dont use premultiplay block
                , out uint cov : SV_Coverage
#endif //// UseAlphaDither
            ) : SV_TARGET 
            {
                UNITY_SETUP_INSTANCE_ID(i);
                bool isAmbientOnlyMap   = !(any(_LightColor0.rgb));
                bool isBackFace         = !frontFace;
                bool isMirror           = IsInMirror();
                i.wNormal               = normalize(i.wNormal);
                if(isBackFace) {
                    i.wNormal = -i.wNormal;
                }
                // float3 worldviewPos     = StereoWorldViewPos();
                float3 worldviewPos     = _WorldSpaceCameraPos;
                float3 posDiff          = worldviewPos - i.worldPos.xyz;
                float viewDis           = length(posDiff);
                float3 dirView;
                if (unity_OrthoParams.w)//// mirror camera (ERROR.MDL)
                {
                    dirView = UNITY_MATRIX_V[2].xyz;
                }
                else
                {
                    dirView = normalize(posDiff);
                }
                //// screen pos
                float4 screenPos        = i.screenPos;
                float4 screenUV         = screenPos / (screenPos.w + 0.00001);
            #ifdef UNITY_SINGLE_PASS_STEREO
                screenUV.xy             *= float2(_ScreenParams.x * 2, _ScreenParams.y);
            #else
                screenUV.xy             *= _ScreenParams.xy;
            #endif
#ifdef DepthDataContext
                float frontDepth    = distance(i.worldPos.xyz, worldCameraRawMatrix().xyz);
                float4 depthMap     = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_BackDepthTexture, i.grabPos.xy/i.grabPos.w);
                float backDepth     = depthMap.r;
                float volDepth      = min(1.0, (backDepth - frontDepth) / (1. + _depthMaxScale));
                volDepth            *= dot(dirView, UNITY_MATRIX_V[2].xyz); //// (Slerpy) screen edge depth correction
#else
                float4 depthMap     = 1.0;
                float volDepth      = 1.0;
#endif // DepthDataContext
                //// helper vars
                half mip,testw,testw2,testh,lodMax;
                mip = testw = testw2 = testh = lodMax = 0;
                
                

//// normal map
                UV_DD uv_normalMap              = UVDD(TRANSFORM_TEX( UVPick01(i.uv01, i.uv02), _NormalMap));
                UV_DD uv_normalMapDetail        = UVDD(TRANSFORM_TEX( UVPick01(i.uv01, i.uv02, _uvSet_NormalMapDetail), _NormalMapDetail));
                UV_DD uv_normalMapDetailMask    = UVDD(TRANSFORM_TEX( UVPick01(i.uv01, i.uv02), _DetailNormalMask));
                float3 normalMap            = UnpackNormal( _NormalMap.SampleGrad( sampler_NormalMap, uv_normalMap.uv, uv_normalMap.dx, uv_normalMap.dy));
                if (_DetailNormalMapScale01)  //// slider > 0
                {
                    float4 normalDetailMask = _DetailNormalMask.SampleGrad( sampler_MainTex, uv_normalMapDetailMask.uv, uv_normalMapDetailMask.dx, uv_normalMapDetailMask.dy);
                    float3 normalMapDetail  = UnpackNormal( _NormalMapDetail.SampleGrad( sampler_NormalMap, uv_normalMapDetail.uv, uv_normalMapDetail.dx, uv_normalMapDetail.dy));
                    normalMap               = lerp( normalMap, BlendNormals(normalMap, normalMapDetail), (normalDetailMask.g * _DetailNormalMapScale01));
                }
                float3 dirTangent   = i.tangent.xyz;
                float3 dirBitangent = i.biTangent.xyz;
                float3x3 tangentTransform   = float3x3(dirTangent, dirBitangent, i.wNormal);
                float3 dirNormal            = normalize( mul( normalMap, tangentTransform ));
                dirTangent          = normalize(dirTangent);
                dirBitangent        = normalize(dirBitangent);

//// albedo texure
                UV_DD uv_toon           = UVDD( TRANSFORM_TEX( UVPick01(i.uv01, i.uv02), _MainTex));
                float4 mainTex          = _MainTex.SampleGrad( sampler_MainTex, uv_toon.uv, uv_toon.dx, uv_toon.dy);

//// detail textures
                UV_DD uv_detalAlbedo    = UVDD( TRANSFORM_TEX( UVPick01(i.uv01, i.uv02, _uvSet_DetailMap), _DetailMap));
                half4 detailMap         = SetupDetail( _DetailMap.SampleGrad( sampler_DetailMap, uv_detalAlbedo.uv, uv_detalAlbedo.dx, uv_detalAlbedo.dy));///R albedo, B smoothness
                half4 detailMask         = _DetailMask.SampleGrad( sampler_MainTex, uv_toon.uv, uv_toon.dx, uv_toon.dy);

//// clip & alpha handling. Here so clip() may interrupt flow.
#ifndef NotAlpha
                float4 clipMask          = _ClippingMask.Sample(sampler_ClippingMask, TRANSFORM_TEX( UVPick01(i.uv01, i.uv02), _ClippingMask));
                float useMainTexAlpha   = (_IsBaseMapAlphaAsClippingMask) ? mainTex.a : clipMask.r;
                float alpha             = (_Inverse_Clipping) ? (1.0 - useMainTexAlpha) : useMainTexAlpha;

                float clipTest          = (alpha - _Clipping_Level);
                clip(clipTest);

    #ifndef IsClip
                alpha           = saturate(alpha + _Tweak_transparency);
        #ifdef UseAlphaDither
                uint sampleCount = GetRenderTargetSampleCount();
                // dither pattern with some a2c blending.
                //// Custom Alpha-to-coverage by Dj Lukis.LT. Impliments manual coverage mask for MSAA
                //// https://github.com/lukis101/VRCUnityStuffs/blob/master/Shaders/DJL/A2C-Custom.shader
                //// http://developer.amd.com/wordpress/media/2012/10/GDC11_DX11inBF3.pdf
                //// https://forum.unity.com/threads/stochastic-transparency.831115/ (praise Bglous)
                //// Silent and Xiexe.
                float dither    = ScreenDitherToAlphaCutout_ac(screenUV.xy);
                alpha           = (alpha * sampleCount) + 1. - dither; //// define exact floats, not doing so miss-interrupts (uint) conversion.
                cov             = (1u << (uint)(alpha)) - 1u; //// fill bitmask to covered count
                alpha           = 1;
        #endif //// UseAlphaDither
                alpha           = saturate(alpha);
    #else //// IsClip
                alpha           = 1;
    #endif //// IsClip
#else //// NotAlpha
                float alpha     = 1;
#endif //// NotAlpha


//// toon shade manual paint textures
                float4 coreAlbedoTex        = _1st_ShadeMap.SampleGrad(sampler_MainTex, uv_toon.uv, uv_toon.dx, uv_toon.dy);
                float4 backwardAlbedoTex    = _2nd_ShadeMap.SampleGrad(sampler_MainTex, uv_toon.uv, uv_toon.dx, uv_toon.dy);
                //// assign manual albedo ramp colors by textures
                float4 shadeAlbedoTex1 = mainTex;
                float4 shadeAlbedoTex2 = mainTex;
                float4 shadeAlbedoTex3 = mainTex;
                UNITY_BRANCH
                if (_useDiffuseAlbedoTexturesSet) //// _useDiffuseAlbedoTexturesSet
                {
                    UNITY_BRANCH
                    switch (_Use_BaseAs1st){
                        default:
                        case 0: shadeAlbedoTex2 = coreAlbedoTex; break;
                        case 1: shadeAlbedoTex2 = mainTex; break;
                        case 2: shadeAlbedoTex2 = backwardAlbedoTex; break;
                    }
                    UNITY_BRANCH
                    switch (_Use_1stAs2nd){
                        default:
                        case 0: shadeAlbedoTex3 = backwardAlbedoTex; break;
                        case 1: shadeAlbedoTex3 = coreAlbedoTex; break;
                        case 2: shadeAlbedoTex3 = mainTex; break;
                    }
                }
                //// manipulate albedo textures HSVI
                if (_useAlbedoTexModding){
                    shadeAlbedoTex1.rgb = HSVI_controller(shadeAlbedoTex1.rgb, _controllerAlbedoHSVI_1).rgb;
                    shadeAlbedoTex2.rgb = HSVI_controller(shadeAlbedoTex2.rgb, _controllerAlbedoHSVI_2).rgb;
                    shadeAlbedoTex3.rgb = HSVI_controller(shadeAlbedoTex3.rgb, _controllerAlbedoHSVI_3).rgb;
                }



//// early light dir pass. Had a use.
#ifdef UNITY_PASS_FORWARDBASE
                float3 dirLight   = _WorldSpaceLightPos0.xyz;
#elif UNITY_PASS_FORWARDADD
                float3 dirLight   = normalize( lerp( _WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.worldPos.xyz, _WorldSpaceLightPos0.w));
#endif

//// main light direction with weighted factors of light types
#ifdef UNITY_PASS_FORWARDBASE
                float3 viewLightDirection   = normalize( UNITY_MATRIX_V[2].xyz + UNITY_MATRIX_V[1].xyz); // [1] = camera y upward, [2] = camera z forward
                //// experiment for weighted angles.
                // dirLight                    = dot(1, lightDirect) * _WorldSpaceLightPos0.xyz + dot(1, lightIndirectColAve) * (i.dirGI)  + dot(1, vertexLit) * (i.vertTo0) + (.0001 * viewLightDirection);
                dirLight                    = 100*(_WorldSpaceLightPos0.xyz) + .01*(i.dirGI) + (i.vertTo0) + .0001*(viewLightDirection);
                dirLight                    = normalize(dirLight);
                // return float4(((.5*dot(dirLight, i.wNormal)+.5)).xxx, 1);
#elif UNITY_PASS_FORWARDADD
#endif
                if (isBackFace) //// treat backfaces towards light
                {
                    dirLight    = -dirLight;
                }



//// dot() set. Organized extensive input values per effect, per normal map
                ////
                float3 dirNormalToonRamp        = _Is_NormalMapToBase       ? dirNormal : i.wNormal;
                float3 dirNormalSpecular        = _Is_NormalMapToHighColor  ? dirNormal : i.wNormal;
                float3 dirNormalEnv             = _Is_NormaMapToEnv         ? dirNormal : i.wNormal;
                float3 dirNormalRimLight        = _Is_NormalMapToRimLight   ? dirNormal : i.wNormal;
                float3 dirHalf                  = normalize(dirLight + dirView);
                float ldh_Norm_Full             = dot(dirLight, dirHalf);
                float ldh_Norm_Cap              = saturate(ldh_Norm_Full);
                float vdh_Norm_Full             = dot(dirView, dirHalf);
                //// normal toon
                struct Dot_Diff { float ndl; float ndv; float ldhS; float ldh;};
                Dot_Diff dDiff;
                dDiff.ndl   = dot(dirNormalToonRamp, dirLight)*.5+.5;
                dDiff.ndv   = dot(dirNormalToonRamp, dirView);
                dDiff.ldhS  = ldh_Norm_Full*.5+.5;
                // dDiff.ldh   = saturate(ldh_Norm_Full);
                //// normal spec
                struct Dot_Spec { float ndhS; float ndh; float ndlS; float ndl; float ndv; float vdh; float ldh;};
                float spec_ndh  = dot(dirNormalSpecular, dirHalf);
                float spec_ndl  = dot(dirNormalSpecular, dirLight);
                Dot_Spec dSpec;
                dSpec.ndhS      = spec_ndh *.5+.5;
                dSpec.ndh       = saturate(spec_ndh);
                dSpec.ndlS      = spec_ndl *.5+.5;
                dSpec.ndl       = saturate(spec_ndl);
                dSpec.ndv       = saturate(dot(dirNormalSpecular, dirView));
                dSpec.vdh       = saturate(vdh_Norm_Full);
                dSpec.ldh       = ldh_Norm_Cap;
                //// normal env
                struct Dot_Env {float ndv; float ldh; float3 dirViewReflection;};
                Dot_Env dEnv;
                dEnv.ndv                = saturate(dot(dirNormalEnv, dirView));
                dEnv.ldh                = ldh_Norm_Cap;
                dEnv.dirViewReflection  = reflect(-dirView, dirNormalEnv);
                //// normal rimLight
                struct Dot_RimLight {float ndv; float ndlS;};
                Dot_RimLight dRimLight;
                dRimLight.ndv   =  ( dot(dirNormalRimLight, dirView) + (.5*smoothstep(.1, 0, viewDis)));//// needs [-1,1]
                dRimLight.ndlS  = dot(dirNormalRimLight, dirLight)*.5+.5;
                //// emission
                struct Dot_Emission {float ndv;};
                Dot_Emission dEmiss;
                dEmiss.ndv      = dot(i.wNormal, dirView);

                //// aniso support. Observe [-1..1]
                // float hdx_Norm_full = (dot(dirHalf,  dirTangent));
                // float hdy_Norm_full = (dot(dirHalf,  dirBitangent));



//// Light attenuation (falloff and shadows), used for mixing in shadows and effects that react to shadow
            //// experiment
            /*
                fixed shadowAttenuationRaw = 0;
            #if defined(SHADOWS_SCREEN)
                screenPos.xy        = screenPos.xy / screenPos.w;
                shadowAttenuationRaw  =(tex2Dlod(_ShadowMapTexture, float4(screenPos.xy, .5, 0)).r);
            
                // shadowAttenuationRaw   =
                //     ( tex2Dlod(_ShadowMapTexture, float4(0.25, 0.25, 0, 0.5)).r)
                //     + ( tex2Dlod(_ShadowMapTexture, float4(0.25, 0.75, 0, 0.5)).r)
                //     + ( tex2Dlod(_ShadowMapTexture, float4(0.5, 0.5, 0, 0.5)).r)
                //     + ( tex2Dlod(_ShadowMapTexture, float4(0.75, 0.25, 0, 0.5)).r)
                //     + ( tex2Dlod(_ShadowMapTexture, float4(0.75, 0.75, 0, 0.5)).r);
                // shadowAttenuationRaw   *= 0.2;
            #endif
                return float4(shadowAttenuationRaw.xxx,1);
            */
            #ifdef DIRECTIONAL
                //// directional lights handle UNITY_LIGHT_ATTENUATION() differently. I want to split attenuation and shadows, but both concepts fuse in directional lights
                UNITY_LIGHT_ATTENUATION_NOSHADOW(lightAtten, i, i.worldPos.xyz);
                if (isAmbientOnlyMap) /// lightAtten is undefined in scenes without directional lights. Using this raw is unstable so we correct when missing the shadow data.
                {
                    lightAtten = 1;
                }
                half shadowAtten = lightAtten;

            #else
                UNITY_LIGHT_ATTENUATION_NOSHADOW(lightAtten, i, i.worldPos.xyz);
                half shadowAtten = UNITY_SHADOW_ATTENUATION(i, i.worldPos.xyz);
            #endif
                shadowAtten = RemapRange(shadowAtten, max(0, _LightShadowData.x - .001), 1, 0, 1);//// floor shadow to 0.0, to normalize
                if (_shadowUseCustomRampNDL) //// nDl shadow
                {
                    half nDlSha = dot(dirNormalToonRamp, dirLight) *.5+.5;                    
                    nDlSha      = StepFeatherRemap(nDlSha, _shadowNDLStep, _shadowNDLFeather);
                    // shadowAtten = (shadowAtten * nDlSha);
                    shadowAtten = min(shadowAtten, nDlSha);
                }
                if (_shadowMaskPinch)
                {
                    shadowAtten = saturate(RemapRange(shadowAtten, 0, 1-_shadowMaskPinch,0,1));
                }
                if (_shadowSplits)
                {
                    shadowAtten = round(shadowAtten * _shadowSplits) / _shadowSplits; 
                }
                half shadowMaskNormalized = shadowAtten;
                
                //// setup shadow darkness control
                half shadowRemoval = 0;
                UNITY_BRANCH
                if ( (_shadowCastMin_black) || !(_DynamicShadowMask_TexelSize.z <16)) 
                {
                    half dynamicShadowMask = _DynamicShadowMask.SampleGrad(sampler_MainTex, uv_toon.uv, uv_toon.dx, uv_toon.dy).g;
                    shadowRemoval = max(_shadowCastMin_black, dynamicShadowMask);
                }
                shadowAtten = saturate(RemapRange(shadowAtten+shadowRemoval,0,1,_LightShadowData.x+.001,1));//// then return 0.0 to floor



//// collect scene light sources. sLight
#ifdef UNITY_PASS_FORWARDBASE
                //// prepare cubemap albedo support lighting
                half3 refGIcol  = shadeSH9LinearAndWhole(float4(normalize(i.wNormal + dEnv.dirViewReflection),1)); //// gi light at a weird angle
                half3 colGIGray = LinearRgbToLuminance_ac(refGIcol);
                //// get vertex lighting
                half3 vertexLit = i.vertexLighting;
                //// build indirect light source
                half3 lightIndirectColAve   = DecodeLightProbe_average();   //// L0 Average light
                half3 lightIndirectColL1    = max(0, SHEvalDirectL1(normalize(i.dirGI)));    //// L1 raw. Add to L0 as max color of GI
                half3 lightIndirectColStatic = 0, lightIndirectColDir = 0;
                ////
                half3 stackIndirectMaxL0L1 = lightIndirectColL1 + lightIndirectColAve;
                half ratioCols = RatioOfColors(stackIndirectMaxL0L1, lightIndirectColAve, _indirectAlbedoMaxAveScale);
                lightIndirectColStatic  = lerp(stackIndirectMaxL0L1, lightIndirectColAve, ratioCols);
                if (_indirectGIDirectionalMix > 0)
                {
                    float4 indirectGIDirectionBlur = float4(i.wNormal, (_indirectGIBlur) );
                    lightIndirectColDir = max(0, ShadeSH9_ac(indirectGIDirectionBlur)) / (indirectGIDirectionBlur.w);
                    // float3 lightIndirectColAngle = shadeSH9LinearAndWhole(float4(i.wNormal,1));  //// not blur adaptiable without intense math
                }
                half3 lightIndirectCol  = lerp(lightIndirectColStatic, lightIndirectColDir, _indirectGIDirectionalMix);

                //// build direct light source
                half3 lightDirect   = _LightColor0.rgb;
                half3 lightIndirectSource  = (lightIndirectCol);
                //// build direct light
                half3 lightDirectSource = 0;
                if (isAmbientOnlyMap) //// this setup sucks for preserving Direct light effects
                {
                    if (any(lightIndirectColL1)) //// L1 in pure ambient maps is black. Recover by spliting indirect energy.
                    {
                        lightDirectSource   = lightIndirectColL1;
                    }
                    else
                    {
                        lightDirectSource   = lightIndirectColAve * .2;
                        lightIndirectSource = lightIndirectColAve * .7;
                    }
                }
                else
                {
                    lightDirectSource = lightDirect;
                }
                lightDirectSource = (lightDirectSource + vertexLit * .2) * _directLightIntensity;
                lightIndirectSource += vertexLit * .7;
                // float3 lightDirectSource    = (mixColorsMaxAve(lightIndirectColL1, lightDirect) + vertexLit) * _directLightIntensity;

#elif UNITY_PASS_FORWARDADD
                float3 lightDirect      = _LightColor0.rgb;
                lightDirect             *= lightAtten;
                //// out light source by types
                float3 lightDirectSource    = lightDirect * _directLightIntensity;
                float3 lightIndirectSource  = 0;
#endif

//// simple light systems reused. slsys
                half3 lightSimpleSystem = (lightDirectSource * shadowAtten) + lightIndirectSource;
                lightDirect             = _LightColor0.rgb;
#ifdef UNITY_PASS_FORWARDBASE
                half3 cubeMapAveAlbedo  = ((lightDirect * _LightShadowData.x * .5) + lightDirect ) * .5 + lightIndirectSource;
                half lightAverageLum    = LinearRgbToLuminance_ac(cubeMapAveAlbedo);
#elif UNITY_PASS_FORWARDADD
                half3 cubeMapAveAlbedo  = ((lightDirect * _LightShadowData.x * .5) + lightDirect) * .5 * lightAtten;
                half lightAverageLum    = LinearRgbToLuminance_ac(cubeMapAveAlbedo);
#endif



//// toon ramp, prepare ramp masks
                //// Normalized values: 1 represents brighter, 0 darker
                //// toon ramp AO masks. These down ramp as to "force shadow"
                UV_DD uv_ShadePosition  = UVDD(TRANSFORM_TEX( UVPick01(i.uv01, i.uv02, _uvSet_ShadePosition), _MainTex));
                float shadowTex_1       = _Set_1st_ShadePosition.SampleGrad(sampler_Set_1st_ShadePosition, uv_ShadePosition.uv, uv_ShadePosition.dx, uv_ShadePosition.dy).g;
                float shadowTex_2       = _Set_2nd_ShadePosition.SampleGrad(sampler_Set_1st_ShadePosition, uv_ShadePosition.uv, uv_ShadePosition.dx, uv_ShadePosition.dy).g;
                //// Assist for shadow mask
                float shadeRamp_n1 = dDiff.ndl;//// ndl Core area
                float shadeRamp_n2 = dDiff.ndl;//// ndl Backward area
                //// light mask setup. N dol L modified by ****. 50% gray mean natural influence.
                float pivotOffset_1 = 0;
                float pivotOffset_2 = 0;
                float4 lightMask    = 0.5;
                half step_core      = _BaseColor_Step;
                half step_backward  = _ShadeColor_Step;
                half set_baseShade_Feather_     = _BaseShade_Feather;
                half set_1st2nd_Shades_Feather_ = _1st2nd_Shades_Feather;
                if (!(_useToonRampSystem)) //// remove toon ramp. Optimizer script will purge half the code.
                {
                    step_core = 0.0;
                    step_backward = 0.0;
                    set_baseShade_Feather_      = 1.0;
                    set_1st2nd_Shades_Feather_  = 1.0;
                }
                UNITY_BRANCH
                if (_UseLightMap)
                {
                    UV_DD uv_lightMap   = UVDD( TRANSFORM_TEX( UVPick01(i.uv01, i.uv02, _uvSet_LightMap), _LightMap));
                    lightMask           = _LightMap.SampleGrad( sampler_MainTex, uv_lightMap.uv, uv_lightMap.dx, uv_lightMap.dy);
                    lightMask.g         = saturate(RemapRange01(lightMask.g, _lightMap_remapArr[2], _lightMap_remapArr[3]));////[0,1]->[A,B]->clamp
                    //// enum mode 2. Use vertex color red
                    UNITY_BRANCH
                    if (_UseLightMap > 1) { //// use vertex color 
                        lightMask.g *= i.color.r;
                    }
                    //// bright side mix
                    float toonOffsetMask_1  = lightMask.g;
                    float2 AOmCalibrate_1   = (toonOffsetMask_1.xx * float2(_toonLambAry_01[0],_toonLambAry_01[0]) + float2(_toonLambAry_01[1],_toonLambAry_01[1]));
                    float AOmaskPivot_1     = (toonOffsetMask_1 < 0.5);
                    pivotOffset_1           = (AOmaskPivot_1) ? AOmCalibrate_1.x : AOmCalibrate_1.y;
                    //// dark side mix
                    float toonOffsetMask_2  = lightMask.g;
                    float2 AOmCalibrate_2   = (toonOffsetMask_2.xx * float2(_toonLambAry_02[0],_toonLambAry_02[0]) + float2(_toonLambAry_02[1],_toonLambAry_02[1]));
                    float AOmaskPivot_2     = (toonOffsetMask_2 < 0.5);
                    pivotOffset_2           = (AOmaskPivot_2) ? AOmCalibrate_2.x : AOmCalibrate_2.y;

                    shadeRamp_n1 = (pivotOffset_1 + shadeRamp_n1) * 0.5;
                    shadeRamp_n2 = (pivotOffset_2 + shadeRamp_n2) * 0.5;
                    step_core = step_backward = .5;////calibrate .5 Step
                }
                //// d.shadow shifting
                half dsMask = (1 - shadowMaskNormalized) * 2;
                shadeRamp_n1 -= (_shadeShadowOffset1 * dsMask);
                shadeRamp_n2 -= (_shadeShadowOffset2 * dsMask);

                shadeRamp_n1    = (shadeRamp_n1 - step_core + set_baseShade_Feather_);
                shadeRamp_n1    = shadowTex_1 * shadeRamp_n1 / (set_baseShade_Feather_);
                ////
                shadeRamp_n2    = (shadeRamp_n2 - step_backward + set_1st2nd_Shades_Feather_);
                shadeRamp_n2    = shadowTex_2 * shadeRamp_n2 / ( set_1st2nd_Shades_Feather_ );
                //// negate for color mixer
                shadeRamp_n1    = saturate(shadeRamp_n1);
                shadeRamp_n2    = saturate(shadeRamp_n2);





//// Diffusion. Albedo setup
                //// Albedo variable remap zone of pain.
                // get albedo samples
                half3 albedoCol_1;
                half3 albedoCol_2;
                half3 albedoCol_3;
                if (_toonRampTexturesBlendMode) //// toon ramp tint derive mode
                {   //// multiply
                    albedoCol_1     = shadeAlbedoTex1.rgb;
                    albedoCol_2     = shadeAlbedoTex1.rgb * shadeAlbedoTex2.rgb;
                    albedoCol_3     = shadeAlbedoTex1.rgb * shadeAlbedoTex3.rgb;
                } else
                {   //// replace
                    albedoCol_1     = shadeAlbedoTex1.rgb;
                    albedoCol_2     = shadeAlbedoTex2.rgb;
                    albedoCol_3     = shadeAlbedoTex3.rgb;
                }
                //
                half3 shadeCol_1    = _0_ShadeColor.rgb   * _Color.rgb;
                half3 shadeCol_2    = _1st_ShadeColor.rgb * _Color.rgb;
                half3 shadeCol_3    = _2nd_ShadeColor.rgb * _Color.rgb;



//// Diffusion. Ramp shading and surface albedo and light albedo mixer
                //// mix scene colors per region
                //// Normalized values:
                UNITY_BRANCH
                if (_ToonRampLightSourceType_Backwards) //// diffuse lighting: backface area is part of shadow thus indirect light only
                {
                    half3 lDSAdjest = lightDirectSource;
                    half3 lightDirectSim = (lDSAdjest * shadowAtten) + lightIndirectSource;
                    shadeCol_1 *= lightDirectSim;
                    shadeCol_2 *= lightDirectSim;
                    shadeCol_3 *= lerp(lightIndirectSource, lightDirectSim, _diffuseIndirectDirectSimMix);
                } else //// diffuse lighting: surface uses entire albedo
                {
                    half3 lDSAdjest = lightDirectSource;
                    half3 lightDirectSim = (lDSAdjest * shadowAtten) + lightIndirectSource;
                    shadeCol_1 *= lightDirectSim;
                    shadeCol_2 *= lightDirectSim;
                    shadeCol_3 *= lightDirectSim;
                }

                //// mix textures
                half3 toonMix_bright_albedo = lerp(albedoCol_2, albedoCol_1, shadeRamp_n1);
                half3 toonMix_dark_albedo   = lerp(albedoCol_3, albedoCol_2, shadeRamp_n2);
                //// mix ramp
                half3 toonMix_bright_tint    = lerp(shadeCol_2, shadeCol_1, shadeRamp_n1);
                half3 toonMix_dark_tint      = lerp(shadeCol_3, shadeCol_2, shadeRamp_n2);
                //// GSF effect. Light direction warps blending of front/core & core/backward areas.
                half pivotBlendSideShades = 0;
                UNITY_BRANCH
                if (_Diff_GSF_01)
                {
                    pivotBlendSideShades = GSF_Diff_ac(dDiff.ndl, saturate(dDiff.ndv), dDiff.ldhS);
                    pivotBlendSideShades = StepFeatherRemap(pivotBlendSideShades, _DiffGSF_Offset, _DiffGSF_Feather);
                }
                else
                {
                    pivotBlendSideShades = min(shadeRamp_n1, shadeRamp_n2);
                }
                //// complete diffuse mix
                half3 shadeColor_albedo = lerp(toonMix_dark_albedo, toonMix_bright_albedo, pivotBlendSideShades);//// textures
                half3 shadeColor_tint   = lerp(toonMix_dark_tint, toonMix_bright_tint, pivotBlendSideShades);//// ramp
                UNITY_BRANCH
                if (_useCrossOverRim)
                {
                    half d_BDFlipper    = dot((reflect(-dirView, dirNormalToonRamp)), -dirLight)*.5+.5;
                    d_BDFlipper         = saturate(RemapRange(d_BDFlipper,0+_crossOverPinch,1-_crossOverPinch,0,1));
                    float crossOverMask = _crossOverMask.SampleGrad(sampler_MainTex, uv_toon.uv, uv_toon.dx, uv_toon.dy).g;
                    half dbCrossoverDot = crossOverMask * (pow(StepFeatherRemap(.5-dDiff.ndv*.5,_crossOverStep,_crossOverFeather), exp2( lerp(3,0,_crosspOverRimPow))));

                    float3 bd_albedoTex;
                    UNITY_BRANCH
                    switch (_crossOverSourceTexSource){
                        default:
                        case 0:
                            float4 crossCoverTex = _crossOverAlbedo.SampleGrad(sampler_MainTex, uv_toon.uv, uv_toon.dx, uv_toon.dy);
                            bd_albedoTex = crossCoverTex; 
                            break;
                        case 1: bd_albedoTex = shadeAlbedoTex1.rgb; break;
                        case 2: bd_albedoTex = coreAlbedoTex.rgb; break;
                        case 3: bd_albedoTex = backwardAlbedoTex.rgb; break;
                    }
                    half3 toonMix_BD_albedo         = bd_albedoTex;
                    half3 toonMix_BD_mix            = lerp(shadeCol_2, shadeCol_3, d_BDFlipper) * _crossOverTint.rgb;

                    half3 toonMix_darkRim_albedo    = lerp(shadeColor_albedo, toonMix_BD_albedo, pow(dbCrossoverDot,2));
                    half3 shadeColor_darkRim_albedo = lerp(shadeColor_tint, toonMix_BD_mix, dbCrossoverDot);
                    shadeColor_albedo               = toonMix_darkRim_albedo;
                    shadeColor_tint                 = shadeColor_darkRim_albedo;
                }
                UNITY_BRANCH
                if (_DetailAlbedo)
                {
                    shadeColor_albedo = lerp(sqrt(shadeColor_albedo), (detailMap.r < 0.0) ? 0.0 : 1.0, abs(detailMap.r) * detailMask.r * _DetailAlbedo);
                    shadeColor_albedo *= shadeColor_albedo;
                }
                // return float4(shadeColor,1);



//// SSS Sub Surface Scattering
//// https://www.alanzucconi.com/2017/08/30/fast-subsurface-scattering-1/
//// https://prideout.net/blog/old/blog/index.html@p=51.html
//// https://github.com/HhotateA/FakeSSS_UnityShader
                half3 SSScol = 0.;
                float SSSmask = 0.;
                half3 colSSS = 0.;
                if (_useSSS)
                {
                    float SSSnDv = 1.;
                    float SSSdepth = 1.;
                    if (isBackFace){SSSdepth = 0.;}
                    float SSSThicknessMask = _SSSThicknessMask.SampleGrad( sampler_MainTex, uv_toon.uv, uv_toon.dx, uv_toon.dy).g;
                    SSSdepth *= SSSThicknessMask;
                    UNITY_BRANCH
                    if (_useFakeSSS)
                    {
                        float d_volumeCheap = (dot(dirView, -normalize(dirLight + dirNormalToonRamp * _SSSLensFake)))*.5+.5;
                        d_volumeCheap = Pow2Recurve((d_volumeCheap), _SSSDensityFake);
                        SSSdepth *= d_volumeCheap;
                    }
                #ifdef DepthDataContext
                    UNITY_BRANCH
                    if ((volDepth > 0.0) && (_useRealSSS))
                    {
                        //// depth;
                        float SSSRealDepth = (1 - volDepth); /// must not be negative
                        SSSRealDepth = Pow2Recurve((SSSRealDepth), _SSSDensityReal);

                        SSSdepth *= SSSRealDepth;
                    }
                    //// color albedo
                    //// rim
                    SSSnDv = depthMap.g; /// stores rim dot
                    SSSnDv = Pow2Recurve((1 - SSSnDv), _SSSRim);
                    float SSSRimMask        = RemapRangeH01((SSSnDv), _SSSRimMaskH, _SSSRimMaskL);
                    half3 SSScolorMixRim    = lerp(_SSSColThin.rgb, _SSSColRim.rgb, SSSRimMask);
                #else
                    half3 SSScolorMixRim    = _SSSColThin.rgb;
                #endif // DepthDataContext
                    float SSScolDepth       = RemapRangeH01(SSSdepth, _SSSDepthColL, _SSSDepthColH);
                    half3 SSScolorMixDepth  = lerp((_SSSColThick.rgb * _SSSColThin.rgb), SSScolorMixRim, SSScolDepth);
                    half3 SSScolorMix       = SSScolorMixDepth;
                    //// light albedo
                    //// lens
                    float SSSldh            = saturate(dot(dirView, -normalize(dirLight + dirNormalToonRamp * _SSSLens)));
                    float3 dirSSSIndirect   = -normalize(dirView + dirNormalToonRamp * _SSSLens);
                    half3 SSSdirectLightAve = ((lightDirectSource * _LightShadowData.x * .5) + lightDirectSource ) * .5;
    #ifdef UNITY_PASS_FORWARDBASE
                    half3 SSSGICol = ShadeSH9_ac(float4(dirSSSIndirect,1));
                    half3 lightSSS = (SSSGICol + (SSSldh * SSSdirectLightAve));
    #elif UNITY_PASS_FORWARDADD
                    half3 lightSSS = ((SSSldh * SSSdirectLightAve));
    #endif 
                    //// mix
                    colSSS = SSScolorMix * lightSSS * SSSdepth;
                }





//// specular setup control
                //// global specular effects mask
                UV_DD uv_specularMask   = UVDD( TRANSFORM_TEX( UVPick01(i.uv01, i.uv02), _Set_HighColorMask));
                float4 specularMask     = _Set_HighColorMask.SampleGrad( sampler_MainTex, uv_specularMask.uv, uv_specularMask.dx, uv_specularMask.dy);
                float aoSpecularM       = saturate(specularMask.g + _Tweak_HighColorMaskLevel);
                //// specular workflow
                UV_DD uv_specular       = UVDD( TRANSFORM_TEX( UVPick01(i.uv01, i.uv02), _HighColor_Tex));
                float4 highColorTex     = _HighColor_Tex.SampleGrad( sampler_MainTex, uv_specular.uv, uv_specular.dx, uv_specular.dy);

                float4 metallicTex      = _MetallicGlossMap.SampleGrad( sampler_MainTex, uv_specular.uv, uv_specular.dx, uv_specular.dy);
                float4 specGlossTex     = _SpecGlossMap.SampleGrad( sampler_MainTex, uv_specular.uv, uv_specular.dx, uv_specular.dy);
                //// gloss map (affects reflection only)
                // UV_DD uv_glossiness     = UVDD( TRANSFORM_TEX( UVPick01(i.uv01, i.uv02), _GlossinessMap));
                float4 glossinessTex    = _GlossinessMap.SampleGrad( sampler_MainTex, uv_specular.uv, uv_specular.dx, uv_specular.dy);

////workflows
                //// prepare shine & gloss
                float3 specularSrcCol = 1.0;
                half4 sg4 = 1.0;
                half2 mg2 = 1.0;
                float diffuseScale = 1.0;
                float smoothness = 1.0;
                UNITY_BRANCH
                if (_WorkflowMode == 0)//// specular
                {
                    sg4.rgb = highColorTex.rgb;
                    sg4.a   = highColorTex.a * _Glossiness;
                    specularSrcCol  = sg4.rgb;
                    smoothness      = sg4.a;
                }
                else if (_WorkflowMode == 1)//// metallic
                {
                    mg2[0]  = metallicTex.r * _Metallicness;
                    mg2[1]  = metallicTex.a * _Glossiness;
                    specularSrcCol = highColorTex.rgb;
                    smoothness  = mg2[1];
                }
                else//// AutoDesk/roughness
                {
                    mg2[0] = metallicTex.r * _Metallicness;
                    mg2[1] = (1.0 - specGlossTex.r) * (_Glossiness);
                    specularSrcCol = highColorTex.rgb;
                    smoothness  = mg2[1];
                }

                //// detail smoothness
                UNITY_BRANCH
                if (_DetailSmoothness)
                {
                    smoothness  = lerp(smoothness, (detailMap.b < 0.0) ? 0.0 : 1.0, abs(detailMap.b) * detailMask.b * _DetailSmoothness);
                }

                //// specular workflow. Tint the specular mask and mix energy.
                specularSrcCol  *= _SpecColor.rgb;
                UNITY_BRANCH
                if (_highColTexSource)//// mixing main texture
                {
                    half3 tempCol       = lerp(1, shadeColor_albedo, _highColTexSource);//// want 1.0 mix for countering extreme dark 0.0 RGBs
                    half3 AlbedoHSVI    = HSVI_controller(tempCol, _SpecularMaskHSV.x, _SpecularMaskHSV.y, _SpecularMaskHSV.z, _SpecularMaskHSV.w);
                    specularSrcCol      *= lerp(1, AlbedoHSVI, _highColTexSource);
                }

                half3 specOverrideColor = shadeColor_albedo;
                UNITY_BRANCH
                if (_SpecOverride)//// impart specular workflow's color into metallic color mixing
                {
                    specOverrideColor = specularSrcCol;
                }

                //// mix diffuse/specular by workflow
                float oneMinusReflectivity  = 1;
                UNITY_BRANCH
                if (_WorkflowMode == 0)//// spec gloss
                {
                    diffuseScale = EnergyConservationBetweenDiffuseAndSpecular_ac(_UseDiffuseEnergyConservation, specularSrcCol, oneMinusReflectivity);
                }
                else if (_WorkflowMode == 1)//// metallic
                {
                    diffuseScale = DiffuseAndSpecularFromMetallic_ac(_UseDiffuseEnergyConservation, specOverrideColor, mg2[0], specularSrcCol, oneMinusReflectivity);
                    // diffuseScale = DiffuseAndSpecularFromMetallic_ac(_UseDiffuseEnergyConservation, shadeColor_albedo, mg2[0], specularSrcCol, oneMinusReflectivity);
                }
                else//// AutoDesk
                {
                    diffuseScale = DiffuseAndSpecularFromMetallic_ac(_UseDiffuseEnergyConservation, specOverrideColor, mg2[0], specularSrcCol, oneMinusReflectivity);
                }

                //// specular off/on affects
                //// rim light helpers. For the Code optimizer (cannot let it change uniforms i had wrote too before)
                int envGrazeMix_      = _EnvGrazeMix;
                int envGrazeRimMix_   = _EnvGrazeRimMix;
                UNITY_BRANCH
                if (!(_UseSpecularSystem))//// forgive this lazy switch
                {
                    specularSrcCol = envGrazeMix_ = envGrazeRimMix_ = 0;
                    oneMinusReflectivity = 1;
                    diffuseScale = 1;
                    // smoothness = 0.0; //// dont affect cubemap fernel(?)
                }

                //// prepare shine lobe components
                float perceptualRoughness = 1 - smoothness;
                
                //// prepare reflection components
                float3 glossColor       = specularSrcCol;
                float smoothnessGloss   = smoothness;
                float oneMinusReflectivityGloss = oneMinusReflectivity;
                UNITY_BRANCH
                if (_GlossinessMapMode == 1)//// gloss scales reflection
                {
                    glossColor      *= glossinessTex.rgb;
                    smoothnessGloss = saturate(smoothnessGloss + (glossinessTex.a * 2 - 1));//// spread from 50% grey
                    EnergyConservationBetweenDiffuseAndSpecular_ac(true, glossColor, oneMinusReflectivityGloss);
                }
                else if (_GlossinessMapMode == 2) //// gloss is reflection
                {
                    glossColor      = glossinessTex.rgb;
                    smoothnessGloss = glossinessTex.a;
                    EnergyConservationBetweenDiffuseAndSpecular_ac(true, glossColor, oneMinusReflectivityGloss);
                }

                float perceptualRoughnessGloss  = 1 - smoothnessGloss;
                float roughnessReflection       = 0;//// cubemap, matcap
                float surfaceReduction          = 0;
                UNITY_BRANCH
                if (_ENVMmode == 1)//// standard
                {
                    float envSmoothness = saturate(1-perceptualRoughnessGloss + (2 * _envRoughness - 1)); //// wrong name (its smoothness)
                    roughnessReflection = RoughnessMagicNumberUnityRecurve(1 - envSmoothness);
                    float roughnessPR   = PerceptualRoughnessToRoughness_ac(perceptualRoughnessGloss);
                    surfaceReduction    = _ENVMix / (roughnessPR * roughnessPR + 1.0);
                }
                else if (_ENVMmode == 2)//// override
                {
                    float envSmoothness = _envRoughness; //// wrong name (its smoothness)
                    // float envSmoothness = saturate(1-perceptualRoughnessGloss + (2 * _envRoughness - 1)); //// wrong name (its smoothness)
                    roughnessReflection = RoughnessMagicNumberUnityRecurve(1 - envSmoothness);
                    float roughnessPR   = PerceptualRoughnessToRoughness_ac(perceptualRoughnessGloss);
                    surfaceReduction    = _ENVMix / (roughnessPR * roughnessPR + 1.0);
                }






//// matcap
                float4 matcapMask   = float4(0.,1.,0.,0.); //// diff/mult/spec/emis
                float matcapShaMask = 1;
                half3 mcMixAdd     = 0;
                half3 mcMixMult    = 1;
                half3 mcMixEmis    = 0;
                half3 mcMixHardMult = 1;
                UNITY_BRANCH
                if (_MatCap)
                {
                    float matcapRotStablizer = 0;
                    if (_CameraRolling_Stabilizer)
                    {
                        // (UTS2 v.2.0.6) : CameraRolling Stabilizer Simplified by ACiiL
                        //// get vectors
                        float3 cameraRightAxis  = UNITY_MATRIX_V[0].xyz;//// UNITY_MATRIX_V camera matrix is powerful.
                        float3 cameraFrontAxis  = UNITY_MATRIX_V[2].xyz;//// get cam [0]:right and [2]:forward vectors
                        float3 upAxis           = float3(0, 1, 0);      //// get world upward (camera matrix is world)
                        //// get cross of cam forward to world/object(???) up
                        float3 crossRightAxisMag = normalize( cross(cameraFrontAxis, upAxis));////
                        if(isMirror)//// mirror is a lie as we fake the UV twist
                        {
                            crossRightAxisMag   *= -1;
                            _Rotate_MatCapUV    *= -1;
                        }
                        //// cam roll secret sauce
                        float cameraRollCosTheta    = dot(crossRightAxisMag, cameraRightAxis);//// wait
                        float cameraRollRad         = acos(clamp(cameraRollCosTheta, -1, 1)); //// what
                        matcapRotStablizer          = cameraRollRad; //// oh actual CosTheta usage
                        if (cameraRightAxis.y > 0)//// camera axis sign affects roll symmetry
                        {
                            matcapRotStablizer *= -1.0;
                        }
                        //// now add that rad to the UV roll formula
                    }
                    //// normalmap rotate
                    float2 rot_MatCapNmUV       = rotateUV( UVPick01(i.uv01, i.uv02, _uvSet_NormalMapForMatCap), float2(0.5,0.5), (_Rotate_NormalMapForMatCapUV * 3.141592654));
                    //// normal map
                    UV_DD uv_matcap_nm          = UVDD( TRANSFORM_TEX( rot_MatCapNmUV, _NormalMapForMatCap));
                    float4 normalMapForMatCap   = _NormalMapForMatCap.SampleGrad( sampler_NormalMap, uv_matcap_nm.uv, uv_matcap_nm.dx, uv_matcap_nm.dy);
                    float3 matCapNormalMapTex   = UnpackNormal( normalMapForMatCap);
                    //// v.2.0.5: MatCap with camera skew correction. @kanihira
                    float3 dirNormalMatcap      = (_Is_NormalMapForMatCap) ? mul( matCapNormalMapTex, tangentTransform) : i.wNormal;
                    ////
                    float3 viewNormal                   = mul( UNITY_MATRIX_V, dirNormalMatcap);
                    float3 normalBlendMatcapUVDetail    = viewNormal.xyz * float3(-1,-1,1);
                    float3 normalBlendMatcapUVBase      = (mul( UNITY_MATRIX_V, float4(dirView,0) ).xyz * float3(-1,-1,1)) + float3(0,0,1);
                    float3 noSknewViewNormal            = (normalBlendMatcapUVBase * dot(normalBlendMatcapUVBase, normalBlendMatcapUVDetail) / normalBlendMatcapUVBase.z) - normalBlendMatcapUVDetail;
                    float2 viewNormalAsMatCapUV         = ((noSknewViewNormal).xy * 0.5) + 0.5;
                    //// matcap rotation
                    float2 scl_MatCapUV         = scaleUV(viewNormalAsMatCapUV, float2(0.5,0.5), -2 * _Tweak_MatCapUV + 1);
                    float2 rot_MatCapUV         = rotateUV(scl_MatCapUV, float2(0.5,0.5),  (_Rotate_MatCapUV * 3.141592654) + matcapRotStablizer);
                    //// get blur
                    float mcLodMax0, mcLodMax1, mcLodMax2, mcLodMax3;
                    mcLodMax0 = mcLodMax1 = mcLodMax2 = mcLodMax3 = 0;
                    _MatCapTexAdd.GetDimensions(mip,testw2,testh,mcLodMax0);
                    _MatCapTexMult.GetDimensions(mip,testw2,testh,mcLodMax1);
                    _MatCapTexEmis.GetDimensions(mip,testw2,testh,mcLodMax2);
                    _MatCapTexHardMult.GetDimensions(mip,testw2,testh,mcLodMax3);
                    
                    //// UV to texture
                    half mcNaturalRoughness = RoughnessMagicNumberUnityRecurve(perceptualRoughnessGloss);
                    half mcBlur0 = (_matcapSmoothnessSource0) ? mcNaturalRoughness : 1 - _BlurLevelMatcap0;
                    half mcBlur1 = (_matcapSmoothnessSource1) ? mcNaturalRoughness : 1 - _BlurLevelMatcap1;
                    half mcBlur2 = (_matcapSmoothnessSource2) ? mcNaturalRoughness : 1 - _BlurLevelMatcap2;
                    half mcBlur3 = (_matcapSmoothnessSource3) ? mcNaturalRoughness : 1 - _BlurLevelMatcap3;
                    float2 matcapUV             = TRANSFORM_TEX(rot_MatCapUV, _MatCapTexAdd);
                    float4 matCapTexAdd         = _MatCapTexAdd .SampleLevel(sampler_MatCap_Trilinear_clamp, matcapUV, perceptualRoughnessToMipmapLevel_ac(mcBlur0,mcLodMax0));
                    float4 matCapTexMult        = _MatCapTexMult.SampleLevel(sampler_MatCap_Trilinear_clamp, matcapUV, perceptualRoughnessToMipmapLevel_ac(mcBlur1,mcLodMax1));
                    float4 matCapTexEmis        = _MatCapTexEmis.SampleLevel(sampler_MatCap_Trilinear_clamp, matcapUV, perceptualRoughnessToMipmapLevel_ac(mcBlur2,mcLodMax2));
                    float4 matCapTexHardMult    = _MatCapTexHardMult.SampleLevel(sampler_MatCap_Trilinear_clamp, matcapUV, perceptualRoughnessToMipmapLevel_ac(mcBlur3,mcLodMax3));
                    ////
                    mcMixAdd        = matCapTexAdd.rgb * matCapTexAdd.a;
                    mcMixMult       = matCapTexMult.rgb * matCapTexMult.a;
                    mcMixEmis       = matCapTexEmis.rgb * matCapTexEmis.a;
                    mcMixHardMult   = matCapTexHardMult.rgb * matCapTexHardMult.a;
                    UNITY_BRANCH
                    if (_TweakMatCapOnShadow)//// slider > 0
                    {
                        matcapShaMask       = lerp(1, shadowMaskNormalized, _TweakMatCapOnShadow);
                    }
                    UV_DD uv_mcMask         = UVDD( TRANSFORM_TEX( UVPick01(i.uv01, i.uv02), _Set_MatcapMask));
                    float4 matcapMaskTex    = _Set_MatcapMask.SampleGrad( sampler_MainTex, uv_mcMask.uv, uv_mcMask.dx, uv_mcMask.dy);
                    matcapMask      = matcapMaskTex;
                    matcapMask.rg   *= saturate(matcapMaskTex.rg + _Tweak_MatcapMaskLevel.xx);
                }



//// Specular. High Color.
                float highColorInShadow = 1;
                float specMaskSetup_1   = 0;
                UNITY_BRANCH
                if ((dSpec.ndl < 0) || (dSpec.ndv < 0)) //// impossible dot setups
                {
                    specMaskSetup_1         = 0;
                }
                else 
                {
                    float roughness         = PerceptualRoughnessToRoughness_ac(perceptualRoughness);
                    roughness               = max(roughness, 0.002);
                    UNITY_BRANCH
                    if (_Is_SpecularToHighColor > 1) //// unity
                    {
                        float spec_NDF      = GGXTerm_ac(dSpec.ndh, roughness);
                        float spec_GSF      = SmithJointGGXVisibilityTerm_ac(dSpec.ndl, dSpec.ndv, roughness);
                        specMaskSetup_1     = (spec_NDF * spec_GSF * UNITY_PI);
                        specMaskSetup_1     *= dSpec.ndl;
                        specMaskSetup_1     = max(0, specMaskSetup_1);
                    }
                    else if (_Is_SpecularToHighColor > 0) //// smooth
                    {
                        specMaskSetup_1     = pow(dSpec.ndh, RoughnessToSpecPower_ac(roughness)) * UNITY_PI;
                        // specMaskSetup_1     = NDFBlinnPhongNormalizedTerm(dSpec.ndh, PerceptualRoughnessToSpecPower_ac(perceptualRoughness));
                        specMaskSetup_1     *= SmithBeckmannVisibilityTerm_ac(dSpec.ndl, dSpec.ndv, roughness);
                        specMaskSetup_1     *= dSpec.ndl;
                        // return float4(specMaskSetup_1.xxx,1);
                    }
                    else {  //// sharp
                        specMaskSetup_1     = (1 - step(dSpec.ndhS * KelemenGSF(dSpec.ndl, dSpec.ndv, dSpec.vdh), (1 - roughness)));
                    }
                    UNITY_BRANCH
                    if (_TweakHighColorOnShadow) //// slider > 0
                    {
                        highColorInShadow   = lerp(1, shadowMaskNormalized, _TweakHighColorOnShadow);
                    }
                    specMaskSetup_1         *= highColorInShadow;
                }
                //// mix lobs, system intented to mix +1 spec's lobes
                float3 highColorTotalCol_1  = specularSrcCol * _HighColor.rgb;



//// Env Reflection
                float3 colEnv           = 0;
                float3 envOntoRimSetup  = 0;
                half envRimMask = 0;
                // half mipC,testw,testw2,testh,lodMax;
                mip = testw = testw2 = testh = lodMax = 0;
                UNITY_BRANCH
                if (_useCubeMap)
                {
                    float envLOD;
                    float3 reflDir0 = BoxProjection(dEnv.dirViewReflection, i.worldPos, unity_SpecCube0_ProbePosition, unity_SpecCube0_BoxMin, unity_SpecCube0_BoxMax);

                    //// sample cubemaps
                    UNITY_BRANCH
                    if (_CubemapFallbackMode < 2) //// not override cubemap. solve real cubemaps
                    {
                        unity_SpecCube0.GetDimensions(mip,testw,testw,lodMax);
                        envLOD              = perceptualRoughnessToMipmapLevel_ac(roughnessReflection, lodMax);
                        float4 refColor0    = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflDir0, envLOD);
                        refColor0.rgb       = DecodeHDR(refColor0, unity_SpecCube0_HDR);
                        colEnv              = refColor0.rgb;
                        UNITY_BRANCH
                        if (unity_SpecCube0_BoxMin.w < 0.9999)//// 2nd blend cubemap
                        {
                            unity_SpecCube1.GetDimensions(mip,testw2,testh,lodMax);
                            envLOD              = perceptualRoughnessToMipmapLevel_ac(roughnessReflection, lodMax);
                            float3 reflDir1     = BoxProjection(dEnv.dirViewReflection, i.worldPos, unity_SpecCube1_ProbePosition, unity_SpecCube1_BoxMin, unity_SpecCube1_BoxMax);
                            float4 refColor1    = UNITY_SAMPLE_TEXCUBE_SAMPLER_LOD(unity_SpecCube1, unity_SpecCube0, reflDir1, envLOD);
                            refColor1.rgb       = DecodeHDR(refColor1, unity_SpecCube1_HDR);
                            colEnv              = lerp(refColor1.rgb, refColor0.rgb, unity_SpecCube0_BoxMin.w);
                        }
                    }
                    UNITY_BRANCH
                    if (_CubemapFallbackMode) //// not off
                    {
                        UNITY_BRANCH
                        if ( (_CubemapFallbackMode > 1) || (testw < 16)) //// mode forced or smart. Conditionals cannot short-circit
                        {
                            _CubemapFallback.GetDimensions(mip,testw,testh,lodMax);
                            envLOD              = perceptualRoughnessToMipmapLevel_ac(roughnessReflection, lodMax);
                            float4 colEnvBkup   = _CubemapFallback.SampleLevel(sampler_CubemapFallback, reflDir0, envLOD);
                            colEnvBkup.rgb      = DecodeHDR(colEnvBkup, _CubemapFallback_HDR);
                            colEnv              = colEnvBkup * cubeMapAveAlbedo;//// fallback albedo light mix
                        }
                    }
                    //// natural grazing rim mask
                    if (envGrazeMix_)
                    {
                        envRimMask = Pow4_ac(1 - dEnv.ndv);
                    }
                    envOntoRimSetup = colEnv;
                }




//// rim lighting
                half rimLightMask1, rimLightMask2;
                half3 rimLightCol1, rimLightCol2;
                rimLightMask1   = rimLightMask2 = 0;
                rimLightCol1    = rimLightCol2 = 0;
                UV_DD uv_rimLight   = UVDD( TRANSFORM_TEX(  UVPick01(i.uv01, i.uv02), _Set_RimLightMask));
                int rimLight_                   = _RimLight;
                int add_Antipodean_RimLight_    = _Add_Antipodean_RimLight;
                UNITY_BRANCH
                if ((!_useRimLightSystem)) //// switch for script optimizer
                {
                    rimLight_                   = 0;
                    add_Antipodean_RimLight_    = 0;
                }
                UNITY_BRANCH
                if ((rimLight_) || (add_Antipodean_RimLight_))
                {
                    half4 rimLightMaskTex  = _Set_RimLightMask.SampleGrad( sampler_MainTex, uv_rimLight.uv, uv_rimLight.dx, uv_rimLight.dy);
                    half rimLightTexMask   = saturate( rimLightMaskTex.g + _Tweak_RimLightMaskLevel);
                    half rimArea        = (1.0 - (dRimLight.ndv));
                    half rimArea1       = StepFeatherRemap(rimArea, -_RimLightAreaOffset + 1, 1 - _RimLight_InsideMask);
                    //// range experiment. Should allow far angles to apply to intensity.
                    // half rimArea        = (.5-dRimLight.ndv*.5);
                    // half rimArea1       = StepFeatherRemap(rimArea, .5-_RimLightAreaOffset*.5, 1 - _RimLight_InsideMask);
                    ////
                    half rimLightPower1 = pow(rimArea1, exp2( lerp(3, 0, _RimLight_Power)));
                    half rimLightPower2 = pow(rimArea1, exp2( lerp(3, 0, _Ap_RimLight_Power)));

                    // rim mask
                    half rimlightMaskSetup1 = (rimLightPower1);
                    half rimlightMaskSetup2 = (rimLightPower2);
                    ////
                    UNITY_BRANCH
                    if (_LightDirection_MaskOn)
                    {
                        half vdl                = (dot(UNITY_MATRIX_V[2].xyz, dirNormalRimLight) * .1 + .1); /// camera z forward vector
                        half nDl                = dot(dirLight,dirNormalRimLight)*.5+.5;
                        half rimlightMaskToward = (1 - nDl) + _Tweak_LightDirection_MaskLevel;
                        half rimLightMaskAway   = (nDl) + _Tweak_LightDirection_MaskLevel;
                        rimLightMask1           = saturate(rimlightMaskSetup1 - rimlightMaskToward - vdl);
                        rimLightMask2           = saturate(rimlightMaskSetup2 - rimLightMaskAway - vdl);
                    } 
                    else
                    {
                        rimLightMask1   = rimlightMaskSetup1;
                        rimLightMask2   = 0;
                    }
                    ////
                    rimLightMask1   *= rimLightTexMask;
                    rimLightMask2   *= rimLightTexMask;
                    //// colors input
                    half3 rimTexAlbedo = 1;
                    UNITY_BRANCH
                    if (_rimAlbedoMix)
                    {
                        UNITY_BRANCH
                        switch(_RimLightSource) {
                            default:
                            case 0: rimTexAlbedo = shadeColor_albedo; break;
                            case 1: rimTexAlbedo = specularSrcCol; break;
                        }
                        rimTexAlbedo = lerp(1, rimTexAlbedo, _rimAlbedoMix);
                    }
                    ////
                    rimLightCol1 = _RimLightColor.rgb;
                    rimLightCol2 = _Ap_RimLightColor.rgb;
                    UNITY_BRANCH
                    if (_useRimLightOverTone)
                    {
                        half rimEdgeBoundary1   = saturate(RemapRange(rimLightPower1, _rimLightOverToneLow, _rimLightOverToneHigh, 0, 1));//// edge color
                        half rimEdgeBoundary2   = saturate(RemapRange(rimLightPower2, _rimLightOverToneLow, _rimLightOverToneHigh, 0, 1));//// edge color
                        rimLightCol1            = lerp(_RimLightColor.rgb,    _rimLightOverToneBlendColor1,  rimEdgeBoundary1);
                        rimLightCol2            = lerp(_Ap_RimLightColor.rgb, _rimLightOverToneBlendColor2,  rimEdgeBoundary2);
                    }
                    rimLightCol1 *= rimTexAlbedo;
                    rimLightCol2 *= rimTexAlbedo;
                }



//// Emission   // crosses into diffuse effect
#ifdef UNITY_PASS_FORWARDBASE
                UV_DD uv_EmissionCol_1  = UVDD(TRANSFORM_TEX( UVPick01(i.uv01, i.uv02, _uvSet_EmissionColorTex), _Emissive_Tex));
                UV_DD uv_EmissionCol_2  = UVDD(TRANSFORM_TEX( UVPick01(i.uv01, i.uv02, _uvSet_EmissionColorTex), _EmissionColorTex2));
                float4 emissionTex1     = _Emissive_Tex.SampleGrad( sampler_Emissive_Tex, uv_EmissionCol_1.uv, uv_EmissionCol_1.dx, uv_EmissionCol_1.dy);
                float4 emissionTex2     = _EmissionColorTex2.SampleGrad( sampler_EmissionColorTex2, uv_EmissionCol_2.uv, uv_EmissionCol_2.dx, uv_EmissionCol_2.dy);

                // UNITY_BRANCH if (_emissiveUseMainTexCol) {//// and color from main texture
                //     emissionTex.rgba = shadeAlbedoTex1.rgba;
                // }
                //// prepare energy/lum
                half emissionLums       = max(1., _emissionProportionalLum * lightAverageLum);
                //// prepare tint
                half3 emissionTint1     = _Emissive_Color.rgb * emissionTex1.rgb * emissionTex1.a;
                half3 emissionTintChain = emissionTint1;
                UNITY_BRANCH if (_emissionUse2ndTintRim)
                { //// mix 2nd tint rim
                    half3 emissionTint2 = _Emissive_Color2.rgb * emissionTex2.rgb * emissionTex2.a;
                    half emisRimMask    = RemapRangeH01((dEmiss.ndv*.5+.5), _emission2ndTintLow, _emission2ndTintHigh);
                    emisRimMask         = 1 - Pow2Recurve((1 - emisRimMask), _emission2ndTintPow);
                    emissionTintChain   = lerp(emissionTint2, emissionTintChain, emisRimMask);
                }
                UNITY_BRANCH if (_emissionMixTintDiffuseSlider)
                { //// tint uses diffuse color
                    half3 diffuseTintAlbedo = 1;
                    UNITY_BRANCH
                    if (_emissionMixTintDiffuseSlider)
                    {
                        UNITY_BRANCH
                        switch(_emisLightSourceType) {
                            default:
                            case 0: diffuseTintAlbedo = shadeAlbedoTex1.rgb; break;
                            case 1: diffuseTintAlbedo = shadeAlbedoTex2.rgb; break;
                            case 2: diffuseTintAlbedo = shadeAlbedoTex3.rgb; break;
                        }
                    }
                    emissionTintChain = lerp(emissionTintChain, emissionTintChain * diffuseTintAlbedo, _emissionMixTintDiffuseSlider);
                }
                UNITY_BRANCH
                if (_MatCap){ //// matcap emission
                    half mcMask; if (_matcapEmissMaskSwitch==1) {mcMask = matcapMask.a;} else {mcMask = 1;}
                    emissionTintChain = max(emissionTintChain, mcMixEmis * _MatCapColEmis.rgb * mcMask);
                }
                //// mix all
                half3 emissionMix = emissionTintChain * emissionLums;
                //// prepare masks
                half emissiveMask   = 0;
                UNITY_BRANCH if (_emissionUseMask)
                { //// use mask
                    UV_DD uv_emissiveMask  = UVDD(TRANSFORM_TEX( UVPick01(i.uv01, i.uv02, _uvSet_EmissionColorTex), _EmissionColorTex));
                    emissiveMask    = _EmissionColorTex.SampleGrad( sampler_EmissionColorTex, uv_emissiveMask.uv, uv_emissiveMask.dx, uv_emissiveMask.dy).g;
                    UNITY_BRANCH if (_emissiveUseMainTexA)//// bsome games  store emission mask in main texture alpha
                    {
                        emissiveMask = shadeAlbedoTex1.a;
                    }
                    emissionMix     = emissionMix * emissiveMask;
                    UNITY_BRANCH if (_emissionUseMaskDiffuseDimming) 
                    { //// dim diffuse by emission mask area
                        shadeColor_albedo = shadeColor_albedo * (1 - emissiveMask * _emissionUseMaskDiffuseDimming);
                    }
                }
#endif //// UNITY_PASS_FORWARDBASE


////////////////////////////////////////////////////////////////
//// The Mix zone. Blend everything. In intent all effects are prepared. Requires masks and color sets.
                float4 fragColor    = 0;
                float3 colDiffuse   = 0;
                float3 colSpecular  = 0;
                float3 colFernel    = 0;
                float3 colReflect   = 0;
                float3 colSubsurface = 0;
                float3 colEmission  = 0;

//// base diffuse
                half3 shadeAlbedoMix = shadeColor_albedo;
                half3 shadeColor = shadeColor_albedo * shadeColor_tint;//// mix ramp
                UNITY_BRANCH
                if (_MatCap && _useMCHardMult) //// mix multiply matcap
                {
                    shadeColor *= lerp(1, (mcMixHardMult * _MatCapColHardMult.rgb), matcapMask.g);
                }
                if (_MatCap) //// mix diffuse matcap
                {
                    float3 diffMixMC = 1;
                    if (_McDiffAlbedoMix)
                    {
                        diffMixMC = lerp(1, shadeColor_albedo, _McDiffAlbedoMix);
                    }
                    shadeColor += (diffMixMC * lightSimpleSystem * mcMixMult.rgb * _MatCapColMult.rgb * _MatCapColMult.a * matcapMask.r);
                }
                colDiffuse = shadeColor;

//// rim light
                float3 rimMixer = 0; //// get effects
                if (rimLight_)
                {
                    rimMixer    += rimLightCol1 * rimLightMask1;
                }
                if (add_Antipodean_RimLight_)
                {
                    rimMixer    += rimLightCol2 * rimLightMask2;
                }
                colFernel   = rimMixer; //// get lighting
                half3 colFernelLight = 1;
                if (true) //// fake function incapsulation
                {
                    #ifdef UNITY_PASS_FORWARDADD
                    envOntoRimSetup = envOntoRimSetup * lightAtten; //// ADD pass lights falloff * cubemap makes no sense, but falloff is needed for my rim light gimmiks
                    #endif
                    colFernelLight = lerp(cubeMapAveAlbedo, envOntoRimSetup, _envOnRim); //// get cubemap setup
                    colFernelLight = lerp(LinearRgbToLuminance_ac(colFernelLight), colFernelLight, _envOnRimColorize); //// cubemap color
                    colFernelLight = lerp(lightSimpleSystem, colFernelLight, _rimLightLightsourceType); //// select light system
                }
                colFernel *= colFernelLight;


//// specularity shine lobes
                colSpecular = specMaskSetup_1 * aoSpecularM;
                colSpecular *= FresnelTerm_ac(highColorTotalCol_1, dSpec.ldh);
                colSpecular *= (lightDirectSource);



//// reflection
                float3 envColMixCore    = glossColor;
#ifdef UNITY_PASS_FORWARDBASE
                UNITY_BRANCH
                if (_ENVMmode > 0) //// using env
                {
                    // return float4(surfaceReduction.xxx,1);
                    //// reflection and fernel
                    float envGrazeMask      = max( (envRimMask), ((envGrazeRimMix_) ? max(rimLightMask1, rimLightMask2) : 0)); //// mix rim types
                    float grazingTerm       = saturate(smoothnessGloss + (1 - oneMinusReflectivityGloss)); //// graze intensity [0,1]
                    float envColMixGraze    = grazingTerm * (1 + colGIGray); //// light source hybrid of reflection and indirect: [0,1] * [1,n]
                    float3 envColMix        = lerp(envColMixCore, envColMixGraze.xxx, envGrazeMask); //// graze effect. Source light.
                    colReflect              = colEnv;
                    colReflect              *= surfaceReduction * aoSpecularM;
                    colReflect              *= envColMix;
                }
#endif //// UNITY_PASS_FORWARDBASE
                if (_MatCap){//// spec matcap
                    half3 mcSpecSourceLight = lerp(lightAverageLum, cubeMapAveAlbedo, 1); //// _MatcapSpecSourceLightMix
                    half mcMask; if (_matcapSpecMaskSwitch==1) {mcMask = matcapMask.b;} else {mcMask = aoSpecularM;}
                    colReflect      += (mcMixAdd * _MatCapColAdd.rgb * mcSpecSourceLight) * (_MatCapColAdd.a * matcapShaMask * mcMask);
                }



//// energy conservation on diffuse
                float3 colDiffuseTerms      = (colDiffuse);
                float3 colSpecularTerms     = colSpecular + colFernel + colReflect;
                colDiffuseTerms             *= diffuseScale;

//// specular blending with premultiply alpha
#if !defined(NotAlpha) && !defined(UseAlphaDither) //// cutout mode. dont use premultiplay block
                UNITY_BRANCH
                if (_UseSpecAlpha)
                {
                    PremultiplyAlpha_ac(colDiffuseTerms/* inout */, alpha/* inout */, 1);
                    fragColor.rgb   += colDiffuseTerms + colSpecularTerms;
                    fragColor.a     = alpha;
                }
                else {
                    float3 fuseCol  = colDiffuseTerms + colSpecularTerms;
                    fuseCol         *= alpha;
                    fragColor.rgb   += fuseCol;
                    fragColor.a     = alpha;
                }
#else //// NotAlpha
                fragColor.rgb   = colDiffuseTerms + colSpecularTerms;
                fragColor.a     = alpha;
#endif //// NotAlpha
                fragColor.rgb   = max(0, fragColor);

//// SSS
                colSubsurface = colSSS;
                fragColor.rgb += colSubsurface;

//// light clamp
                if (_forceLightClamp)
                {
                    float sceneIntensity = LinearRgbToLuminance_ac(lightDirectSource + lightIndirectSource); //// grab all light at max potential
                    if (sceneIntensity > 1.0) //// bloom defaults at > 1.1
                    {
                        half3 correctedReflect = colReflect * alpha;//// correction for skybox intensity beign affected. This is refactoring reflection (and if premultiply alpha was used)
                        fragColor.rgb -= correctedReflect;
                        fragColor.rgb = fragColor.rgb / sceneIntensity;//// normalize RGB brightness at this stage.
                        fragColor.rgb += correctedReflect;//// add back in cubemap result
                    }
                } 

//// blend emission
#ifdef UNITY_PASS_FORWARDBASE
                colEmission     = emissionMix;
                fragColor.rgb   += colEmission;
#endif // UNITY_PASS_FORWARDBASE

                //// backface tint
                if (isBackFace){
                    fragColor.rgb *= _backFaceColorTint;
                }

            #ifdef UNITY_PASS_FORWARDADD
                UNITY_APPLY_FOG_COLOR(i.fogCoord,fragColor, half4(0,0,0,0));
                fragColor.rgb = fragColor.rgb * alpha;
            #else
                UNITY_APPLY_FOG_COLOR(i.fogCoord, fragColor, unity_FogColor * alpha);
            #endif
                return fragColor;
            }
#endif //// ACLS_CORE