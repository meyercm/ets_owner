defmodule EtsOwnerTest do
  use ExUnit.Case

  test "creates tables that don't exist" do
    assert :ets.info(TestTable1) == :undefined
    EtsOwner.create_table(TestTable1, :set)
    refute :ets.info(TestTable1) == :undefined
  end

  test "doesn't crash if the table exists" do
    assert :ets.info(TestTable2) == :undefined
    EtsOwner.create_table(TestTable2, :set)
    refute :ets.info(TestTable2) == :undefined
    EtsOwner.create_table(TestTable2, :set)
    refute :ets.info(TestTable2) == :undefined
  end
end
