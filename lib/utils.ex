defmodule CGX.Utils do
  @moduledoc """
    Utils module
  """

  alias CGX.Vec3
  def random_in_unit_sphere(true, _p_vec) do
    rand_vec = calculate_random_vector_in_sphere()
    random_in_unit_sphere(Vec3.squared_magnitude(rand_vec) >= 1, rand_vec)
  end

  def random_in_unit_sphere(false, p_vec) do
    p_vec
  end

  defp calculate_random_vector_in_sphere() do
    p_vec = Vec3.create(:rand.uniform(), :rand.uniform(), :rand.uniform())
    Vec3.mul(2, p_vec)
    |> Vec3.sub(Vec3.create(1, 1, 1))
  end
end
