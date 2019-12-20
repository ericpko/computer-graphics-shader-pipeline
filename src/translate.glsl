// Inputs:
//   t  3D vector by which to translate
// Return a 4x4 matrix that translates and 3D point by the given 3D vector
mat4 translate(vec3 t)
{
  /////////////////////////////////////////////////////////////////////////////
  /**
   * NOTE: IMPORTANT
   * "Matrices are considered to consist of column vectors, which are
   * accessed by array indexing with the []-operator."
   * Eg)
   * mat3 m = mat3(
   *   1.1, 2.1, 3.1, // first column
   *   1.2, 2.2, 3.2, // second column
   *   1.3, 2.3, 3.3  // third column
   * );
   * https://en.wikibooks.org/wiki/GLSL_Programming/Vector_and_Matrix_Operations#Built-In_Vector_and_Matrix_Functions
   */
   vec4 col1 = vec4(1.0f, 0.0f, 0.0f, 0.0f);
   vec4 col2 = vec4(0.0f, 1.0f, 0.0f, 0.0f);
   vec4 col3 = vec4(0.0f, 0.0f, 1.0f, 0.0f);
   vec4 col4 = vec4(t.x, t.y, t.z, 1.0f);

   return mat4(col1, col2, col3, col4);
  /////////////////////////////////////////////////////////////////////////////
}


// Note that this is wrong by the way the matrices are initialized in GLSL.
// return mat4(
//     1, 0, 0, t.x,
//     0, 1, 0, t.y,
//     0, 0, 1, t.z,
//     0, 0, 0, 1
//   );
