class ChangeColumnNullTasks < ActiveRecord::Migration[6.0]
  change_column_null(:tasks, :name, false)
  change_column_null(:tasks, :retail, false)
end
