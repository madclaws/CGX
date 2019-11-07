defmodule CGX.Hittable do
  @moduledoc """
    Handles all hittable Objects.
  """
  alias CGX.Ray
  alias CGX.Vec3
  require Logger
  defstruct object: nil, info: nil

  @spec create(any, any) :: CGX.Hittable.t()
  def create(object_type, info) do
    hittable = __struct__()

    Map.put(hittable, :object, object_type)
    |> Map.put(:info, info)
  end

  @spec hit(CGX.Hittable.t(), %{ray: CGX.Ray.t(), t_max: any, t_min: any}) ::
          {false, nil} | {true, %{normal: nil, point_of_intersection: nil, time: nil}}
  def hit(
        %CGX.Hittable{object: :sphere} = hittable,
        %{ray: ray, t_min: t_min, t_max: t_max} = _hit_info
      ) do
    {origin, radius} = hittable.info
    {discriminant, b, a} = get_determinant(origin, radius, ray)
    get_hit_record(discriminant, b, a, t_max, t_min, ray, hittable.info)
  end

  def hit_on_list(hittable_list, %{ray: _ray, t_min: _t_min, t_max: t_max} = hit_info)  do
    tmp_record = %{time: nil, point_of_intersection: nil, normal: nil}
    Enum.reduce(hittable_list, {false, tmp_record, t_max}, fn hittable, hit_info_return ->
      case CGX.Hittable.hit(hittable, hit_info) do
        {true, hit_rec} ->
          {true, hit_rec, hit_rec.time}
        {false, _} ->
          hit_info_return
      end
    end)
  end

  defp get_determinant(sphere_origin, radius, %Ray{origin: origin, direction: direction}) do
    vec_ac = Vec3.sub(origin, sphere_origin)
    a = Vec3.dot(direction, direction)
    b = 2 * Vec3.dot(direction, vec_ac)
    c = Vec3.dot(vec_ac, vec_ac) - :math.pow(radius, 2)
    {b * b - 4 * a * c, b, a}
  end

  defp get_hit_record(discriminant, b, a, t_max, t_min, ray, hit_info) when discriminant > 0 do
    discriminant_sqrt = :math.sqrt(discriminant)

    cond do
      (-b - discriminant_sqrt) / (2 * a) > t_min && (-b - discriminant_sqrt) / (2 * a) < t_max ->
        calculate_hit_record((-b - discriminant_sqrt) / (2 * a), ray, hit_info)

      (-b + discriminant_sqrt) / (2 * a) > t_min && (-b + discriminant_sqrt) / (2 * a) < t_max ->
        calculate_hit_record((-b + discriminant_sqrt) / (2 * a), ray, hit_info)

      true ->
        calculate_hit_record(nil, ray, hit_info)
    end
  end

  defp get_hit_record(_discriminant, _b, _a, _t_max, _t_min, _ray, _hit_info), do: {false, nil}

  defp calculate_hit_record(nil, _ray, _hit_info), do: {false, nil}

  defp calculate_hit_record(t, ray, hit_info) do
    {origin, radius} = hit_info
    point_at_parameter = Ray.get_point_at_parameter(ray, t)

    hit_record =
      Map.put(
        %{time: nil, point_of_intersection: nil, normal: nil},
        :point_of_intersection,
        point_at_parameter
      )
      |> Map.put(:normal, Vec3.div(radius, Vec3.sub(point_at_parameter, origin)))

    {true, hit_record}
  end
end
