defmodule CGX.HelloWorld do
  @moduledoc """
    HelloWorld module just generates a normal simple 200 * 100 PPM file
  """
  alias CGX.Vec3
  alias CGX.Ray
  alias CGX.Hittable
  require Logger
  @max_float 1.7976931348623157e+308
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
    sphere_origin = Vec3.create(0, 0, -1)
    t_sphere = Hittable.create(:sphere, {sphere_origin, 0.5})
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
            # col = color(ray, is_sphere_hit(sphere_origin, 0.5, ray))
            col = color(ray, t_sphere)
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
    File.write!("chapter7.ppm", ppm_string)
  end

  defp color(_ray, _is_sphere_hit)

  defp color(%Ray{origin: _origin, direction: direction} = ray, hittable) do
    {is_hit, hit_record} = Hittable.hit(hittable, %{ray: ray, t_max: @max_float, t_min: 0.0})

    case is_hit do
      true ->

        Vec3.mul(
          0.5,
          Vec3.create(hit_record.normal.x + 1, hit_record.normal.y + 1, hit_record.normal.z + 1)
        )

      false ->
        unit_direction = Vec3.make_unit_vector(direction)
        t = 0.5 * (unit_direction.y + 1.0)
        a = Vec3.mul(1 - t, Vec3.create(1, 1, 1))
        b = Vec3.mul(t, Vec3.create(0.5, 0.7, 1.0))
        Vec3.add(a, b)
    end
  end
end
