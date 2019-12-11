defmodule CGX.Material do
  @moduledoc """
    A Module for Material
  """
  alias CGX.Utils
  alias CGX.Vec3
  alias CGX.Ray

  def scatter(:lambert, albedo, _ray_in, hit_record, _attenuation, _ray_scattered) do
    target_vector = Vec3.add(hit_record.point_of_intersection, hit_record.normal)
        |> Vec3.add(Utils.random_in_unit_sphere(true, Vec3.create(0, 0, 0)))

    _ray_scattered = Ray.create(hit_record.point_of_intersection, Vec3.sub(target_vector,
    hit_record.point_of_intersection))
    _attenuation = albedo
  end

end
