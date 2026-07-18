
varying vec2 vTexcoord;
varying vec4 vColor;

uniform float uAlpha;

void main() {
    vec4 color = texture2D(gm_BaseTexture, vTexcoord) * vColor;
    color.a *= uAlpha;
    gl_FragColor = color;
}
