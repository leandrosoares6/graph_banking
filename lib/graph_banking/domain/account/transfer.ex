defmodule GraphBanking.Model.Transfer do
  @moduledoc false

  defstruct uuid: nil,
            sender: nil,
            address: nil,
            amount: nil,
            when: nil

  def create(%{sender: sender, address: address, amount: amount}) do
    case {sender, address, amount} do
      {sender, address, _} when sender === address ->
        {:error, "You cannot make a transfer to yourself."}

      {_, _, amount} when amount > 0 ->
        uuid = UUID.uuid4()
        when_date = DateTime.utc_now()

        %__MODULE__{
          uuid: uuid,
          sender: sender,
          address: address,
          amount: amount,
          when: when_date
        }

      {_, _, _} ->
        {:error, "Amount of transfer must be greater than 0."}
    end
  end

  def create(_), do: {:error, "Invalid params."}
end
