defmodule Advent do

  defmodule Worker do
    defstruct [:step]

    def count do
      Application.get_env(:advent, :workers)
    end

    def done?(%Advent.Worker{step: nil} = _worker, _timer) do
      true
    end
    def done?(worker, timer) do
      timer >= (Advent.Step.duration(worker.step) + worker.step.start)
    end

  end

  defmodule Step do
    defstruct [:id, :start]

    @duration ~w[ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ]

    def base do
      Application.get_env(:advent, :base_duration)
    end

    def duration(%Step{} = step) do
      base() + Enum.find_index(@duration, fn id -> id == step.id end) + 1
    end
  end

  @dir ~r/Step (\w) must be finished before step (\w) can begin./

  def read_input(dev \\ :stdio) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
  end

  def parse_input(input \\ read_input()) do
    Enum.reduce(input, {MapSet.new(), %{}}, fn l, {all, m} ->
      [_, parent, step] = Regex.run(@dir, l)

      {
        (MapSet.put(all, step) |> MapSet.put(parent)),
        Map.update(m, step, MapSet.new([parent]), &MapSet.put(&1, parent))
      }
    end)
  end

  def build_deps({all, deps} \\ parse_input()) do
    {
      all,
      Enum.reduce(deps, deps, fn {s, _}, nds ->
        Map.put(nds, s, recurse_deps(nds, s))
      end)
    }
  end

  def recurse_deps(deps, key) do
    Enum.reduce(deps[key], deps[key], fn d, set ->
      if deps[d] do
        MapSet.union(set, MapSet.union(deps[d], recurse_deps(deps, d)))
      else
        set
      end
    end)
  end

  def satisfied?(step, steps, deps) do
    if Map.has_key?(deps, step) do
      MapSet.subset? deps[step], MapSet.new(steps)
    else
      true
    end
  end

  def next_steps(all, deps, steps) do
    Enum.filter(all, fn s ->
      satisfied? s, steps, deps
    end) -- steps
  end

  def next_step(ready) do
    if length(ready) > 0 do
      hd Enum.sort(ready)
    else
      nil
    end
  end

  def build_workers do
    for i <- 0..Worker.count(), i > 0, do: %Worker{}
  end

  def eval({all, deps} \\ build_deps(), steps \\ [], workers \\ build_workers(), timer \\ 0) do
    {done, workers} = iterate_workers(workers, timer)

    steps = Enum.reverse(Enum.sort(done)) ++ steps

    if MapSet.equal?(MapSet.new(steps), all) do
      timer
    else
      ns = Advent.next_steps(all, deps, steps) -- Advent.current_steps(workers)

      {_, workers} = Advent.enqueue_workers(workers, ns, timer)

      eval({all, deps}, steps, workers, timer + 1)
    end
  end

  def iterate_workers(workers, timer) do
    Enum.reduce(workers, {[], []}, fn w, {done, nw} ->
      {d, w} = case Advent.Worker.done?(w, timer) do
        true -> {step_id(w), %Advent.Worker{}}
        _ -> {nil, w}
      end

      done = case d do
        nil -> done
        _ -> [d | done]
      end

      {done, [w | nw]}
    end)
  end

  def enqueue_workers(workers, ns, timer) do
    Enum.reduce(workers, {[], []}, fn w, {qs, nw} ->
      ns = ns -- qs

      {qs, w} = case w do

        %Advent.Worker{step: nil} ->
          case Advent.next_step(ns) do
            nil -> {qs, w}
            next_step -> {
                qs ++ [next_step],
                %Advent.Worker{step: %Advent.Step{id: next_step, start: timer}}
              }
          end

        _ -> {qs, w}

      end

      {qs, [w | nw]}
    end)
  end

  defp step_id(%Advent.Worker{step: nil} = _worker), do: nil
  defp step_id(%Advent.Worker{step: %Advent.Step{id: id}} = _worker), do: id

  def current_steps(workers) do
    Enum.reduce(workers, [], fn w, steps ->
      case w do
        %Advent.Worker{step: nil} -> steps
        %Advent.Worker{step: %Advent.Step{id: id}} -> [id | steps]
      end
    end)
  end

end
