// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "LXH/02 0secondshader can run"{
	SubShader{
		Pass{
				CGPROGRAM
				//顶点函数 这里只是声明了顶点函数的函数名 确定位置
				//基本作用 完成顶点坐标从模型空间到裁剪空间的转换（从游戏环境转换到视野相机屏幕上）
#pragma vertex vert
				//片元函数 这里只是声明了片元函数的函数名 
				//基本作用 返回模型对应的屏幕上的每一个像素的颜色值
#pragma fragment frag
				float4 vert(float4 v : POSITION) : SV_POSITION {//通过语义告诉系统参数是干什么的，例：POSITION 顶点坐标
					//SV_POSITION这个语义用来解释说明返回值，意思是返回值是裁剪空间下的顶点坐标
					//float4 pos = mul(UNITY_MAIRIX_MVP,v );
					//return pos;
					return UnityObjectToClipPos(v);

				}
				fixed4 frag() :SV_Target {
					return fixed4(1.5,1.5,1,1);
				}

				ENDCG
		}
	}

	Fallback "VertexLit"
}
