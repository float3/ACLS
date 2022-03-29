using UnityEditor;
using UnityEngine;
// using System.Collections;
// using System.Collections.Generic;
// using System.Linq;
// using System;
using System.Reflection;

// Base prepared by Morioh for me.
// This code is based off synqark's arktoon-shaders and Xiexe. 
// Citation to "https://github.com/synqark", "https://github.com/synqark/arktoon-shaders", https://gitlab.com/xMorioh/moriohs-toon-shader.
namespace ACLS
{
    public enum DetailEmissionMode
    {
        Phase,
        AudioLink
    }

    public class ACLSInspector : ShaderGUI
    {
        BindingFlags bindingFlags = BindingFlags.Public |
                                    BindingFlags.NonPublic |
                                    BindingFlags.Instance |
                                    BindingFlags.Static;

        MaterialProperty _ShaderOptimizerEnabled = null;

        // Cull
        MaterialProperty _CullMode = null;

        MaterialProperty _backFaceColorTint = null;

        // Toon ramp
        MaterialProperty _useToonRampSystem = null;
        MaterialProperty _useDiffuseAlbedoTexturesSet = null;
        MaterialProperty _toonRampTexturesBlendMode = null;
        MaterialProperty _Use_BaseAs1st = null;
        MaterialProperty _1st_ShadeMap = null;
        MaterialProperty _Use_1stAs2nd = null;
        MaterialProperty _2nd_ShadeMap = null;
        MaterialProperty _MainTex = null;
        MaterialProperty _Color = null;
        MaterialProperty _0_ShadeColor = null;
        MaterialProperty _1st_ShadeColor = null;
        MaterialProperty _2nd_ShadeColor = null;
        MaterialProperty _BaseColor_Step = null;
        MaterialProperty _BaseShade_Feather = null;
        MaterialProperty _ShadeColor_Step = null;
        MaterialProperty _1st2nd_Shades_Feather = null;
        MaterialProperty _ToonRampLightSourceType_Backwards = null;
        MaterialProperty _diffuseIndirectDirectSimMix = null;
        MaterialProperty _Diff_GSF_01 = null;
        MaterialProperty _DiffGSF_Offset = null;
        MaterialProperty _DiffGSF_Feather = null;
        MaterialProperty _useCrossOverRim = null;
        MaterialProperty _crossOverMask = null;
        MaterialProperty _crossOverAlbedo = null;
        MaterialProperty _crossOverPinch = null;
        MaterialProperty _crossOverStep = null;
        MaterialProperty _crossOverFeather = null;
        MaterialProperty _crosspOverRimPow = null;
        MaterialProperty _crossOverTint = null;

        MaterialProperty _crossOverSourceTexSource = null;

        // Specular Shine
        MaterialProperty _UseSpecularSystem = null;
        MaterialProperty _WorkflowMode = null;
        MaterialProperty _SpecOverride = null;
        MaterialProperty _UseDiffuseEnergyConservation = null;
        MaterialProperty _SpecColor = null;
        MaterialProperty _Glossiness = null;
        MaterialProperty _Metallicness = null;
        MaterialProperty _HighColor_Tex = null;
        MaterialProperty _MetallicGlossMap = null;
        MaterialProperty _SpecGlossMap = null;
        MaterialProperty _highColTexSource = null;
        MaterialProperty _SpecularMaskHSV = null;
        MaterialProperty _HighColor = null;
        MaterialProperty _Is_SpecularToHighColor = null;

        MaterialProperty _TweakHighColorOnShadow = null;

        // Reflection
        MaterialProperty _useCubeMap = null;
        MaterialProperty _GlossinessMapMode = null;
        MaterialProperty _GlossinessMap = null;
        MaterialProperty _ENVMmode = null;
        MaterialProperty _ENVMix = null;
        MaterialProperty _envRoughness = null;
        MaterialProperty _CubemapFallbackMode = null;
        MaterialProperty _CubemapFallback = null;
        MaterialProperty _EnvGrazeMix = null;
        MaterialProperty _EnvGrazeRimMix = null;
        MaterialProperty _envOnRim = null;

        MaterialProperty _envOnRimColorize = null;

        // Rimlights
        MaterialProperty _useRimLightSystem = null;
        MaterialProperty _RimLight = null;
        MaterialProperty _Add_Antipodean_RimLight = null;
        MaterialProperty _rimAlbedoMix = null;
        MaterialProperty _RimLightSource = null;
        MaterialProperty _RimLightColor = null;
        MaterialProperty _Ap_RimLightColor = null;
        MaterialProperty _RimLight_Power = null;
        MaterialProperty _Ap_RimLight_Power = null;
        MaterialProperty _RimLight_InsideMask = null;
        MaterialProperty _RimLightAreaOffset = null;
        MaterialProperty _LightDirection_MaskOn = null;
        MaterialProperty _Tweak_LightDirection_MaskLevel = null;
        MaterialProperty _rimLightLightsourceType = null;
        MaterialProperty _useRimLightOverTone = null;
        MaterialProperty _rimLightOverToneBlendColor1 = null;
        MaterialProperty _rimLightOverToneBlendColor2 = null;
        MaterialProperty _rimLightOverToneLow = null;

        MaterialProperty _rimLightOverToneHigh = null;

        // Matcap
        MaterialProperty _MatCap = null;
        MaterialProperty _MatCapColMult = null;
        MaterialProperty _MatCapTexMult = null;
        MaterialProperty _MatCapColAdd = null;
        MaterialProperty _MatCapTexAdd = null;
        MaterialProperty _MatCapColEmis = null;
        MaterialProperty _MatCapTexEmis = null;
        MaterialProperty _useMCHardMult = null;
        MaterialProperty _MatCapColHardMult = null;
        MaterialProperty _MatCapTexHardMult = null;
        MaterialProperty _Is_NormalMapForMatCap = null;
        MaterialProperty _NormalMapForMatCap = null;
        MaterialProperty _Tweak_MatCapUV = null;
        MaterialProperty _Rotate_MatCapUV = null;
        MaterialProperty _Rotate_NormalMapForMatCapUV = null;
        MaterialProperty _TweakMatCapOnShadow = null;
        MaterialProperty _Set_MatcapMask = null;
        MaterialProperty _Tweak_MatcapMaskLevel = null;
        MaterialProperty _McDiffAlbedoMix = null;
        MaterialProperty _BlurLevelMatcap0 = null;
        MaterialProperty _BlurLevelMatcap1 = null;
        MaterialProperty _BlurLevelMatcap2 = null;
        MaterialProperty _BlurLevelMatcap3 = null;
        MaterialProperty _matcapSmoothnessSource0 = null;
        MaterialProperty _matcapSmoothnessSource1 = null;
        MaterialProperty _matcapSmoothnessSource2 = null;
        MaterialProperty _matcapSmoothnessSource3 = null;
        MaterialProperty _CameraRolling_Stabilizer = null;
        MaterialProperty _matcapSpecMaskSwitch = null;

        MaterialProperty _matcapEmissMaskSwitch = null;

        // Depth
        MaterialProperty _depthMaxScale = null;

        // Subsurface
        MaterialProperty _useSSS = null;
        MaterialProperty _useFakeSSS = null;
        MaterialProperty _useRealSSS = null;
        MaterialProperty _SSSThicknessMask = null;
        MaterialProperty _SSSDensityReal = null;
        MaterialProperty _SSSLensFake = null;
        MaterialProperty _SSSDensityFake = null;
        MaterialProperty _SSSLens = null;
        MaterialProperty _SSSRim = null;
        MaterialProperty _SSSDepthColL = null;
        MaterialProperty _SSSDepthColH = null;
        MaterialProperty _SSSColThin = null;
        MaterialProperty _SSSColThick = null;
        MaterialProperty _SSSColRim = null;
        MaterialProperty _SSSRimMaskL = null;

        MaterialProperty _SSSRimMaskH = null;

        // Emission
        MaterialProperty _Emissive_Color = null;

        MaterialProperty _Emissive_Color2 = null;

        // MaterialProperty _EmissiveProportional_Color = null;
        MaterialProperty _Emissive_Tex = null;
        MaterialProperty _EmissionColorTex = null;
        MaterialProperty _EmissionColorTex2 = null;

        MaterialProperty _emissiveUseMainTexA = null;

        // MaterialProperty _emissiveUseMainTexCol = null;
        MaterialProperty _emissionUseMask = null;
        MaterialProperty _emissionUseMaskDiffuseDimming = null;
        MaterialProperty _emisLightSourceType = null;
        MaterialProperty _emissionMixTintDiffuseSlider = null;
        MaterialProperty _emissionProportionalLum = null;
        MaterialProperty _emissionUse2ndTintRim = null;
        MaterialProperty _emission2ndTintLow = null;
        MaterialProperty _emission2ndTintHigh = null;
        MaterialProperty _emission2ndTintPow = null;


        //AudioLink
        MaterialProperty _UseAdvancedEmission = null;
        MaterialProperty _DetailEmissionUVSec = null;
        MaterialProperty _EmissionDetailType = null;
        MaterialProperty _DetailEmissionMap = null;
        
        MaterialProperty _EmissionDetailParams = null;

        MaterialProperty _alColorR = null;
        MaterialProperty _alColorG = null;
        MaterialProperty _alColorB = null;
        MaterialProperty _alColorA = null;
        MaterialProperty _alBandR = null;
        MaterialProperty _alBandG = null;
        MaterialProperty _alBandB = null;
        MaterialProperty _alBandA = null;
        MaterialProperty _alModeR = null;
        MaterialProperty _alModeG = null;
        MaterialProperty _alModeB = null;
        MaterialProperty _alModeA = null;
        MaterialProperty _alTimeRangeR = null;
        MaterialProperty _alTimeRangeG = null;
        MaterialProperty _alTimeRangeB = null;
        MaterialProperty _alTimeRangeA = null;
        MaterialProperty _alUseFallback = null;
        MaterialProperty _alFallbackBPM = null;
        
        MaterialProperty _UseEmissiveLightSense = null;
        MaterialProperty _EmissiveLightSenseStart = null;
        MaterialProperty _EmissiveLightSenseEnd = null;
        //AudioLink


