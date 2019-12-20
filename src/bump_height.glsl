// Create a bumpy surface by using procedural noise to generate a height (
// displacement in normal direction).
//
// Inputs:
//   is_moon  whether we're looking at the moon or centre planet
//   s  3D position of seed for noise generation
// Returns elevation adjust along normal (values between -0.1 and 0.1 are
//   reasonable.
float bump_height(bool is_moon, vec3 s)
{
  /////////////////////////////////////////////////////////////////////////////
  float elevation;
  if (is_moon) {
    elevation = improved_perlin_noise(3 * s); // improved_.. range [-1/2, 1/2]
    return 0.1 * smooth_heaviside(elevation, 50);

  } else {
    elevation = improved_perlin_noise(2 * s);
    return 0.1 * smooth_heaviside(elevation, 300);
    // return 0.2 * elevation;
  }
  /////////////////////////////////////////////////////////////////////////////
}
