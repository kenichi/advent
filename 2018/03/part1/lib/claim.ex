defmodule Claim do

  defstruct id: -1,
    origin: {-1,-1},
    size: {-1,-1}

end

defmodule ClaimState do
  defstruct state: :id, value: nil
end
