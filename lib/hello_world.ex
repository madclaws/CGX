defmodule CGX.HelloWorld do
  @moduledoc """
    HelloWorld module just generates a normal simple 200 * 100 PPM file
  """
  alias CGX.Vec3
  alias CGX.Ray

  def generate_ppm() do
    total_column = 200
    total_row = 100

    generate_ppm_string(total_column, total_row)
    |> write_ppm_string_to_file()
  end

  defp generate_ppm_string(total_column, total_row) do
    lower_left_corner = Vec3.create(-2.0, -1.0, -1.0)
    horizontal_offset = Vec3.create(4.0, 0.0, 0.0)
    vertical_offset = Vec3.create(0.0, 2.0, 0.0)
    origin = Vec3.create(0, 0, 0)
    sphere_origin = Vec3.create(0, 0, 1)
    ppm_header_string = "P3\n#{total_column} #{total_row}\n255\n"

    {_dec, ppm_string} =
      Enum.reduce((total_row - 1)..0, {total_row - 1, ppm_header_string}, fn _current_row,
                                                                             {decremented_row,
                                                                              ppm_str} ->
        {_inc, ppm_str} =
          Enum.reduce(0..(total_column - 1), {0, ppm_str}, fn _current_col,
                                                              {incremented_col, ppm_str} ->
            u = incremented_col / total_column
            v = decremented_row / total_row

            direction_offset =
              Vec3.mul(u, horizontal_offset)
              |> Vec3.add(Vec3.mul(v, vertical_offset))

            ray = Ray.create(origin, Vec3.add(lower_left_corner, direction_offset))
            col = color(ray, is_sphere_hit(sphere_origin, 0.5, ray))
            int_red = floor(col.x * 255.9)
            int_green = floor(col.y * 255.9)
            int_blue = floor(col.z * 255.9)
            {incremented_col + 1, ppm_str <> "#{int_red} #{int_green} #{int_blue}\n"}
          end)

        {decremented_row - 1, ppm_str}
      end)

    ppm_string
  end

  defp write_ppm_string_to_file(ppm_string) do
    File.write!("chapter6.ppm", ppm_string)
  end

  defp color(_ray, _is_sphere_hit)

  defp color(%Ray{origin: _origin, direction: _direction} = ray, t) when t > 0 do
    vec_normal =
      Vec3.sub(Ray.get_point_at_parameter(ray, t), Vec3.create(0, 0, -1))
      |> Vec3.make_unit_vector()

    Vec3.mul(0.5, Vec3.create(vec_normal.x + 1, vec_normal.y + 1, vec_normal.z + 1))
  end

  defp color(%Ray{origin: _origin, direction: _direction}, t) do
    # unit_direction	=	Vec3.make_unit_vector(direction)
    # t	=	0.5 * (unit_direction.y + 1.0)
    a = Vec3.mul(1 - t, Vec3.create(1, 1, 1))
    b = Vec3.mul(t, Vec3.create(0.5, 0.7, 1.0))
    Vec3.add(a, b)
  end


  # defp get_solution_t(discriminant, _b, _a) when discriminant < 0, do: -1.0
  # defp get_solution_t(discriminant, b, a), do: (-b - :math.sqrt(discriminant)) / (2 * a)
end
