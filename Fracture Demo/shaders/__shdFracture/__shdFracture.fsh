
varying vec2 vTexcoord;
varying vec4 vColor;

uniform float uAlpha;

void main() {
    vec4 col = texture2D(gm_BaseTexture, vTexcoord) * vColor;
    col.a *= uAlpha;
    gl_FragColor = col;
}
