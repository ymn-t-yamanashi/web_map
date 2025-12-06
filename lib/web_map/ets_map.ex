defmodule WebMap.EtsMap do
  @ets_table :data_store

  def init() do
    :ets.new(@ets_table, [:set, :public, :named_table])
    :ets.insert(@ets_table, {:id, 0})
  end

  def get_next_id() do
    :ets.update_counter(@ets_table, :id, 1)
  end

  def insert(id, map) do
    :ets.insert(@ets_table, {id_from_name(id), map})
  end

  def insert(map) do
    id = get_next_id()
    :ets.insert(@ets_table, {id_from_name(id), map})
    id
  end

  def get(id) when is_integer(id) do
    :ets.lookup(@ets_table, id_from_name(id))
    |> get_map_from_no()
  end

  defp get_map_from_no([{_, data}]) do
    data
  end

  defp get_map_from_no([]) do
    %{}
  end

  def delte(id) do
    :ets.delete(@ets_table, id_from_name(id))
  end

  defp id_from_name(id) do
    "id_#{id}"
  end
end
