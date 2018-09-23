class Translation < ApplicationRecord
	mount_uploader :file, TranslationUploader
end