        // Lighting Behaviour
        MaterialProperty _directLightIntensity = null;
        MaterialProperty _indirectAlbedoMaxAveScale = null;
        MaterialProperty _forceLightClamp = null;
        MaterialProperty _BlendOp = null;
        MaterialProperty _shadowCastMin_black = null;
        MaterialProperty _DynamicShadowMask = null;
        MaterialProperty _shadowUseCustomRampNDL = null;
        MaterialProperty _shadowNDLStep = null;
        MaterialProperty _shadowNDLFeather = null;
        MaterialProperty _shadowMaskPinch = null;
        MaterialProperty _shadowSplits = null;
        MaterialProperty _shadeShadowOffset1 = null;
        MaterialProperty _shadeShadowOffset2 = null;

        MaterialProperty _indirectGIDirectionalMix = null;

        MaterialProperty _indirectGIBlur = null;

        // Light Map Shift Masks
        MaterialProperty _UseLightMap = null;
        MaterialProperty _LightMap = null;
        MaterialProperty _lightMap_remapArr = null;
        MaterialProperty _toonLambAry_01 = null;
        MaterialProperty _toonLambAry_02 = null;
        MaterialProperty _Set_1st_ShadePosition = null;

        MaterialProperty _Set_2nd_ShadePosition = null;

        // Ambient Occlusion Maps
        MaterialProperty _Set_HighColorMask = null;
        MaterialProperty _Tweak_HighColorMaskLevel = null;
        MaterialProperty _Set_RimLightMask = null;

        MaterialProperty _Tweak_RimLightMaskLevel = null;

        // Normal map
        MaterialProperty _NormalMap = null;
        MaterialProperty _DetailNormalMapScale01 = null;
        MaterialProperty _NormalMapDetail = null;
        MaterialProperty _DetailNormalMask = null;
        MaterialProperty _Is_NormalMapToBase = null;
        MaterialProperty _Is_NormalMapToHighColor = null;
        MaterialProperty _Is_NormalMapToRimLight = null;

        MaterialProperty _Is_NormaMapToEnv = null;

        // Alpha mask
        MaterialProperty _ZWrite = null;
        MaterialProperty _IsBaseMapAlphaAsClippingMask = null;
        MaterialProperty _ClippingMask = null;
        MaterialProperty _Inverse_Clipping = null;
        MaterialProperty _Clipping_Level = null;
        MaterialProperty _Tweak_transparency = null;
        MaterialProperty _UseSpecAlpha = null;
        MaterialProperty _DetachShadowClipping = null;

        MaterialProperty _Clipping_Level_Shadow = null;

        // Outline
        MaterialProperty _useOutline = null;
        MaterialProperty _OutlineTex = null;
        MaterialProperty _Outline_Sampler = null;
        MaterialProperty _Outline_Color = null;
        MaterialProperty _fillOutlineDepth = null;
        MaterialProperty _Is_BlendBaseColor = null;
        MaterialProperty _Is_OutlineTex = null;
        MaterialProperty _Outline_Width = null;
        MaterialProperty _Nearest_Distance = null;
        MaterialProperty _Farthest_Distance = null;
        MaterialProperty _Offset_Z = null;

        MaterialProperty _outlineEmissionColor = null;
        MaterialProperty _outlineEmissionTint = null;
        MaterialProperty _outlineEmissionUseMask = null;
        MaterialProperty _outlineEmissionMask = null;

        MaterialProperty _outlineEmissiveProportionalLum = null;

        // Stencil Helpers. Requires Queue Order Edits
        MaterialProperty _Stencil = null;
        MaterialProperty _StencilComp = null;
        MaterialProperty _StencilOp = null;

        MaterialProperty _StencilFail = null;

        //
        MaterialProperty _DetailMap = null;
        MaterialProperty _DetailMask = null;
        MaterialProperty _DetailAlbedo = null;

        MaterialProperty _DetailSmoothness = null;

        //
        MaterialProperty _uvSet_ShadePosition = null;
        MaterialProperty _uvSet_LightMap = null;
        MaterialProperty _uvSet_NormalMapDetail = null;
        MaterialProperty _uvSet_NormalMapForMatCap = null;
        MaterialProperty _uvSet_DetailMap = null;

        MaterialProperty _uvSet_EmissionColorTex = null;

        //
        MaterialProperty _useAlbedoTexModding = null;
        MaterialProperty _controllerAlbedoHSVI_1 = null;
        MaterialProperty _controllerAlbedoHSVI_2 = null;

        MaterialProperty _controllerAlbedoHSVI_3 = null;

        //
        MaterialProperty _PenetratorEnabled = null;
        MaterialProperty _squeeze = null;
        MaterialProperty _SqueezeDist = null;
        MaterialProperty _BulgeOffset = null;
        MaterialProperty _BulgePower = null;
        MaterialProperty _Length = null;
        MaterialProperty _EntranceStiffness = null;
        MaterialProperty _Curvature = null;
        MaterialProperty _ReCurvature = null;
        MaterialProperty _WriggleSpeed = null;
        MaterialProperty _Wriggle = null;
        MaterialProperty _OrificeChannel = null;

        static bool showBasics = false;
        static bool showToonramp = false;
        static bool showSpecularShine = false;
        static bool showReflection = false;
        static bool showRimlights = false;
        static bool showMatcap = false;
        static bool showEmission = false;
        static bool showSSS = false;
        static bool showLightingBehaviour = false;
        static bool showLightMapShiftMasks = false;
        static bool showGeneralMasks = false;
        static bool showNormalmap = false;
        static bool showDetailMask = false;
        static bool showAlphamask = false;
        static bool showStencilHelpers = false;
        static bool showOutline = false;
        static bool showPen = false;

        static bool showExtraAlbedoTextures = false;

        static bool showToonRampHSVI = false;

        // static bool showToonRampEffect = false;
        static bool showSpecWorkF = true;
        static bool showMetalRoughWorkF = false;
        static bool showRimlightOvertone = false;
        static bool showEmission2nd = false;
        static bool showAudioLink = false;

        static bool showToonAreaBlends = false;
        static bool showToonLightBehaviours = false;

        // static bool showBlahA = false;
        // static bool showBlahB = false;
        // static bool showBlahC = false;

        // test
        // static int testInt = 1337;

