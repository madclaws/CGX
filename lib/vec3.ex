defmodule CGX.Vec3 do
  @moduledoc """
    A vector 3D module
  """
  defstruct x: 0, y: 0, z: 0

  def create(x \\ 0, y \\ 0, z \\ 0) do
    v = __struct__()
    Map.put(v, :x, x) |> Map.put(:y, y) |> Map.put(:z, z)
  end

	def make_unit_vector(vector) do
		vector_magnitude = calculate_magnitude(vector)
		Map.put(vector, :x, vector.x / vector_magnitude)
		|> Map.put(:y, vector.y / vector_magnitude)
		|>	Map.put(:z, vector.z / vector_magnitude)
	end

	def	squared_magnitude(vector)  do
		:math.pow(vector.x, 2) + :math.pow(vector.y, 2) + :math.pow(vector.z, 2)
	end

	def add(v1, v2) do
		v3 = __struct__()
		Map.put(v3, :x, v1.x + v2.x)
		|> Map.put(:y, v1.y	+	v2.y)
		|>	Map.put(:z, v1.z	+	v2.z)
	end

	def sub(v1, v2) do
		v3 = __struct__()
		Map.put(v3, :x, v1.x - v2.x)
		|> Map.put(:y, v1.y	-	v2.y)
		|>	Map.put(:z, v1.z	-	v2.z)
	end

	def mul(v1, v2) do
		v3 = __struct__()
		Map.put(v3, :x, v1.x * v2.x)
		|> Map.put(:y, v1.y	*	v2.y)
		|>	Map.put(:z, v1.z	*	v2.z)
	end

	def div(v1, v2) do
		v3 = __struct__()
		Map.put(v3, :x, v1.x * v2.x)
		|> Map.put(:y, v1.y	*	v2.y)
		|>	Map.put(:z, v1.z	*	v2.z)
	end

	defp calculate_magnitude(vector) do
		:math.sqrt(:math.pow(vector.x, 2) + :math.pow(vector.y, 2) + :math.pow(vector.z, 2))
	end
end
