defmodule CGX.Camera do
  @moduledoc """
    Camera Functions
  """
  alias CGX.Vec3
  alias CGX.Ray
  @lower_left_corner Vec3.create(-2.0, -1.0, -1.0)
  @horizontal_offset Vec3.create(4.0, 0.0, 0.0)
  @vertical_offset Vec3.create(0.0, 2.0, 0.0)
  @origin Vec3.create(0, 0, 0)

  def get_ray(u, v) do
    direction_offset =
      Vec3.mul(u, @horizontal_offset)
      |> Vec3.add(Vec3.mul(v, @vertical_offset))
      Ray.create(@origin, Vec3.add(@lower_left_corner, direction_offset))
  end
end
