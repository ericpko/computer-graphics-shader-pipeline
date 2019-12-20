// Given a 3d position as a seed, compute a smooth procedural noise
// value: "Perlin Noise", also known as "Gradient noise".
//
// Inputs:
//   st  3D seed
// Returns a smooth value between (-1,1)
//
// expects: random_direction, smooth_step
float perlin_noise( vec3 st)
{
  /////////////////////////////////////////////////////////////////////////////
  /**
   * Sources:
   * https://thebookofshaders.com/11/
   * https://en.wikipedia.org/wiki/Perlin_noise
   * I have followed the wiki algorithm, but generalized to 3D.
   */
  // Get integer and fractional components
  vec3 i = floor(st);
  vec3 f = fract(st);

  // Get the 8 cs of a cube --- c == c --- These are the grid coords
  vec3 c1 = i + vec3(0, 0, 0);
  vec3 c2 = i + vec3(1, 0, 0);
  vec3 c3 = i + vec3(0, 1, 0);
  vec3 c4 = i + vec3(1, 1, 0);

  vec3 c5 = i + vec3(0, 0, 1);
  vec3 c6 = i + vec3(1, 0, 1);
  vec3 c7 = i + vec3(0, 1, 1);
  vec3 c8 = i + vec3(1, 1, 1);

  // Distance to grid coords
  // eg) x = 1.3 ---> i = 1, f = 0.3 ---> i + 1 = 2 ---> 2 - 1.3 = 1 - 0.3 = 0.7
  // vec3 d1 = f;
  // vec3 d2 = vec3(1 - f.x, f.y, f.z);
  // vec3 d3 = vec3(f.x, 1 - f.y, f.z);
  // vec3 d4 = vec3(1 - f.x, 1 - f.y, f.z);

  // vec3 d5 = vec3(f.x, f.y, 1 - f.z);
  // vec3 d6 = vec3(1 - f.x, f.y, 1 - f.z);
  // vec3 d7 = vec3(f.x, 1 - f.y, 1 - f.z);
  // vec3 d8 = vec3(1 - f.x, 1 - f.y, 1 - f.z);

  vec3 d1 = st - c1;
  vec3 d2 = st - c2;
  vec3 d3 = st - c3;
  vec3 d4 = st - c4;
  vec3 d5 = st - c5;
  vec3 d6 = st - c6;
  vec3 d7 = st - c7;
  vec3 d8 = st - c8;

  // Pseudorandom gradient vectors at each corner --- g == gradient
  vec3 g1 = random_direction(c1);
  vec3 g2 = random_direction(c2);
  vec3 g3 = random_direction(c3);
  vec3 g4 = random_direction(c4);

  vec3 g5 = random_direction(c5);
  vec3 g6 = random_direction(c6);
  vec3 g7 = random_direction(c7);
  vec3 g8 = random_direction(c8);

  // Dot product between the distance-gradient vectors
  float dp1 = dot(d1, g1);
  float dp2 = dot(d2, g2);
  float dp3 = dot(d3, g3);
  float dp4 = dot(d4, g4);

  float dp5 = dot(d5, g5);
  float dp6 = dot(d6, g6);
  float dp7 = dot(d7, g7);
  float dp8 = dot(d8, g8);


  // Interpolation between these values
  vec3 f_smooth = smooth_step(f);

  float lerp1 = mix(dp1, dp5, f_smooth.z);
  float lerp2 = mix(dp2, dp6, f_smooth.z);
  float lerp3 = mix(dp3, dp7, f_smooth.z);
  float lerp4 = mix(dp4, dp8, f_smooth.z);

  float average1 = mix(lerp1, lerp2, f_smooth.x);
  float average2 = mix(lerp3, lerp4, f_smooth.x);

  float average = mix(average1, average2, f_smooth.y);


  return average;
  /////////////////////////////////////////////////////////////////////////////
}
