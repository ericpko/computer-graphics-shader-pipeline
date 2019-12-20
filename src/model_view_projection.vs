// Determine the perspective projection (do not conduct division) in homogenous
// coordinates. If is_moon is true, then shrink the model by 30%, shift away
// from the origin by 2 units and rotate around the origin at a frequency of 1
// revolution per 4 seconds.
//
// Uniforms:
//                  4x4 view transformation matrix: transforms "world
//                  coordinates" into camera coordinates.
uniform mat4 view;
//                  4x4 perspective projection matrix: transforms
uniform mat4 proj;
//                                number of seconds animation has been running
uniform float animation_seconds;
//                     whether we're rendering the moon or the other object
uniform bool is_moon;
// Inputs:
//                  3D position of mesh vertex
in vec3 pos_vs_in;
// Ouputs:
//                   transformed and projected position in homogeneous
//                   coordinates
out vec4 pos_cs_in;
// expects: PI, model
void main()
{
  /////////////////////////////////////////////////////////////////////////////
  /**
   * From chapter 7, we read from right to left and we are going from
   * object space -> world space -> camera space -> view volume
   * vertex given in object space goes to world space by multiplying by M_model
   * transformation matrix, then goes to camera coordinates by multiplying by
   * M_view camera transformation matrix, and so on.
   */
  mat4 model = model(is_moon, animation_seconds);

  if (is_moon) {
    // If is_moon is true, then shrink the model by 30% and shift away
    // from the origin by 2 units
    vec3 shift = vec3(2, 0, 2);
    model = model * translate(shift) * uniform_scale(0.3);
  }

  pos_cs_in = proj * view * model * vec4(pos_vs_in, 1.0);
  /////////////////////////////////////////////////////////////////////////////
}
