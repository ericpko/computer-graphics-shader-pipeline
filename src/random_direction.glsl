// Generate a pseudorandom unit 3D vector
//
// Inputs:
//   seed  3D seed
// Returns psuedorandom, unit 3D vector drawn from uniform distribution over
// the unit sphere (assuming random2 is uniform over [0,1]²).
//
// expects: random2.glsl, PI.glsl
vec3 random_direction( vec3 seed)
{
  /////////////////////////////////////////////////////////////////////////////
  vec2 rand = random2(seed);
  float rho = 1.0f;
  float theta = rand.x * 2.0 * M_PI;
  float phi = rand.y * M_PI;

  // over the unit sphere
  float x = rho * sin(phi) * cos(theta);
  float y = rho * sin(phi) * sin(theta);
  float z = rho * cos(phi);

  return normalize(vec3(x, y, z));
  /////////////////////////////////////////////////////////////////////////////
}
