defmodule CGX.Ray do
  @moduledoc """
     A Ray Module
  """
  alias CGX.Vec3
  defstruct origin: nil, direction: nil

  def create(%Vec3{x: _x1, y: _y1, z: _z1} = origin, %Vec3{x: _x2, y: _y2, z: _z2} = direction) do
    ray_a = __struct__()

    Map.put(ray_a, :origin, origin)
    |> Map.put(:direction, direction)
  end

  def get_point_at_parameter(%CGX.Ray{origin: origin, direction: direction}, parameter_t) do
    origin
    |> Vec3.add(Vec3.mul(parameter_t, direction))
  end
end
