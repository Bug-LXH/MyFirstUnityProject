﻿// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "LXH/04 Diffuse"{//顶点漫反射

	Properties{
		_Diffuse("Diffuse Color",Color) = (1,1,1,1)
	}

		SubShader{
			Pass{
				Tags{"LightMode" = "ForwardBase"}
				CGPROGRAM
				#include "Lighting.cginc" //取得第一个直射光的颜色 _LightColor0     第一个直射光的位置 _WorldSpaceLightPos0.xyz
				#pragma vertex vert

				#pragma  fragment frag
				fixed4 _Diffuse;
			 
			struct a2v {
				float4 vertex:POSITION;//告诉Unity把模型空间下的顶点坐标填充给vertex
				float3 normal:NORMAL;
			};

			struct  v2f {
				float4 position:SV_POSITION;
				fixed3 color : COLOR;
			};

			v2f vert(a2v v) {
				v2f f;
				f.position = UnityObjectToClipPos(v.vertex);

				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;

				fixed3 normalDir = normalize(mul(v.normal, (float3x3)unity_WorldToObject));

				fixed3 lightDir = normalize(_WorldSpaceLightPos0.xyz);//对于每一个顶点来说 光的位置就是光的方向，因为光是平行光
				 
				fixed3 diffuse = _LightColor0.rgb * max(dot(normalDir, lightDir), 0) * _Diffuse.rgb;//取得漫反射的颜色
				f.color = diffuse + ambient; 
				return f;
			}

			fixed4 frag(v2f f) :SV_Target{
				return fixed4(f.color,1);
			}

			ENDCG
		}

	}

	Fallback "Diffuse"
}