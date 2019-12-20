// Source: https://flafla2.github.io/2014/08/09/perlinnoise.html
float octave_perlin(vec3 seed, int octaves, float persistence) {
  float total = 0;
  float frequency = 1;
  float amplitude = 1;
  float max_value = 0;

  for (int i = 0; i < octaves; i++) {
    total += (improved_perlin_noise(frequency * seed) * amplitude);
    max_value += amplitude;
    amplitude *= persistence;
    frequency *= 2;
  }

  return total / max_value;
}


// Set the pixel color using Blinn-Phong shading (e.g., with constant blue and
// gray material color) with a bumpy texture.
//
// Uniforms:
uniform mat4 view;
uniform mat4 proj;
uniform float animation_seconds;
uniform bool is_moon;
// Inputs:
//                     linearly interpolated from tessellation evaluation shader
//                     output
in vec3 sphere_fs_in;
in vec3 normal_fs_in;
in vec4 pos_fs_in;
in vec4 view_pos_fs_in;
// Outputs:
//               rgb color of this pixel
out vec3 color;
// expects: model, blinn_phong, bump_height, bump_position,
// improved_perlin_noise, tangent
void main()
{
  /////////////////////////////////////////////////////////////////////////////
  /**
   * NOTE: See README.html for bump map and normal map details
   */
  // Set up the rotating point light
  float theta = animation_seconds * (M_PI / 5.0);
  mat4 rotate = mat4(
    cos(theta), 0, 0, 0,
    0, 1, 0, 0,
    0, 0, sin(theta), 0,
    0, 0, 0, 1
  );
  vec3 pointlight = (view * rotate * vec4(5, 5, 6, 1)).xyz;

  // Get the normal, tangent, and bi-tangent vectors
  vec3 T, B;
  tangent(normalize(sphere_fs_in), T, B);

  // --- Find up the bump mapping and normal mapping. See README.html ---
  mat4 model = model(is_moon, animation_seconds);
  vec3 sp = sphere_fs_in;                         // for notation (sphere point)

  vec3 bp = bump_position(is_moon, sp);           // bump mapping (bump point)
  float epsilon = 0.0001;
  vec3 temp1 = (bump_position(is_moon, sp + epsilon * T) - bp) / epsilon;
  vec3 temp2 = (bump_position(is_moon, sp + epsilon * B) - bp) / epsilon;
  vec3 n = normalize(cross(temp1, temp2));

  // Transform the normal into the camera frame
  n = (transpose(inverse(view)) * transpose(inverse(model)) * vec4(n, 1.0)).xyz;

  // Noise
  float noise = octave_perlin(sp, 2, 2);


  // Get the Blinn-Phone shading elements in the camera frame/coordinates
  vec3 p = (view * model * vec4(bp, 1.0)).xyz;                   // point
  vec3 v = -normalize(p);
  vec3 l = normalize(pointlight - p);

  // Set the lighting coefficients
  float phong_exp = 500;
  vec3 ka, kd, ks;
  ka = vec3(0.03);
  if (is_moon) {
    kd = vec3(0.5);
    ks = vec3(1.0);
  } else {
    kd = mix(vec3(0.2, 0.2, 0.8), vec3(1), noise);
    ks = vec3(1.0);
  }

  color = blinn_phong(ka, kd, ks, phong_exp, n, v, l);
  /////////////////////////////////////////////////////////////////////////////
}