        //
        bool iscutout = false;
        bool iscutoutAlpha = false;
        bool isDither = false;
        bool isOutline = false;
        bool isDepth = false;
        bool isPen = false;


        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
        {
            // float whatThis = (float)(EditorGUI.GetField("kIndentPerLevel").GetRawConstantValue()); 
            // Debug.Log("blah " + whatThis);
            Material material = materialEditor.target as Material;
            Shader shader = material.shader;

            iscutout = shader.name.Contains("Cutout");
            iscutoutAlpha = shader.name.Contains("AlphaTransparent");
            isDither = shader.name.Contains("Dither");
            isOutline = shader.name.Contains("Outline");
            isDepth = shader.name.Contains("Depth");
            isPen = shader.name.Contains("Pen");
            //
            foreach (var property in GetType().GetFields(bindingFlags))
            {
                if (property.FieldType == typeof(MaterialProperty))
                {
                    try
                    {
                        property.SetValue(this, FindProperty(property.Name, props));
                    }
                    catch
                    {
                        /*Is it really a problem if it doesn't exist?*/
                    }
                }
            }

            //
            EditorGUI.BeginChangeCheck();
            {
                ACLStyles.ShurikenHeaderCentered(ACLStyles.ver);
                ACLStyles.PartingLine();
                materialEditor.ShaderProperty(_ShaderOptimizerEnabled, new GUIContent("Lock Material", ""));
                ACLStyles.PartingLine();
                if (_ShaderOptimizerEnabled.floatValue == 1)
                {
                    EditorGUI.BeginDisabledGroup(true);
                }
                // EditorGUILayout.LabelField("New value----------------------------------------------------------------------");
                // EditorGUILayout.HelpBox("BLAH BLAH BLAH BLAH", MessageType.None, true);
                // testInt = EditorGUILayout.IntField(testInt);


                showBasics = ACLStyles.ShurikenFoldout("Basic Settings", showBasics);
                if (showBasics)
                {
                    EditorGUI.indentLevel++;
                    ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("■ Basic Settings:");
                    // materialEditor.ShaderProperty(_Color, new GUIContent("Diffuse Color", "Primary diffuse color control."));
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Main Texture (Ramp Forward Source)",
                            "Main texture. As Forward Area intended for surface most towards light and the visual effect of being in direct light."),
                        _MainTex, _Color);
                    // materialEditor.ShaderProperty(_Emissive_Color, new GUIContent(" Emission Lum", ""));
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Emission Tint (RGB)", "Source glow color."),
                        _Emissive_Tex, _Emissive_Color);
                    // materialEditor.ShaderProperty(_SpecColor, new GUIContent("Specular Color", "Applies tint on Specular shine and Cubemap color."));
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Specular Mask(RGB). Smoothness(A)",
                            "You must know how \"specular setup\" works. (RGB) intensity means more metallic, lower color saturation means more metallic (reflects without tint from surface). (A) is Smoothness value."),
                        _HighColor_Tex, _SpecColor);
                    materialEditor.ShaderProperty(_Glossiness,
                        new GUIContent("Smoothness",
                            "Follows Standard. Higher reflects the world more perfectly. Affects Shine lobe and Cubemap."));
                    materialEditor.TexturePropertySingleLine(new GUIContent("Normal Map", ""), _NormalMap);
                    ACLStyles.PartingLine();
                    materialEditor.ShaderProperty(_CullMode,
                        new GUIContent("Cull Mode", "Culling backward/forward/no faces"));
                    materialEditor.ShaderProperty(_shadowCastMin_black,
                        new GUIContent("Dynamic Shadows Removal",
                            "Counters undesirable hard dynamic shadow constrasts for NPR styles in maps with strong direct:ambient light contrasts.\nModifies direct light dynamic shadows behaviour: Each Directional/Point/Spot light in the scene has its own shadow settings and this slider at 1.0 \"brightens\" shadows away.\nUse 0.0 for intended PBR."));
                    materialEditor.ShaderProperty(_indirectAlbedoMaxAveScale,
                        new GUIContent("Static GI Max:Ave",
                            "Affect overall brightness in ambient lit maps.\nHow overall Indirect light is sampled by object, abstracted to two sources \"Max\" or \"Average\" color, is used on Diffuse (Toon Ramping).\n1: Use Max color with Average intelligently.\n>1:Strongly switch to Average color as Max color scales brighter, which matches a few NPR shaders behaviour and darkness."));
                    // ACLStyles.PartingLine();
                    // materialEditor.ShaderProperty(_useToonRampSystem, new GUIContent("Use Toon Ramp:", ""));
                    // materialEditor.ShaderProperty(_UseSpecularSystem, new GUIContent("Enable Specular Effects", "Makes visible Direct Light and Cubemap effects.\nWhat is happening is off forces Primary Specular Color black as well as other shine factors off, well still processing roughness."));
                    // materialEditor.ShaderProperty(_useRimLightSystem, new GUIContent("Use RimLights:", ""));
                    // materialEditor.ShaderProperty(_MatCap, new GUIContent("Use Matcaps", "Uses all or none. (Currently this to simplify solving 3 unique matcap systems and hit performance)"));
                    // if (isOutline) {
                    //     materialEditor.ShaderProperty(_useOutline, new GUIContent("Use Outlines", ""));
                    // }
                    ACLStyles.PartingLine();
                    EditorGUI.indentLevel--;
                }

                // ACLStyles.PartingLine();
                //  EditorGUILayout.LabelField("- -");
                showToonramp = ACLStyles.ShurikenFoldout("Diffuse (Toon Ramp Effects)", showToonramp);
                if (showToonramp)
                {
                    EditorGUI.indentLevel++;
                    // materialEditor.TexturePropertySingleLine(new GUIContent("Main Tex", ""), _MainTex, _UVBLAH);
                    // materialEditor.TextureProperty(_MainTex, "bleh", true);
                    // materialEditor.TexturePropertyTwoLines(new GUIContent("Main Tex", "Words 1"), _MainTex, _UVBLAH, new GUIContent("_BAR", "words 2"), _BAR);
                    materialEditor.ShaderProperty(_useToonRampSystem, new GUIContent("Use Toon Ramp:", ""));
                    ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("■ Main Texture Albedo:");
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Main Texture (Ramp Forward Source)",
                            "Main texture. As Forward Area intended for surface most towards light and the visual effect of being in direct light."),
                        _MainTex);
                    EditorGUI.indentLevel++;
                    materialEditor.TextureScaleOffsetProperty(_MainTex);
                    EditorGUI.indentLevel--;
                    // ACLStyles.PartingLine();
                    showExtraAlbedoTextures = ACLStyles.ShurikenFoldout("■ Extra Texture Sources:",
                        showExtraAlbedoTextures,
                        EditorGUI.indentLevel);
                    if (showExtraAlbedoTextures)
                    {
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_useDiffuseAlbedoTexturesSet,
                            new GUIContent("Use Extra Textures:", ""));
                        materialEditor.ShaderProperty(_toonRampTexturesBlendMode,
                            new GUIContent("Texture Mix Mode:",
                                "Swap As: Replaces Area's texture with These.\nThese Textures becomes a tint that multiplies on Main Texture and set in each Area."));
                        ACLStyles.PartingLine();
                        materialEditor.TexturePropertySingleLine(
                            new GUIContent("Core Texture",
                                "If used as source. A NPR helper, \"Core Area\' is intended as the core area were light slowly angles perpendicular and artistically painted NPR effects may occur, for example painted subsurface colouring as light penetrates the acute surface and emits within the surface, or shadows may be painted to hint ambient occlusion(where light cannot enter and leave this sharp angle)."),
                            _1st_ShadeMap);
                        materialEditor.TexturePropertySingleLine(
                            new GUIContent("Backward Texture",
                                "If used as source. A NPR helper, \"Backwards Area\' is intended as the area were direct light cannot hit and artistically painted represents ambient light and no painted on shadows."),
                            _2nd_ShadeMap);
                        EditorGUILayout.LabelField("■ Area Sources:");
                        materialEditor.ShaderProperty(_Use_BaseAs1st,
                            new GUIContent("Ramp Core Source", "Unless you have custom set to MainTex."));
                        materialEditor.ShaderProperty(_Use_1stAs2nd,
                            new GUIContent("Ramp Backward Source", "Unless you have custom set to MainTex."));
                        showToonRampHSVI =
                            ACLStyles.ShurikenFoldout("Area Color Mods:", showToonRampHSVI, EditorGUI.indentLevel);
                        if (showToonRampHSVI)
                        {
                            EditorGUI.indentLevel++;
                            EditorGUILayout.LabelField("■ Area Color Mods:");
                            materialEditor.ShaderProperty(_useAlbedoTexModding, new GUIContent("Use Albedo Mods:", ""));
                            EditorGUI.indentLevel++;
                            materialEditor.ShaderProperty(_controllerAlbedoHSVI_1, new GUIContent("Front HSVI", ""));
                            materialEditor.ShaderProperty(_controllerAlbedoHSVI_2, new GUIContent("Core HSVI", ""));
                            materialEditor.ShaderProperty(_controllerAlbedoHSVI_3, new GUIContent("Back HSVI", ""));
                            EditorGUI.indentLevel--;
                            EditorGUI.indentLevel--;
                            ACLStyles.PartingLine();
                        }

                        EditorGUI.indentLevel--;
                    }

                    // EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("■ Area Tints:");
                    materialEditor.ShaderProperty(_Color,
                        new GUIContent("Primary Diffuse Color", "Primary diffuse color control."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_0_ShadeColor,
                        new GUIContent("├ Forward Color", "See Main (Forward) Texture tooltip."));
                    materialEditor.ShaderProperty(_1st_ShadeColor,
                        new GUIContent("├ Core Color", "See Core Texture tooltip."));
                    materialEditor.ShaderProperty(_2nd_ShadeColor,
                        new GUIContent("└ Backward Color", "See Backward Texture tooltip."));
                    EditorGUI.indentLevel--;
                    EditorGUILayout.LabelField("");
                    EditorGUILayout.LabelField("■ Area Adjustment:");
                    EditorGUILayout.LabelField("■ Core Area:");
                    materialEditor.ShaderProperty(_BaseColor_Step,
                        new GUIContent("Step",
                            "Were Forward Area blends to Core and Core overwraps Backwards Area\n0.5 is perpendicular to direct light."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_BaseShade_Feather,
                        new GUIContent("└ Feather",
                            "Softens warp. Wraps away from light, so increase Step Core as you soften."));
                    EditorGUI.indentLevel--;
                    EditorGUILayout.LabelField("■ Backward Area:");
                    materialEditor.ShaderProperty(_ShadeColor_Step,
                        new GUIContent("Step",
                            "Were Backward Area blends behind & within Core Area.\n0.5 is perpendicular to direct light."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_1st2nd_Shades_Feather,
                        new GUIContent("└ Feather",
                            "Softens warp. Wraps away from light, so increase Backwards Step as you soften."));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                    // EditorGUILayout.LabelField("■■■■■■");
                    showToonAreaBlends =
                        ACLStyles.ShurikenFoldout("Area Blend Behaviours", showToonAreaBlends, EditorGUI.indentLevel);
                    if (showToonAreaBlends)
                    {
                        EditorGUI.indentLevel++;
                        // EditorGUILayout.LabelField("■ Area Blend Behaviours:");
                        materialEditor.ShaderProperty(_Diff_GSF_01,
                            new GUIContent("Diffuse GSF Effect",
                                "Custom Geometric Shadowing Function (GSF) effect to simulate darkening or tinting of diffuse light in rough or penetrable surfaces at acute angles.\nEnabling will reveal The true mixing of regions between Forward/Core/Backaward Areas. Use this to help setup NPR cloth/skin/subsurface/iridescents setups."));
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_DiffGSF_Offset,
                            new GUIContent("├ Offset GSF", "Offset were GSF begins. You may need to use wide values."));
                        materialEditor.ShaderProperty(_DiffGSF_Feather, new GUIContent("└ Feather GSF", "Blurs GSF"));
                        EditorGUI.indentLevel--;
                        EditorGUILayout.LabelField("");
                        materialEditor.ShaderProperty(_useCrossOverRim,
                            new GUIContent("Cross Over Tone",
                                "A outer rim effect that blends the Core and Backwards Area colors depending if your view is with or against the light. Use this for reactive \"Skin\" or roughness looking effects that adopts to the worlds lighting direction.\n This system is independent of the Step ranges of Core and Backwards Area."));
                        EditorGUI.indentLevel++;
                        materialEditor.TexturePropertySingleLine(new GUIContent("├ Mask(G)", "Black means no effect."),
                            _crossOverMask);
                        materialEditor.ShaderProperty(_crossOverSourceTexSource,
                            new GUIContent("├ Albedo Source:", ""));
                        EditorGUI.indentLevel++;
                        materialEditor.TexturePropertySingleLine(
                            new GUIContent("└ Texture",
                                "Texture Albedo, us for things like socking or color tones at sharp angle."),
                            _crossOverAlbedo);
                        EditorGUI.indentLevel--;
                        materialEditor.ShaderProperty(_crossOverTint, new GUIContent("├ Tint", ""));
                        materialEditor.ShaderProperty(_crossOverStep, new GUIContent("├ Step", "Rim start."));
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_crossOverFeather,
                            new GUIContent("└ Feather", "Blur or sharpen."));
                        EditorGUI.indentLevel--;
                        materialEditor.ShaderProperty(_crosspOverRimPow, new GUIContent("├ Curve", "Power curve."));
                        materialEditor.ShaderProperty(_crossOverPinch,
                            new GUIContent("└ Pinch", "Affects Core and Backwards transition sharpness."));
                        EditorGUI.indentLevel--;
                        EditorGUI.indentLevel--;
                    }

                    showLightMapShiftMasks = ACLStyles.ShurikenFoldout("Toon Ramp Shift Masks", showLightMapShiftMasks,
                        EditorGUI.indentLevel);
                    if (showLightMapShiftMasks)
                    {
                        EditorGUI.indentLevel++;
                        EditorGUILayout.LabelField("■ Ambient Occlusion (AO):");
                        materialEditor.ShaderProperty(_uvSet_ShadePosition, new GUIContent("UV AO Set", ""));
                        materialEditor.TexturePropertySingleLine(
                            new GUIContent("Core AO (G)",
                                "Manually forces diffuse \"Forwards\' Area to \'Core\' Area. Use to manually blend toon shadows by texture UV dynamically and union to light angle... which typically if painted on looks \"baked\" or unrealistic.\nYou may use a Ambient Occlusion Texture for this."),
                            _Set_1st_ShadePosition);
                        materialEditor.TexturePropertySingleLine(
                            new GUIContent("Backward AO (G)",
                                "Manually forces diffuse \"Core\' Area to \'Backwards\' Area. Use to manually blend toon shadows by texture UV dynamically and union to light angle... which typically if painted on looks \"baked\" or unrealistic.\nYou may use a Ambient Occlusion Texture for this."),
                            _Set_2nd_ShadePosition);
                        EditorGUILayout.LabelField("");
                        EditorGUILayout.LabelField("■ Light Map System:");
                        materialEditor.ShaderProperty(_UseLightMap,
                            new GUIContent("LightMap Mode",
                                "Overrides Diffuse NPR/PBR toon ramp wrapping according to intensity like a dynamic Ambient Occlusion (AO) mask which reacts to light direction onto the surface.\n50% gray is no change, 100% white is bias towards Bright Area, and 0% black is bias towards Dark Area.\nSetup: Define the Color Areas in Diffuse Reflections (Feather works, Step is ignored); Enable the LightMap with a AO mask; then fine-tune the adjustments below."));
                        EditorGUI.indentLevel++;
                        EditorGUILayout.HelpBox("Hover over LightMap Mode for usage and setup.", MessageType.None,
                            true);
                        EditorGUI.indentLevel--;
                        materialEditor.TexturePropertySingleLine(new GUIContent("LightMap Mask (G)", ""), _LightMap,
                            _uvSet_LightMap);
                        EditorGUI.indentLevel++;
                        materialEditor.TextureScaleOffsetProperty(_LightMap);
                        EditorGUI.indentLevel--;
                        EditorGUILayout.LabelField("");
                        EditorGUILayout.LabelField("■ Light Map Adjustments:");
                        EditorGUI.indentLevel++;
                        EditorGUILayout.HelpBox(
                            "Relevels LightMap's high and low intensity to a new [0,1] clamp.\nAdjust [Z] for darkness and [W] for brightness, and be mindful the 50% gray pivot shifts from this.",
                            MessageType.None, true);
                        EditorGUI.indentLevel--;
                        materialEditor.ShaderProperty(_lightMap_remapArr,
                            new GUIContent("Remap Levels",
                                "Relevels LightMap's high and low intensity to a new [0,1] clamp.\nAdjust [Z] for darkness and [W] for brightness, and 50% means no shift."));
                        EditorGUI.indentLevel++;
                        EditorGUILayout.HelpBox(
                            "By rule: higher value means brighter toon ramp shift by light direction.\nThese adjust the LightMap affect on new Core and Backward Areas.\nOutput = [X] * (Input) + [Y]. First adjest the [y], then deviate [x] from 1.0 (which means no change).",
                            MessageType.None, true);
                        EditorGUI.indentLevel--;
                        materialEditor.ShaderProperty(_toonLambAry_01,
                            new GUIContent("Core Remap",
                                "Maps the LightMap intensity to Core ramp.\nOutput = [X] * (Input) + [Y]"));
                        materialEditor.ShaderProperty(_toonLambAry_02,
                            new GUIContent("Backward Remap",
                                "Maps the LightMap intensity to Backward ramp.\nOutput = [X] * (Input) + [Y]"));
                        EditorGUI.indentLevel--;
                    }

                    showToonLightBehaviours = ACLStyles.ShurikenFoldout("Toon Ramp & Light Harmony",
                        showToonLightBehaviours, EditorGUI.indentLevel);
                    if (showToonLightBehaviours)
                    {
                        EditorGUI.indentLevel++;
                        // EditorGUILayout.LabelField("■ Diffuse/Toon Light Behaviours:");
                        materialEditor.ShaderProperty(_shadeShadowOffset1,
                            new GUIContent("Shadow Offset Core",
                                "NPR effect of \"flooding\" Core Area color within Dynamic Shadows.\nShifts Toon Ramp Core Step By this value."));
                        materialEditor.ShaderProperty(_shadeShadowOffset2,
                            new GUIContent("Shadow Offset Backward",
                                "NPR effect of \"flooding\" Backward Area color within Dynamic Shadows.\nShifts Toon Ramp Backward Step By this value."));
                        materialEditor.ShaderProperty(_ToonRampLightSourceType_Backwards,
                            new GUIContent("Backface Light Mode",
                                "Sets light model on the back facing area to be indirect light and how much. For pbr/npr effects on diffuse backface area.\nAll Light: Adds direct and indirect light together.\nNatural ambient: Closer to PBR, backface is only Indirect light as there is realistically no direct light."));
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_diffuseIndirectDirectSimMix,
                            new GUIContent("└ Mix Direct Light",
                                "Mix Direct Light into Backward Area by amount. A NPR helper to assist Core & Backward's Step/Feather setting's wrap distribution on Indirect light.\nThink of it as how much light transists threw."));
                        EditorGUI.indentLevel--;
                        EditorGUI.indentLevel--;
                    }

                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                }

                //  EditorGUILayout.LabelField("- -");
                showSpecularShine = ACLStyles.ShurikenFoldout("Specular Reflection", showSpecularShine);
                if (showSpecularShine)
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_UseSpecularSystem,
                        new GUIContent("Use Specular Effects",
                            "Makes visible Direct Light and Cubemap effects.\nWhat is happening is off forces Primary Specular Color black as well as other shine factors off, well still processing roughness."));
                    ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("■ Specular Behaviour:");
                    materialEditor.ShaderProperty(_Glossiness,
                        new GUIContent("Smoothness",
                            "Follows Standard. Higher reflects the world more perfectly. Affects Shine lobe and Cubemap."));
                    materialEditor.TextureScaleOffsetProperty(_HighColor_Tex);
                    EditorGUILayout.LabelField("■ Workflow");
                    materialEditor.ShaderProperty(_WorkflowMode,
                        new GUIContent("Workflow Mode:",
                            "Unity Standardised mode for surface Metallic and Smoothness detail on masks."));
                    materialEditor.ShaderProperty(_UseDiffuseEnergyConservation,
                        new GUIContent("Energy Conservation",
                            "ON: PBR, which high Specular Mask Dims Diffuse Effects to conserve Energy and match the Standard Shader Workflow. \nOFF: NPR, which Specular Color Simply Adds on Diffuse Effects."));
                    showSpecWorkF =
                        ACLStyles.ShurikenFoldout("Specular Workflow", showSpecWorkF, EditorGUI.indentLevel);
                    if (showSpecWorkF)
                    {
                        EditorGUI.indentLevel++;
                        EditorGUILayout.LabelField("■ Specular Workflow");
                        materialEditor.ShaderProperty(_SpecColor,
                            new GUIContent("Primary Specular Color",
                                "Applies tint on Specular shine and Cubemap color."));
                        materialEditor.TexturePropertySingleLine(
                            new GUIContent("Specular Mask(RGB). Smoothness(A)",
                                "You must know how \"specular setup\" works. (RGB) intensity means more metallic, lower color saturation means more metallic (reflects without tint from surface). (A) is Smoothness value."),
                            _HighColor_Tex);
                        EditorGUILayout.LabelField("");
                        EditorGUILayout.LabelField("■ Specular Source Fallback");
                        materialEditor.ShaderProperty(_highColTexSource,
                            new GUIContent("Blend Albedo",
                                "If you dont have a custom spec mask, you may borrow and blend the diffuse textures.\nI recommend modifying (V) against blacks, (I) for whites, (S) for metallicness."));
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_SpecularMaskHSV, new GUIContent("Finetune (HSVI)", ""));
                        EditorGUILayout.HelpBox("XYZW -> HSVI. Color adjestment when Blending from Albedo.",
                            MessageType.None, true);
                        EditorGUI.indentLevel--;
                        EditorGUI.indentLevel--;
                    }

                    showMetalRoughWorkF = ACLStyles.ShurikenFoldout("Metallic & Roughness Workflows",
                        showMetalRoughWorkF,
                        EditorGUI.indentLevel);
                    if (showMetalRoughWorkF)
                    {
                        EditorGUI.indentLevel++;
                        EditorGUILayout.LabelField("■ Metallic & Roughness Workflows");
                        materialEditor.ShaderProperty(_Metallicness,
                            new GUIContent("Metallic Tint",
                                "Follows Standard. Higher tints shine with diffuse texture more. Lower sets tint to nearly black."));
                        materialEditor.TexturePropertySingleLine(
                            new GUIContent("Metallic(R). Smoothness(A)", "Metallic workflow mask."), _MetallicGlossMap);
                        EditorGUI.indentLevel++;
                        materialEditor.TexturePropertySingleLine(
                            new GUIContent("Roughness(R)",
                                "Roughness Mask in Roughness workflow. Works with Metallic mask."), _SpecGlossMap);
                        EditorGUI.indentLevel--;
                        materialEditor.ShaderProperty(_SpecOverride,
                            new GUIContent("Specular Hybrid:",
                                "Impart Specular workflow's color into Metallic/Roughness color mixing. Usefull if you want to mod the tint Metallic will grab from main texture (albedo).\nWhen On mix with \"Blend Albedo\"."));
                        EditorGUILayout.LabelField("");
                        EditorGUI.indentLevel--;
                    }

                    EditorGUILayout.LabelField("■ Shine Behaviour");
                    materialEditor.ShaderProperty(_HighColor,
                        new GUIContent("Shine Tint",
                            "Multiplies over Shines color intensity and tints. Can use to shut it off (use black), or overpower in HDR (for controlling Sharp and Soft mode)."));
                    materialEditor.ShaderProperty(_Is_SpecularToHighColor,
                        new GUIContent("Shine Type",
                            "Override Shape and Soft brightness with Shine Tint.\nSharp: Toony\nSoft: Simple and subtle lode\nUnity: Follow Unity's PBR"));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                }

                showReflection = ACLStyles.ShurikenFoldout("Cubemap Reflection Behavour", showReflection);
                if (showReflection)
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_useCubeMap,
                        new GUIContent("Use Cubemap", "Enable sampling of CubeMap."));
                    ACLStyles.PartingLine();
                    materialEditor.ShaderProperty(_CubemapFallbackMode,
                        new GUIContent("Fallback Mode",
                            "Fallback Cubemap intensifies to average lighting.\nSmart: Enables when map gives nothing.\nAlways: Always override with custom."));
                    EditorGUI.indentLevel++;
                    materialEditor.TexturePropertySingleLine(new GUIContent("└ Fallback Cubemap", ""),
                        _CubemapFallback);
                    EditorGUI.indentLevel--;
                    EditorGUILayout.LabelField("");
                    materialEditor.ShaderProperty(_GlossinessMapMode,
                        new GUIContent("GlossMask Mode:",
                            "Mask: GlossMask masks workflow mask.\nReplace: Gloss mask works independent."));
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("GlossMask(RGB).Smoothness(A)",
                            "Reflection override mask, good for custom cubemaps or corrections.\nIn mask mode: (RGB) works as tint. (A) is pivot, use 0.5 gray for no effect.\nIn override (RGB) is tint, (A) is smoothness."),
                        _GlossinessMap);
                    // EditorGUI.indentLevel++;
                    // materialEditor.TextureScaleOffsetProperty(_GlossinessMap);
                    // EditorGUI.indentLevel--;
                    // ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("");
                    materialEditor.ShaderProperty(_ENVMmode,
                        new GUIContent("Control Method",
                            "Standard: Reflection follows Standard formula, Intensity dims and roughness pivots change of roughness around 0.5.\nOverride: You override Intensity and Roughness exactly."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_ENVMix,
                        new GUIContent("├ Intensity",
                            "With Standard: Rescales reflection visability by this.\nWith Override: Replace the intensity and ignores roughness mask."));
                    materialEditor.ShaderProperty(_envRoughness,
                        new GUIContent("└ Smoothness(0.5)",
                            "For Override only. Pivots on 0.5 making Smoothness higher or weaker.\bYou can use this to blur Cubemap into a average."));
                    EditorGUI.indentLevel--;
                    // ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("");
                    materialEditor.ShaderProperty(_EnvGrazeMix,
                        new GUIContent("Use Natural Fresnel",
                            "Natural unmaskable specular at sharp angles linked to Specular."));
                    materialEditor.ShaderProperty(_EnvGrazeRimMix,
                        new GUIContent("Use RimLight Fresnel",
                            "Unmaskable specular at sharp angles linked to Specular.\nUses both Rim Light -/+ settings as mask."));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                }

                showRimlights =
                    ACLStyles.ShurikenFoldout("Rim Lighting (Simplified Cubemap Fresnel Effects)", showRimlights);
                if (showRimlights)
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_useRimLightSystem, new GUIContent("Use RimLights:", ""));
                    ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("■ Primary Rim:");
                    materialEditor.ShaderProperty(_RimLight,
                        new GUIContent("RimLight +",
                            "Rims towards light source.\nAlso activates this as mask for Cubemap Fresnel."));
                    materialEditor.ShaderProperty(_RimLightColor, new GUIContent("├ Color", ""));
                    materialEditor.ShaderProperty(_RimLight_Power, new GUIContent("└ Power", "Wrapping curvature"));
                    EditorGUILayout.LabelField("■ Optional Rim:");
                    materialEditor.ShaderProperty(_Add_Antipodean_RimLight,
                        new GUIContent("RimLight -",
                            "Rim away from light source.\nAlso activates this as mask for Cubemap Fresnel."));
                    materialEditor.ShaderProperty(_Ap_RimLightColor, new GUIContent("├ Color", ""));
                    materialEditor.ShaderProperty(_Ap_RimLight_Power, new GUIContent("└ Power", "Wrapping curvature"));
                    showRimlightOvertone =
                        ACLStyles.ShurikenFoldout("2nd Color", showRimlightOvertone, EditorGUI.indentLevel);
                    if (showRimlightOvertone)
                    {
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_useRimLightOverTone,
                            new GUIContent("2nd Layer Tint",
                                "Blend a 2nd layer tint over (-/+) Forward/Back Rim Lights. Use this to stylize white rim edges or whatever color blends.\nWorks when either Rim is enabled, so shut this off when you are not using it."));
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_rimLightOverToneLow,
                            new GUIContent("├ Low Mask",
                                "Think of the Rim Lights appearance as a Mask that goes [0, 1]; where 0 is nothing and 1 full rim color. Use this slider to mask around the 0 side of the range."));
                        materialEditor.ShaderProperty(_rimLightOverToneHigh,
                            new GUIContent("├ High Mask",
                                "Think of the Rim Lights appearance as a Mask that goes [0, 1]; where 0 is nothing and 1 full rim color. Use this slider to mask around the 1 side of the range."));
                        materialEditor.ShaderProperty(_rimLightOverToneBlendColor1,
                            new GUIContent("├ + Color", "Color on + Rim."));
                        materialEditor.ShaderProperty(_rimLightOverToneBlendColor2,
                            new GUIContent("└ - Color", "Color on - Rim."));
                        EditorGUI.indentLevel--;
                        EditorGUI.indentLevel--;
                        EditorGUILayout.LabelField("");
                    }

                    EditorGUILayout.LabelField("■ Direction Behaviour:");
                    materialEditor.ShaderProperty(_LightDirection_MaskOn,
                        new GUIContent("Light direction mode",
                            "Enables masking by light direction and dual + and - mode. Off makes + a simple overrap."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_Tweak_LightDirection_MaskLevel,
                        new GUIContent("└ Polarize", "Split + and - more by light direction."));
                    EditorGUI.indentLevel--;
                    EditorGUILayout.LabelField("■ Wrap Behaviour:");
                    materialEditor.ShaderProperty(_RimLightAreaOffset,
                        new GUIContent("Offset Wrap",
                            "Shifts RimLights \"warp\". To control how the high and low of the rim curve appear."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_RimLight_InsideMask,
                        new GUIContent("└ Sharpness", "Tampers falloff to a shaper edge. Good for toony lines."));
                    EditorGUI.indentLevel--;
                    EditorGUILayout.LabelField("");
                    EditorGUILayout.LabelField("■ Texture Color:");
                    materialEditor.ShaderProperty(_rimAlbedoMix,
                        new GUIContent("Mix Albedo", "Mix to tint RimLight by source texture."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_RimLightSource,
                        new GUIContent("└ Source",
                            "Diffuse: Good for Matching Skin\"subsurface\" tones.\nSpecular: Good to match metallic tones as set in your Specular Color settings."));
                    EditorGUI.indentLevel--;
                    EditorGUILayout.LabelField("");
                    EditorGUILayout.LabelField("■ Light Model:");
                    materialEditor.ShaderProperty(_rimLightLightsourceType,
                        new GUIContent("Light: Diffuse:Cubemap",
                            "Light Rim Lights like a surface diffuse or Cubemap. First good for subsurface effects and 2nd for metallic/smoothness effect."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_envOnRim,
                        new GUIContent("└ Mix Ave:Cubemap",
                            "Masks Rim Lighting by simple ambience to Cubemap colors. Uses Cubemap settings. I recommend overriding Cubemap Fallback and Roughness settings when applying this."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_envOnRimColorize,
                        new GUIContent("└ Colorize", "Scale from grayscale to color."));
                    EditorGUI.indentLevel--;
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                    EditorGUI.indentLevel--;
                }

                // ACLStyles.PartingLine();
                //  EditorGUILayout.LabelField("- -");
                showMatcap = ACLStyles.ShurikenFoldout("Matcap Controls", showMatcap);
                if (showMatcap)
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_MatCap,
                        new GUIContent("Use Matcaps",
                            "Uses all or none. (Currently this to simplify solving 3 unique matcap systems and hit performance)"));
                    ACLStyles.PartingLine();
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Diffuse Type (x+)",
                            "Use this for \"baked\" toon ramp, subsurface, or iridescent Matcaps. It multiplies on the Diffuse Texture and then adds result. Lighting is Direct(with shadows) + Indirect.\nMasked by Diffuse Matcap Mask."),
                        _MatCapTexMult, _MatCapColMult);
                    materialEditor.ShaderProperty(_McDiffAlbedoMix,
                        new GUIContent("└ Diffuse Albedo Mix",
                            "How much of diffuse texture to mix in diffuse matcap."));
                    materialEditor.ShaderProperty(_matcapSmoothnessSource1,
                        new GUIContent("Blur Source:",
                            "Blur Matcap by Specular Smoothness settings or override your own."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_BlurLevelMatcap1,
                        new GUIContent("└ Smoothness", "Manual override of blur."));
                    EditorGUI.indentLevel--;
                    EditorGUILayout.LabelField("");
                    materialEditor.ShaderProperty(_useMCHardMult,
                        new GUIContent("Use Multiply Type",
                            "Keep off when not used so it will not affect diffuse coloring."));
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Multiply Type (x)",
                            "Multiplies on the albedo textures. Will always affect diffuse effects."),
                        _MatCapTexHardMult,
                        _MatCapColHardMult);
                    materialEditor.ShaderProperty(_matcapSmoothnessSource3,
                        new GUIContent("Blur Source:",
                            "Blur Matcap by Specular Smoothness settings or override your own."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_BlurLevelMatcap3,
                        new GUIContent("└ Smoothness", "Manual override of blur."));
                    EditorGUI.indentLevel--;
                    EditorGUILayout.LabelField("");
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Specular Type (+)",
                            "Use this for \"baked\" Specular Reflection Matcaps. Intensity works like Cubemap Fallback.\nMasked by Global Specular Mask."),
                        _MatCapTexAdd, _MatCapColAdd);
                    materialEditor.ShaderProperty(_matcapSmoothnessSource0,
                        new GUIContent("Blur Source:",
                            "Blur Matcap by Specular Smoothness settings or override your own."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_BlurLevelMatcap0,
                        new GUIContent("└ Smoothness", "Manual override of blur."));
                    EditorGUI.indentLevel--;
                    EditorGUILayout.LabelField("");
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Emission Type",
                            "Adds in texture and scales to HDR Color as set.\nMasked by Emission masks."),
                        _MatCapTexEmis,
                        _MatCapColEmis);
                    materialEditor.ShaderProperty(_matcapSmoothnessSource2,
                        new GUIContent("Blur Source:",
                            "Blur Matcap by Specular Smoothness settings or override your own."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_BlurLevelMatcap2,
                        new GUIContent("└ Smoothness", "Manual override of blur."));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("■ Texture Transforms:");
                    materialEditor.ShaderProperty(_CameraRolling_Stabilizer,
                        new GUIContent("Roll Stabilizer",
                            "Envokes \"world upright\" matcaps by turning the matcap against your head roll. Used for fake hair shine and other specular effects."));
                    materialEditor.ShaderProperty(_Rotate_MatCapUV, new GUIContent("Rotate UV", ""));
                    materialEditor.ShaderProperty(_Tweak_MatCapUV, new GUIContent("Scale UV", ""));
                    EditorGUILayout.LabelField("");
                    EditorGUILayout.LabelField("■ NormalMap Controls:");
                    materialEditor.ShaderProperty(_Is_NormalMapForMatCap,
                        new GUIContent("Use Normal Map", "Distort Matcaps by unique Normals."));
                    materialEditor.TexturePropertySingleLine(new GUIContent("Normal Map", ""), _NormalMapForMatCap,
                        _uvSet_NormalMapForMatCap);
                    EditorGUI.indentLevel++;
                    materialEditor.TextureScaleOffsetProperty(_NormalMapForMatCap);
                    EditorGUI.indentLevel--;
                    materialEditor.ShaderProperty(_Rotate_NormalMapForMatCapUV, new GUIContent("└ Rotate UV", ""));
                    EditorGUILayout.LabelField("");
                    EditorGUILayout.LabelField("■ Masks:");
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Global Mask(RGBA)",
                            "(Have texture sRGB off)\nR: Diffuse Mask\nG: Multi Mask\nB: Specular\nA: Emission"),
                        _Set_MatcapMask);
                    EditorGUI.indentLevel++;
                    materialEditor.TextureScaleOffsetProperty(_Set_MatcapMask);
                    EditorGUI.indentLevel--;
                    materialEditor.ShaderProperty(_Tweak_MatcapMaskLevel, new GUIContent("Tweak Mask", ""));
                    materialEditor.ShaderProperty(_matcapSpecMaskSwitch, new GUIContent("Spec Mask source:", ""));
                    materialEditor.ShaderProperty(_matcapEmissMaskSwitch, new GUIContent("Emission Mask source", ""));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                }

                showSSS = ACLStyles.ShurikenFoldout("SubSurface Controls", showSSS);
                if (showSSS)
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_useSSS, new GUIContent("Use Subsurface Lighting", ""));
                    ACLStyles.PartingLine();
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Thickness Mask(G)",
                            "Gives inner volume with pre-baked mask.\nCreate by backing AO with a faces INVERTED in Blender or similar 3d programs."),
                        _SSSThicknessMask);
                    ACLStyles.PartingLine();
                    materialEditor.ShaderProperty(_SSSColThin, new GUIContent("└ Thin Color", ""));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_SSSColThick, new GUIContent("├ Thick Tint", ""));
                    materialEditor.ShaderProperty(_SSSDepthColL, new GUIContent("├ High Density Range", ""));
                    materialEditor.ShaderProperty(_SSSDepthColH, new GUIContent("└ Low Density Range", ""));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                    materialEditor.ShaderProperty(_useFakeSSS, new GUIContent("Use Fake SSS", ""));
                    materialEditor.ShaderProperty(_SSSLensFake, new GUIContent("├ Fake Lens", ""));
                    materialEditor.ShaderProperty(_SSSDensityFake, new GUIContent("└ Fake Depth", ""));
                    ACLStyles.PartingLine();
                    if (isDepth)
                    {
                        EditorGUILayout.HelpBox(
                            "Setup requires \"_Write_Depth\" shader applied on used (skin)mesh copies to get depth from back face to front face mesh.\nAll mesh should be closed hull (no gaps in space) for correct depth results.",
                            MessageType.None, true);
                        materialEditor.ShaderProperty(_useRealSSS, new GUIContent("Use Depth SSS", ""));
                        materialEditor.ShaderProperty(_depthMaxScale, new GUIContent("├ Depth Max Scale", ""));
                        materialEditor.ShaderProperty(_SSSDensityReal, new GUIContent("└ Real Density", ""));
                        ACLStyles.PartingLine();
                        materialEditor.ShaderProperty(_SSSRim, new GUIContent("Rim Lens", ""));
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_SSSColRim, new GUIContent("├ Rim Color", ""));
                        materialEditor.ShaderProperty(_SSSRimMaskL, new GUIContent("├ High Rim Range", ""));
                        materialEditor.ShaderProperty(_SSSRimMaskH, new GUIContent("└ Low Rim Range", ""));
                        EditorGUI.indentLevel--;
                    }
                    else
                    {
                        EditorGUILayout.HelpBox("Volume Depth SSS available in the \"_Solid_Depth\" shader.",
                            MessageType.None, true);
                    }

                    ACLStyles.PartingLine();
                    materialEditor.ShaderProperty(_SSSLens, new GUIContent("Light Lens", ""));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                }

                showEmission = ACLStyles.ShurikenFoldout("Emission Controls", showEmission);
                if (showEmission)
                {
                    EditorGUI.indentLevel++;
                    EditorGUILayout.LabelField("■ Primary Color:");
                    materialEditor.ShaderProperty(_Emissive_Color, new GUIContent("Color Lum", ""));
                    materialEditor.ShaderProperty(_emissionProportionalLum,
                        new GUIContent("Adaptive Lum",
                            "For Unrealistic proportional glow to world brightness. Scales color to the average lighting. You might want intensity higher than Emission Color's intensity."));
                    materialEditor.TexturePropertySingleLine(new GUIContent("Color Tint (RGB)", "Source glow color."),
                        _Emissive_Tex, _uvSet_EmissionColorTex);
                    EditorGUI.indentLevel++;
                    materialEditor.TextureScaleOffsetProperty(_Emissive_Tex);
                    EditorGUI.indentLevel--;
                    EditorGUILayout.LabelField("");
                    EditorGUILayout.LabelField("■ Hard Mask:");
                    materialEditor.ShaderProperty(_emissionUseMask, new GUIContent("Use Mask", ""));
                    EditorGUI.indentLevel++;
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Area mask (G)",
                            "A stronger override mask. If set bright areas will only glow. Can use this for pairing with Color Tint textures."),
                        _EmissionColorTex);
                    EditorGUI.indentLevel++;
                    materialEditor.TextureScaleOffsetProperty(_EmissionColorTex);
                    EditorGUI.indentLevel--;
                    materialEditor.ShaderProperty(_emissiveUseMainTexA, new GUIContent("├ Or Use MainTexure (A)", ""));
                    materialEditor.ShaderProperty(_emissionUseMaskDiffuseDimming,
                        new GUIContent("└ Mask Dims Diffuse", ""));
                    EditorGUI.indentLevel--;
                    showEmission2nd = ACLStyles.ShurikenFoldout("Rim Emission", showEmission2nd, EditorGUI.indentLevel);
                    if (showEmission2nd)
                    {
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_emissionUse2ndTintRim, new GUIContent("Use Rim Emission", ""));
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_Emissive_Color2, new GUIContent("├ Color", ""));
                        materialEditor.TexturePropertySingleLine(new GUIContent("├ Albedo Tint (RGB)", ""),
                            _EmissionColorTex2);
                        EditorGUI.indentLevel++;
                        materialEditor.TextureScaleOffsetProperty(_EmissionColorTex2);
                        EditorGUI.indentLevel--;
                        materialEditor.ShaderProperty(_emission2ndTintLow,
                            new GUIContent("├ Low Range", "Rim transition starts at 0.5 and full at 1.0."));
                        materialEditor.ShaderProperty(_emission2ndTintHigh,
                            new GUIContent("├ High Range", "Rim transition starts at 0.5 and full at 1.0."));
                        materialEditor.ShaderProperty(_emission2ndTintPow,
                            new GUIContent("└ Power", "Arch curve the mask from 0.0001 to 256. 1.0 is no effect."));
                        EditorGUI.indentLevel--;
                        EditorGUI.indentLevel--;
                    }

                    showAudioLink = ACLStyles.ShurikenFoldout("SCSS Emission", showAudioLink, EditorGUI.indentLevel);
                    if (showAudioLink)
                    {
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_UseAdvancedEmission, _UseAdvancedEmission.displayName);
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_DetailEmissionMap, _DetailEmissionMap.displayName);
                        materialEditor.ShaderProperty(_DetailEmissionUVSec, _DetailEmissionUVSec.displayName);

                        materialEditor.ShaderProperty(_EmissionDetailType, _EmissionDetailType.displayName);
                        EditorGUI.indentLevel++;

                        GUILayout.Space(15);


                        switch ((DetailEmissionMode)material.GetFloat("_EmissionDetailType"))
                        {
                            case DetailEmissionMode.Phase:
                                //materialEditor.ShaderProperty(_EmissionDetailParams, _EmissionDetailParams.displayName);
                                Vector2Property(_EmissionDetailParams, new GUIContent("Sets the scrolling speed for the emission detail texture."));
                                Vector2PropertyZW(_EmissionDetailParams, new GUIContent("Phase/Pulse	Sets the phase of the emission detail texture. X controls the pulsing speed, and Y controls the phase. The higher the phase, the shorter the interval between repetitions."));
                                break;

                            case DetailEmissionMode.AudioLink:
                                materialEditor.ShaderProperty(_alColorR, _alColorR.displayName);
                                materialEditor.ShaderProperty(_alColorG, _alColorG.displayName);
                                materialEditor.ShaderProperty(_alColorB, _alColorB.displayName);
                                materialEditor.ShaderProperty(_alColorA, _alColorA.displayName);
                                materialEditor.ShaderProperty(_alBandR, _alBandR.displayName);
                                materialEditor.ShaderProperty(_alBandG, _alBandG.displayName);
                                materialEditor.ShaderProperty(_alBandB, _alBandB.displayName);
                                materialEditor.ShaderProperty(_alBandA, _alBandA.displayName);
                                materialEditor.ShaderProperty(_alModeR, _alModeR.displayName);
                                materialEditor.ShaderProperty(_alModeG, _alModeG.displayName);
                                materialEditor.ShaderProperty(_alModeB, _alModeB.displayName);
                                materialEditor.ShaderProperty(_alModeA, _alModeA.displayName);
                                materialEditor.ShaderProperty(_alTimeRangeR, _alTimeRangeR.displayName);
                                materialEditor.ShaderProperty(_alTimeRangeG, _alTimeRangeG.displayName);
                                materialEditor.ShaderProperty(_alTimeRangeB, _alTimeRangeB.displayName);
                                materialEditor.ShaderProperty(_alTimeRangeA, _alTimeRangeA.displayName);
                                materialEditor.ShaderProperty(_alUseFallback, _alUseFallback.displayName);
                                materialEditor.ShaderProperty(_alFallbackBPM, _alFallbackBPM.displayName);
                                materialEditor.ShaderProperty(_UseEmissiveLightSense, _UseEmissiveLightSense.displayName);
                                materialEditor.ShaderProperty(_EmissiveLightSenseStart, _EmissiveLightSenseStart.displayName);
                                materialEditor.ShaderProperty(_EmissiveLightSenseEnd, _EmissiveLightSenseEnd.displayName);
                                break;
                        }

                        EditorGUI.indentLevel--;
                        EditorGUI.indentLevel--;
                        EditorGUI.indentLevel--;
                    }

                    // ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("");
                    EditorGUILayout.LabelField("■ Options:");
                    materialEditor.ShaderProperty(_emissionMixTintDiffuseSlider,
                        new GUIContent("Mix Diffuse Color", ""));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_emisLightSourceType,
                        new GUIContent("└ Diffuse Source:",
                            "Other than MainTex, other source texures must be calibrated under Diffuse Extra textures settings."));
                    EditorGUI.indentLevel--;
                    // materialEditor.ShaderProperty(_emissiveUseMainTexCol, new GUIContent("Tint from MainTex(RGBA)", ""));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                }

                if (iscutout || iscutoutAlpha || isDither)
                {
                    showAlphamask = ACLStyles.ShurikenFoldout("Alpha Settings", showAlphamask);
                    if (showAlphamask)
                    {
                        EditorGUI.indentLevel++;
                        if (iscutoutAlpha)
                        {
                            materialEditor.ShaderProperty(_ZWrite,
                                new GUIContent("ZWrite",
                                    "Depth sorting. Recommend Off for alpha mesh that does not overlay self.\nOn: when strange sort layering happens.\nUsing Transparency Render Queue requires having this off."));
                            ACLStyles.PartingLine();
                        }

                        materialEditor.ShaderProperty(_IsBaseMapAlphaAsClippingMask,
                            new GUIContent("Alpha Mask Source",
                                "Main Texture: The typical source alpha.\nClipping mask: Use a swappable alpha mask if you reuse a Diffuse Main Texture that wants variant alpha cutout zones... such as outfit masking."));
                        EditorGUI.indentLevel++;
                        materialEditor.TexturePropertySingleLine(
                            new GUIContent("Clipping mask (G)", "If used. As a Alpha Mask Black 0.0 is invisible"),
                            _ClippingMask);
                        EditorGUI.indentLevel++;
                        materialEditor.TextureScaleOffsetProperty(_ClippingMask);
                        EditorGUI.indentLevel -= 2;
                        ACLStyles.PartingLine();
                        materialEditor.ShaderProperty(_Inverse_Clipping, new GUIContent("Inverse Alpha", ""));
                        materialEditor.ShaderProperty(_Clipping_Level,
                            new GUIContent("Cutout level", "Clip out mesh were alpha is below this."));
                        materialEditor.ShaderProperty(_Tweak_transparency,
                            new GUIContent("Tweak Alpha", "Fine tune visible alpha. Good for Dithering adjustment."));
                        ACLStyles.PartingLine();
                        if (iscutoutAlpha)
                        {
                            materialEditor.ShaderProperty(_UseSpecAlpha,
                                new GUIContent("Specular Alpha Mode",
                                    "Make specular reflections visible as a PBR effect.\nAlpha: Alpha only drives visibility.\nReflect: PBR like glass, shine is visible no matter how transparent.\nRecommend Reflect mode paired with Render Queue set to Transparent for PBR consistency."));
                            ACLStyles.PartingLine();
                        }

                        materialEditor.ShaderProperty(_DetachShadowClipping,
                            new GUIContent("Split Shadow Cutout",
                                "Control for dynamic shadows on alpha mesh. Designed so avatar effects like \"Blushes\" or \"Emotes panels\" do not artifact to dynamic shadow."));
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_Clipping_Level_Shadow,
                            new GUIContent("Shadow Cutout level", "Proportional to Cutout level."));
                        EditorGUI.indentLevel--;
                        EditorGUI.indentLevel--;
                        ACLStyles.PartingLine();
                    }
                }

                if (isOutline)
                {
                    showOutline = ACLStyles.ShurikenFoldout("Toon Outline Controls", showOutline);
                    if (showOutline)
                    {
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_useOutline, new GUIContent("Use Outlines", ""));
                        ACLStyles.PartingLine();
                        EditorGUILayout.LabelField("■ Colors:");
                        materialEditor.ShaderProperty(_Outline_Color, new GUIContent("Outline Color", ""));
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_Is_BlendBaseColor, new GUIContent("Use Main Tex", ""));
                        materialEditor.ShaderProperty(_Is_OutlineTex, new GUIContent("Use Outline Tex", ""));
                        EditorGUI.indentLevel--;
                        materialEditor.TexturePropertySingleLine(new GUIContent("└ Outline Albedo(RGB)", ""),
                            _OutlineTex);
                        EditorGUI.indentLevel++;
                        materialEditor.TextureScaleOffsetProperty(_Outline_Sampler);
                        EditorGUI.indentLevel--;
                        ACLStyles.PartingLine();
                        EditorGUILayout.LabelField("■ Shape Controls:");
                        materialEditor.TexturePropertySingleLine(
                            new GUIContent("Thickness Mask(R)", "White: Full thickness, 50%: Half, 0%: Clips out."),
                            _Outline_Sampler);
                        materialEditor.ShaderProperty(_Outline_Width, new GUIContent("Outline Thickness", ""));
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_Farthest_Distance,
                            new GUIContent("├ Near Distance",
                                "Surface to camera distance less than this have zero thickness."));
                        materialEditor.ShaderProperty(_Nearest_Distance,
                            new GUIContent("└ Far Distance",
                                "Surface to camera distance greater than this have full thickness."));
                        EditorGUI.indentLevel--;
                        materialEditor.ShaderProperty(_Offset_Z,
                            new GUIContent("Camera Depth",
                                "Pulls Outline towards/away from camera for depth sorting. Do use small values."));
                        if (iscutout || iscutoutAlpha || isDither)
                        {
                            materialEditor.ShaderProperty(_fillOutlineDepth,
                                new GUIContent("Depth Fill Outlines",
                                    "For alpha and outlines:\nEnable to prevent seeing outlines on back-facing mesh.\nDisable when seeing weird sorting and lighting issues."));
                        }
                        else
                        {
                            EditorGUILayout.LabelField("");
                        }

                        ACLStyles.PartingLine();
                        EditorGUILayout.LabelField("■ Emission Controls:");
                        materialEditor.ShaderProperty(_outlineEmissionColor, new GUIContent("Emission Color", ""));
                        materialEditor.TexturePropertySingleLine(new GUIContent("Emission Tint(RGBA)", ""),
                            _outlineEmissionTint);
                        EditorGUI.indentLevel++;
                        materialEditor.TextureScaleOffsetProperty(_outlineEmissionTint);
                        EditorGUI.indentLevel--;
                        EditorGUILayout.LabelField("■ Emission Mask:");
                        materialEditor.ShaderProperty(_outlineEmissionUseMask, new GUIContent("Use Mask:", ""));
                        EditorGUI.indentLevel++;
                        materialEditor.TexturePropertySingleLine(new GUIContent("└ Mask(G)", ""), _outlineEmissionMask);
                        EditorGUI.indentLevel++;
                        materialEditor.TextureScaleOffsetProperty(_outlineEmissionMask);
                        EditorGUI.indentLevel--;
                        EditorGUI.indentLevel--;
                        ACLStyles.PartingLine();
                        materialEditor.ShaderProperty(_outlineEmissiveProportionalLum,
                            new GUIContent("Proportional Lumination", ""));
                        EditorGUI.indentLevel--;
                    }
                }

                // ACLStyles.PartingLine();
                //  EditorGUILayout.LabelField("- -");
                showGeneralMasks = ACLStyles.ShurikenFoldout("General Effect Masks", showGeneralMasks);
                if (showGeneralMasks)
                {
                    EditorGUI.indentLevel++;
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Global Specular Mask",
                            "Hides all specular output.\nAlso masks Specular Matcap."),
                        _Set_HighColorMask);
                    EditorGUI.indentLevel++;
                    materialEditor.TextureScaleOffsetProperty(_Set_HighColorMask);
                    materialEditor.ShaderProperty(_Tweak_HighColorMaskLevel, new GUIContent("Tweak Mask", ""));
                    EditorGUI.indentLevel--;
                    materialEditor.TexturePropertySingleLine(new GUIContent("Rim Light Mask", ""), _Set_RimLightMask);
                    EditorGUI.indentLevel++;
                    materialEditor.TextureScaleOffsetProperty(_Set_RimLightMask);
                    materialEditor.ShaderProperty(_Tweak_RimLightMaskLevel, new GUIContent("Tweak Mask", ""));
                    EditorGUI.indentLevel--;
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                }

                showNormalmap = ACLStyles.ShurikenFoldout("Normal Maps", showNormalmap);
                if (showNormalmap)
                {
                    EditorGUI.indentLevel++;
                    materialEditor.TexturePropertySingleLine(new GUIContent("Normal Map", ""), _NormalMap);
                    EditorGUI.indentLevel++;
                    materialEditor.TextureScaleOffsetProperty(_NormalMap);
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                    materialEditor.ShaderProperty(_DetailNormalMapScale01,
                        new GUIContent("Detail Scaling", "None 0.0 enables the Detail Normal Map."));
                    EditorGUI.indentLevel++;
                    materialEditor.TexturePropertySingleLine(new GUIContent("Detail Normal Map", ""), _NormalMapDetail,
                        _uvSet_NormalMapDetail);
                    EditorGUI.indentLevel++;
                    materialEditor.TextureScaleOffsetProperty(_NormalMapDetail);
                    EditorGUI.indentLevel--;
                    materialEditor.TexturePropertySingleLine(new GUIContent("Detail Mask (G)", ""), _DetailNormalMask);
                    EditorGUI.indentLevel++;
                    materialEditor.TextureScaleOffsetProperty(_DetailNormalMask);
                    EditorGUI.indentLevel -= 2;
                    ACLStyles.PartingLine();
                    materialEditor.ShaderProperty(_Is_NormalMapToBase, new GUIContent("Apply to Diffuse", ""));
                    materialEditor.ShaderProperty(_Is_NormalMapToHighColor, new GUIContent("Apply to Specular", ""));
                    materialEditor.ShaderProperty(_Is_NormalMapToRimLight,
                        new GUIContent("Apply to Rim Lights", "When used alone can allow a NPR \"weavy\" rim effect."));
                    materialEditor.ShaderProperty(_Is_NormaMapToEnv,
                        new GUIContent("Apply to Cubemap",
                            "Disable for a cheap NPR glossy effect against normalmapped others."));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                }

                showDetailMask = ACLStyles.ShurikenFoldout("Detail Masks", showDetailMask);
                if (showDetailMask)
                {
                    EditorGUI.indentLevel++;
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Detail Map (RB)",
                            "(R): Details albedo by intensity off from 50%.\n(B): Details smoothness by intensity off from 50%."),
                        _DetailMap, _uvSet_DetailMap);
                    EditorGUI.indentLevel++;
                    materialEditor.TextureScaleOffsetProperty(_DetailMap);
                    EditorGUI.indentLevel--;
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("DetailMask (RB)", "Masks the Detail Map by respective channels."), _DetailMask);
                    EditorGUILayout.LabelField("■ Intensities:");
                    materialEditor.ShaderProperty(_DetailAlbedo, new GUIContent("Albedo Intensity", ""));
                    materialEditor.ShaderProperty(_DetailSmoothness, new GUIContent("Smoothness Intensity", ""));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                }

                // ACLStyles.PartingLine();
                //  EditorGUILayout.LabelField("- -");
                showLightingBehaviour = ACLStyles.ShurikenFoldout("General Lighting Behaviour", showLightingBehaviour);
                if (showLightingBehaviour)
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_CullMode,
                        new GUIContent("Cull Mode", "Culling backward/forward/no faces"));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_backFaceColorTint,
                        new GUIContent("└ Backface Color Tint",
                            "Back face color. Use to tint backfaces in certain mesh setups.\nRecommend creating actual backface mesh as backfaces reveals depth sorting issues and line artifacts."));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("■ Direct Light Adjustments:");
                    materialEditor.ShaderProperty(_directLightIntensity,
                        new GUIContent("Direct Light Intensity",
                            "Soft counter for overbright maps. Dim direct light sources and thus rely more on map ambient."));
                    materialEditor.ShaderProperty(_shadowCastMin_black,
                        new GUIContent("Dynamic Shadows Removal",
                            "Counters undesirable hard dynamic shadow constrasts for NPR styles in maps with strong direct:ambient light contrasts.\nModifies direct light dynamic shadows behaviour: Each Directional/Point/Spot light in the scene has its own shadow settings and this slider at 1.0 \"brightens\" shadows away.\nUse 0.0 for intended PBR."));
                    EditorGUI.indentLevel++;
                    materialEditor.TexturePropertySingleLine(
                        new GUIContent("Dynamic Shadows Mask (G)",
                            "Works like Realtime Shadows Removal. Texture brightness removes like the slider value."),
                        _DynamicShadowMask);
                    EditorGUI.indentLevel--;
                    materialEditor.ShaderProperty(_shadowUseCustomRampNDL,
                        new GUIContent("Use Direct Falloff",
                            "Force natural PBR Dynamic Light falloff from light. This falloff is also natural Dynamic Shadow."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_shadowNDLStep,
                        new GUIContent("├ Step",
                            "Angle Falloff begins.\nRecommend setting so complete shadow is perpendicular to light.\nDefault: 1. NPR: 0.52"));
                    materialEditor.ShaderProperty(_shadowNDLFeather,
                        new GUIContent("└ Feather",
                            "Softness of falloff. Recommend adjesting so complete shadow is perpendicular to light.\nDefault: 0.5. NPR: 0.025"));
                    EditorGUI.indentLevel--;
                    EditorGUILayout.LabelField("■ Shadow Filters:");
                    materialEditor.ShaderProperty(_shadowSplits,
                        new GUIContent("Shadow Steps",
                            "Use this for stylizing NPR by settings \"Steps\" of intensity."));
                    materialEditor.ShaderProperty(_shadowMaskPinch,
                        new GUIContent("Shadow Pinch",
                            "\"Pinches\" the frindge zone were shadow transitions from nothing to complete.\nUse this to stylize shadow as NPR."));
                    EditorGUILayout.LabelField("■ Shadow On Speculars:");
                    materialEditor.ShaderProperty(_TweakHighColorOnShadow,
                        new GUIContent("Specular Shadow Reactivity",
                            "Affects Shine lobe's dimming in dynamic shadow. 0.0 is ignore dynamic shadows completely."));
                    materialEditor.ShaderProperty(_TweakMatCapOnShadow,
                        new GUIContent("Specular Matcap Shadow Reactivity",
                            "Specular matcaps visibility in dynamic shadow. This depends on context looking like it reacts to direct light or not. 0.0 ignores masking by dynamic shadows."));
                    ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("■ Indirect Light Adjestments:");
                    materialEditor.ShaderProperty(_indirectAlbedoMaxAveScale,
                        new GUIContent("Static GI Max:Ave",
                            "How overall Indirect light is sampled by object, abstracted to two sources \"Max\" or \"Average\" color, is used on Diffuse (Toon Ramping).\n1: Use Max color with Average intelligently.\n>1:Strongly switch to Average color as Max color scales brighter, which matches a few NPR shaders behaviour and darkness."));
                    materialEditor.ShaderProperty(_indirectGIDirectionalMix,
                        new GUIContent("Indirect GI Directionality",
                            "How Indirect light is sampled in the scene.\n0: Use a simple statistical color by object position.\n1: Use surface angle to light, which is PBR."));
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_indirectGIBlur,
                        new GUIContent("└ Angular GI Blur",
                            "Default 1.\nRaise to blur Indirect GI and reduce distinctness of surface angle. Good for converting Indirect GI from PRB to NPR."));
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                    EditorGUILayout.LabelField("■ World Brightness Controls:");
                    materialEditor.ShaderProperty(_forceLightClamp,
                        new GUIContent("Scene Light Clamping",
                            "Hard Counter for overbright maps.\nHDR: When map has correctly setup \"Exposure High Definition Range (HDR)\": balancing brightness with post proccess in a realistic range.\nLimit: Prevention when map overblows your avatar colors or you glow. These maps typically attempted \"Low Definition Range (LDR)\" light levelling, were it assumes scene lights are never over 100% white and toon shaders may clamp to 100% as enforcement rule, and that only emission light goes over 100% which causes bloom."));
                    if (!(iscutoutAlpha))
                    {
                        materialEditor.ShaderProperty(_BlendOp,
                            new GUIContent("Additional Lights Blending",
                                "How realtime Point and Spot lights combine color.\nRecommend MAX for NPR lighting that reduces overblowing color in none \"Exposure HDR\" maps (See Scene Light clamping for def).\nAdd: PBR,If you trust the maps lighting set for correct light adding.\nNot usable in Alpha Transparent due to Premultiply alpha blending needing ADD."));
                    }
                    else
                    {
                        EditorGUILayout.LabelField("[Disabled] Additional Lights Blending");
                    }

                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                }

                if (isPen)
                {
                    showPen = ACLStyles.ShurikenFoldout("DPS System", showPen);
                    if (showPen)
                    {
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_PenetratorEnabled, new GUIContent("Use Penetrator"));
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(_squeeze, new GUIContent("Squeeze"));
                        materialEditor.ShaderProperty(_SqueezeDist, new GUIContent("SqueezeDist"));
                        materialEditor.ShaderProperty(_BulgeOffset, new GUIContent("BulgeOffset"));
                        materialEditor.ShaderProperty(_BulgePower, new GUIContent("BulgePower"));
                        materialEditor.ShaderProperty(_Length, new GUIContent("Penetrator Length"));
                        materialEditor.ShaderProperty(_EntranceStiffness, new GUIContent("EntranceStiffness"));
                        materialEditor.ShaderProperty(_Curvature, new GUIContent("Curvature"));
                        materialEditor.ShaderProperty(_ReCurvature, new GUIContent("ReCurvature"));
                        materialEditor.ShaderProperty(_WriggleSpeed, new GUIContent("WriggleSpeed"));
                        materialEditor.ShaderProperty(_Wriggle, new GUIContent("Wriggle"));
                        materialEditor.ShaderProperty(_OrificeChannel, new GUIContent("OrificeChannel Please Use 0"));
                        EditorGUI.indentLevel--;
                        EditorGUI.indentLevel--;
                    }
                }

                showStencilHelpers = ACLStyles.ShurikenFoldout("Stencil Settings", showStencilHelpers);
                if (showStencilHelpers)
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(_Stencil, new GUIContent("Reference Num", ""));
                    materialEditor.ShaderProperty(_StencilComp, new GUIContent("Compare", ""));
                    materialEditor.ShaderProperty(_StencilOp, new GUIContent("Pass", ""));
                    materialEditor.ShaderProperty(_StencilFail, new GUIContent("Fail", ""));
                    EditorGUILayout.HelpBox(
                        "For typical NPR stencil effects like \"Eyes over hair\".\n1st material (eyes/lashes): Same ref Num / Comp:Always / Pass:Replace / Fail:Replace\n2nd material (Hair): Same ref Num / Comp:NotEqual / Pass:Keep / Fail:Keep\nRender Queue 2nd material after 1st.",
                        MessageType.None, true);
                    EditorGUI.indentLevel--;
                    ACLStyles.PartingLine();
                }

                materialEditor.RenderQueueField();
                if (_ShaderOptimizerEnabled.floatValue == 1)
                {
                    EditorGUI.EndDisabledGroup();
                }

                ACLStyles.DrawButtons();
            }
        }
        protected static void Vector2Property(MaterialProperty property, GUIContent name)
        {
            EditorGUI.BeginChangeCheck();
            Vector2 vector2 = EditorGUILayout.Vector2Field(name,new Vector2(property.vectorValue.x, property.vectorValue.y),null);
            if (EditorGUI.EndChangeCheck())
                property.vectorValue = new Vector4(vector2.x, vector2.y, property.vectorValue.z, property.vectorValue.w);
        }
        protected static void Vector2PropertyZW(MaterialProperty property, GUIContent name)
        {
            EditorGUI.BeginChangeCheck();
            Vector2 vector2 = EditorGUILayout.Vector2Field(name,new Vector2(property.vectorValue.z, property.vectorValue.w),null);
            if (EditorGUI.EndChangeCheck())
                property.vectorValue = new Vector4(property.vectorValue.x, property.vectorValue.y, vector2.x, vector2.y);
        }
    }
}