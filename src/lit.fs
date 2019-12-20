// Add (hard code) an orbiting (point or directional) light to the scene. Light
// the scene using the Blinn-Phong Lighting Model.
//
// Uniforms:
uniform mat4 view;
uniform mat4 proj;
uniform float animation_seconds;
uniform bool is_moon;
// Inputs:
in vec3 sphere_fs_in;
in vec3 normal_fs_in;
in vec4 pos_fs_in;
in vec4 view_pos_fs_in;
// Outputs:
out vec3 color;
// expects: PI, blinn_phong
void main()
{
  /////////////////////////////////////////////////////////////////////////////
  // Set up the point light
  float theta = animation_seconds * (M_PI / 5.0);
  mat4 rotate = mat4(
    cos(theta), 0, 0, 0,
    0, 1, 0, 0,
    0, 0, sin(theta), 0,
    0, 0, 0, 1
  );
  vec3 pointlight = (view * rotate * vec4(5, 5, 6, 1)).xyz;

  // Get the Blinn-Phone shading elements in the camera frame/coordinates
  // NOTE: We don't actually have to divide by w here since it's just 1
  vec3 p = view_pos_fs_in.xyz / view_pos_fs_in.w;       // point
  vec3 n = normalize(normal_fs_in);
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
    kd = vec3(0.2, 0.2, 0.8);
    ks = vec3(1.0);
  }

  color = blinn_phong(ka, kd, ks, phong_exp, n, v, l);
  /////////////////////////////////////////////////////////////////////////////
}
