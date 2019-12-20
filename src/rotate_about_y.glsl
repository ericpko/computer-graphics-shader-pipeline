// Inputs:
//   theta  amount y which to rotate (in radians)
// Return a 4x4 matrix that rotates a given 3D point/vector about the y-axis by
// the given amount.
mat4 rotate_about_y(float theta)
{
  /////////////////////////////////////////////////////////////////////////////
  /**
   * Chapter 6 page 124
   * NOTE: Note that this is not exactly as shown on page 6 because the negative
   * sign on the sin function has been switched, but remember that this is
   * because of how mat4 matrices are initialized in GLSL. i.e. each row
   * is actually a column, so it is actually exactly the same as in page
   * 124 of the textbook.
   */

  return mat4(
    cos(theta),  0, -sin(theta), 0,             // column 1
        0,       1,      0,      0,             // column 2
    sin(theta),  0, cos(theta),  0,             // column 3
        0,       0,      0,      1              // column 4
  );
  /////////////////////////////////////////////////////////////////////////////
}
