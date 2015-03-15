#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_COLOR_SHADER
#define NUMNODES 49

uniform int xs[NUMNODES];
uniform int ys[NUMNODES];
uniform float cols[NUMNODES];
uniform int height;
uniform float spacing;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;

float map(float val, float inputMin, float inputMax, float outputMin, float outputMax, bool clamp) {
  float outVal = ((val - inputMin) / (inputMax - inputMin) * (outputMax - outputMin) + outputMin);
  if( clamp ){
      if(outputMax < outputMin){
        if( outVal < outputMax )outVal = outputMax;
        else if( outVal > outputMin )outVal = outputMin;
      }else{
        if( outVal > outputMax )outVal = outputMax;
        else if( outVal < outputMin )outVal = outputMin;
      }
    }
  return outVal;
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {  
  vec4 color;
  vec2 coord = vec2(gl_FragCoord.x, gl_FragCoord.y);
  float hue = 0.0;
  float weight;
  float dist;
  for(int i=0;i<NUMNODES;i++) {
    vec2 loc = vec2(xs[i], height - ys[i]);
    dist = length(loc - coord);
    float maxDist = 150.0; //play with this value to get different effects
    weight = map(dist, 0.0, maxDist, 1.0, 0.0, true);
    hue += cols[i]*weight;
  }
  vec3 rgb = hsv2rgb(vec3(hue, 0.4*hue, 0.9));

  gl_FragColor = vec4(rgb, 1.0);
}