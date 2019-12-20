// Compute Blinn-Phong Shading given a material specification, a point on a
// surface and a light direction. Assume the light is white and has a low
// ambient intensity.
//
// Inputs:
//   ka  rgb ambient color
//   kd  rgb diffuse color
//   ks  rgb specular color
//   p  specular exponent (shininess)
//   n  unit surface normal direction
//   v  unit direction from point on object to eye
//   l  unit light direction
// Returns rgb color
vec3 blinn_phong(
  vec3 ka,
  vec3 kd,
  vec3 ks,
  float p,
  vec3 n,
  vec3 v,
  vec3 l)
{
  /////////////////////////////////////////////////////////////////////////////
  vec3 h = normalize(v + l);
  vec3 I = vec3(1.0, 1.0, 1.0);           // intensity

  vec3 color = ka * I + kd * I * max(0, dot(n, l)) + ks * I * pow(max(0, dot(n, h)), p);
  return color;
  /////////////////////////////////////////////////////////////////////////////
}
