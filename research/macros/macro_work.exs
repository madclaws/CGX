defmodule Macro_Work do
  def fun_unless(clause, do: expression) do
    if not clause do
      expression
    end
  end

  defmacro macro_unless(clause, do: expression) do
    quote do
      if(not unquote(clause)) do
        unquote(expression)
      end
    end
  end
end
