// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "LXH/14 Rock Alpha"{

	Properties{
		//_Diffuse("Diffuse Color", Color) = (1,1,1,1)
		_Color("Color",Color) = (1,1,1,1)
		_MainTex("Main Tex",2D) = "white"{}
		_NormalMap("Normal Map",2D) = "bump"{}
		_BumpScale("Bump Scale",Float) =1
		_AlphaScale("Alpha Scale",Float) =1
	}

		SubShader{
			Tags{"Queue" = "Transparent"  "IngnoreProjector" = "True" "RenderType" = "Transparent"}
			Pass {
				Tags{"LightMode" = "ForwardBase"}

				ZWrite Off
				Blend SrcAlpha OneMinusSrcAlpha

				CGPROGRAM
				#include "Lighting.cginc"
				#pragma vertex vert
				#pragma fragment frag

					//fixed4 _Diffuse;
					fixed4 _Color;
					sampler2D _MainTex;
					float4 _MainTex_ST;
					sampler2D _NormalMap;
					float4 _NormalMap_ST;
					float _BumpScale;
					float _AlphaScale;

					struct a2v { //给顶点函数传递
						float4 vertex:POSITION;
						//切线空间的确定是通过（存储到模型里的）法线和切线（存储到模型里的）确定的
						float3 normal:NORMAL;
						float4 tangent:TANGENT; //tangent.w是用来确定切线空间中坐标轴的方向
						float4 texcoord:TEXCOORD0;
					};

					struct v2f { //顶点函数和片元函数之间
						float4 svPos:SV_POSITION;
						//float3 worldNormal:TEXCOORD0;
						float3 lightDir:TEXCOORD0;//切线空间下 平行光的方向
						float4 worldVertex:TEXCOORD1;
						float4 uv:TEXCOORD2;//xy 用来存储MainText的纹理坐标    zw用来存储NormalMap的纹理坐标
					};

					v2f vert(a2v v) {//顶点函数
						v2f f;
						f.svPos = UnityObjectToClipPos(v.vertex);
						//f.worldNormal = UnityObjectToWorldNormal(v.normal);
						f.worldVertex = mul(v.vertex, unity_WorldToObject);
						f.uv.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
						f.uv.zw = v.texcoord.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;

						TANGENT_SPACE_ROTATION;//调用这个之后，会得到一个矩阵 rotation 这个矩阵用来把模型空间下的方向转换成切线空间下

						//ObjSpaceLightDir(v.vertex);//得到模型空间下的平行光方向
						f.lightDir = mul(rotation, ObjSpaceLightDir(v.vertex));

						return f;
					}
					//把所有跟法线方向有关的运算都放在 切线空间下
					//从法线贴图里面取得的法线方向是在切线空间下的
					fixed4 frag(v2f f) : SV_Target {//片元函数

						//fixed3 normalDir = normalize(f.worldNormal);

						fixed4 normalColor = tex2D(_NormalMap,f.uv.zw);
						
						//fixed3 tangentNormal = normalize( normalColor.xyz * 2 - 1);//切线空间下的法线
						fixed3 tangentNormal = UnpackNormal(normalColor);
						tangentNormal.xy = tangentNormal.xy * _BumpScale;
						tangentNormal = normalize(tangentNormal);

						fixed3 lightDir = normalize(f.lightDir);

						fixed4 texColor = tex2D(_MainTex, f.uv.xy) * _Color;

						fixed3 diffuse = _LightColor0.rgb * texColor.rgb * max(dot(tangentNormal,lightDir),0);

						fixed3 tempColor = diffuse + UNITY_LIGHTMODEL_AMBIENT.rgb * texColor;

						return fixed4(tempColor,_AlphaScale * texColor.a);
					}


			ENDCG
		}
	}

	Fallback "Diffuse"
}