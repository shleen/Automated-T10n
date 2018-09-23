class TranslationsController < ApplicationController
  def index
  	@translation = Translation.new

  	yml_file = YAML.load(File.read("config/locales/test.yml"))
  	Rails.logger.info yml_file
  end

  def create
  	@translation = Translation.new

  	if @translation.update(translation_params)
  		yml_file = YAML.load(File.read(@translation.file.path))
  		Rails.logger.info "\n\n\n#{yml_file}\n\n\n"
  	else
  	end
  end

  private

  def translation_params
  	params.require(:translation).permit(:file, :from, :to)
  end
end