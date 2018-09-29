class RenameFileToFileNameForTranslations < ActiveRecord::Migration[5.2]
  def change
  	rename_column :translations, :file, :yml_file
  end
end