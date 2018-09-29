class Translation < ApplicationRecord
	mount_uploader :yml_file, TranslationUploader
end