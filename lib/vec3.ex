defmodule CGX.Vec3 do
  @moduledoc """
    A vector 3D module
  """
  defstruct x: 0, y: 0, z: 0

  @spec create(any, any, any) :: CGX.Vec3.t()
  def create(x \\ 0, y \\ 0, z \\ 0) do
    v = __struct__()
    Map.put(v, :x, x) |> Map.put(:y, y) |> Map.put(:z, z)
  end

  @spec make_unit_vector(CGX.Vec3.t()) :: CGX.Vec3.t()
  def make_unit_vector(vector) do
    vector_magnitude = calculate_magnitude(vector)

    CGX.Vec3.div(vector_magnitude, vector)
  end

  @spec squared_magnitude(CGX.Vec3.t()) :: float
  def squared_magnitude(vector) do
    :math.pow(vector.x, 2) + :math.pow(vector.y, 2) + :math.pow(vector.z, 2)
  end

  @spec add(number | CGX.Vec3.t(), CGX.Vec3.t()) :: CGX.Vec3.t()
  def add(%CGX.Vec3{x: x1, y: y1, z: z1}, %CGX.Vec3{x: x2, y: y2, z: z2}) do
    v3 = __struct__()

    Map.put(v3, :x, x1 + x2)
    |> Map.put(:y, y1 + y2)
    |> Map.put(:z, z1 + z2)
  end

  def add(constant, %CGX.Vec3{x: x1, y: y1, z: z1}) do
    v3 = __struct__()

    Map.put(v3, :x, x1 + constant)
    |> Map.put(:y, y1 + constant)
    |> Map.put(:z, z1 + constant)
  end

  @spec sub(CGX.Vec3.t(), CGX.Vec3.t()) :: CGX.Vec3.t()
  def sub(%CGX.Vec3{x: x1, y: y1, z: z1}, %CGX.Vec3{x: x2, y: y2, z: z2}) do
    v3 = __struct__()

    Map.put(v3, :x, x1 - x2)
    |> Map.put(:y, y1 - y2)
    |> Map.put(:z, z1 - z2)
  end

  @spec mul(number | CGX.Vec3.t(), CGX.Vec3.t()) :: CGX.Vec3.t()
  def mul(%CGX.Vec3{x: x1, y: y1, z: z1}, %CGX.Vec3{x: x2, y: y2, z: z2}) do
    v3 = __struct__()

    Map.put(v3, :x, x1 * x2)
    |> Map.put(:y, y1 * y2)
    |> Map.put(:z, z1 * z2)
  end

  def mul(constant, %CGX.Vec3{x: x1, y: y1, z: z1}) do
    v3 = __struct__()

    Map.put(v3, :x, x1 * constant)
    |> Map.put(:y, y1 * constant)
    |> Map.put(:z, z1 * constant)
  end

  @spec div(number | CGX.Vec3.t(), CGX.Vec3.t()) :: CGX.Vec3.t()
  def div(%CGX.Vec3{x: x1, y: y1, z: z1}, %CGX.Vec3{x: x2, y: y2, z: z2}) do
    v3 = __struct__()

    Map.put(v3, :x, x1 / x2)
    |> Map.put(:y, y1 / y2)
    |> Map.put(:z, z1 / z2)
  end

  def div(constant, %CGX.Vec3{x: x1, y: y1, z: z1}) do
    v3 = __struct__()

    Map.put(v3, :x, x1 / constant)
    |> Map.put(:y, y1 / constant)
    |> Map.put(:z, z1 / constant)
  end

  @spec dot(CGX.Vec3.t(), CGX.Vec3.t()) :: number
  def dot(%CGX.Vec3{x: x1, y: y1, z: z1}, %CGX.Vec3{x: x2, y: y2, z: z2}) do
    x1 * x2 + y1 * y2 + z1 * z2
  end

  @spec cross(CGX.Vec3.t(), CGX.Vec3.t()) :: CGX.Vec3.t()
  def cross(%CGX.Vec3{x: x1, y: y1, z: z1}, %CGX.Vec3{x: x2, y: y2, z: z2}) do
    v3 = __struct__()

    Map.put(v3, :x, y1 * z2 - z1 * y2)
    |> Map.put(:y, z1 * x2 - x1 * z2)
    |> Map.put(:z, x1 * y2 - y1 * x2)
  end

  defp calculate_magnitude(vector) do
    :math.sqrt(:math.pow(vector.x, 2) + :math.pow(vector.y, 2) + :math.pow(vector.z, 2))
  end
end
