defmodule Advent.Robot do
  defstruct direction: :^, panels: %{}, position: {0, 0}

  def camera(%__MODULE__{panels: ps, position: p}), do: Map.get(ps, p, 0)

  def left(%__MODULE__{direction: :^} = robot), do: %__MODULE__{robot | direction: :<}
  def left(%__MODULE__{direction: :<} = robot), do: %__MODULE__{robot | direction: :v}
  def left(%__MODULE__{direction: :v} = robot), do: %__MODULE__{robot | direction: :>}
  def left(%__MODULE__{direction: :>} = robot), do: %__MODULE__{robot | direction: :^}

  def move(%__MODULE__{direction: :^, position: {x, y}} = robot),
    do: %__MODULE__{robot | position: {x, y + 1}}

  def move(%__MODULE__{direction: :<, position: {x, y}} = robot),
    do: %__MODULE__{robot | position: {x - 1, y}}

  def move(%__MODULE__{direction: :v, position: {x, y}} = robot),
    do: %__MODULE__{robot | position: {x, y - 1}}

  def move(%__MODULE__{direction: :>, position: {x, y}} = robot),
    do: %__MODULE__{robot | position: {x + 1, y}}

  def paint(%__MODULE__{panels: ps, position: p} = robot, color),
    do: %__MODULE__{robot | panels: Map.put(ps, p, color)}

  def right(%__MODULE__{direction: :^} = robot), do: %__MODULE__{robot | direction: :>}
  def right(%__MODULE__{direction: :>} = robot), do: %__MODULE__{robot | direction: :v}
  def right(%__MODULE__{direction: :v} = robot), do: %__MODULE__{robot | direction: :<}
  def right(%__MODULE__{direction: :<} = robot), do: %__MODULE__{robot | direction: :^}

  def turn(%__MODULE__{} = robot, 0), do: left(robot)
  def turn(%__MODULE__{} = robot, 1), do: right(robot)
end
