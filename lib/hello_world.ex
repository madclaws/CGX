defmodule CGX.HelloWorld do
  @moduledoc """
    HelloWorld module just generates a normal simple 200 * 100 PPM file
  """

  def generate_ppm() do
    total_column = 200
    total_row = 100

    generate_ppm_string(total_column, total_row)
    |> write_ppm_string_to_file()
  end

  defp generate_ppm_string(total_column, total_row) do
    ppm_header_string = "P3\n#{total_column} #{total_row}\n255\n"

    {_dec, ppm_string} =
      Enum.reduce((total_row - 1)..0, {total_row - 1, ppm_header_string}, fn _current_row,
                                                                             {decremented_row,
                                                                              ppm_str} ->
        {_inc, ppm_str} =
          Enum.reduce(0..(total_column - 1), {0, ppm_str}, fn _current_col,
                                                              {incremented_col, ppm_str} ->
            float_red = incremented_col / total_column
            float_green = decremented_row / total_row
            float_blue = 0.2
            int_red = floor(float_red * 255.9)
            int_green = floor(float_green * 255.9)
            int_blue = floor(float_blue * 255.9)
            {incremented_col + 1, ppm_str <> "#{int_red} #{int_green} #{int_blue}\n"}
          end)

        {decremented_row - 1, ppm_str}
      end)

    ppm_string
  end

  defp write_ppm_string_to_file(ppm_string) do
    File.write!("hello.ppm", ppm_string)
  end
end
