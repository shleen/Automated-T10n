class TranslationsController < ApplicationController
  before_action :set_up_instance_variables
  before_action :get_submit_text, only: [:index]

  def index; end

  def create
  	# TODO: validate file type. yml only
  	# TODO: validate language code. use another method for that
  	if @translation.update(translation_params)
      translate(@translation)
  	else
  		flash[:alert] = "Something went wrong. Please try again."
  	end
  end

  private

  def set_up_instance_variables
    @translation = Translation.new
    @languages = EasyTranslate::LANGUAGES

    @languages.clone.each do |k, v|
      @languages[k] = v.titleize
    end
    @languages = @languages.invert
  end

  def translation_params
  	params.require(:translation).permit(:yml_file, :from, :to)
  end

  def translate(translation)
    translated = get_translation(translation)
    update_file(translated, translation)
    download_file(translation)
  end

  def get_translation(translation)
  	@text = get_translation_text(translation.yml_file)

  	EasyTranslate.api_key = ENV["GOOGLE_API_KEY"]
 		EasyTranslate.translate(@text, from: translation.from, to: translation.to)
  end

  def get_translation_text(file)
  	@text = []
  	yml_file = YAML.load(File.read(file.path))
  	def check_hash(value)
  		if value.is_a? Hash
  			value.each do |key, value|
  				check_hash(value)
  			end
  		else
  			@text.push value
  		end
  	end
  	
  	yml_file.each do |key, value|
  		check_hash(value)
  	end
  	@text
  end

  def update_file(translated, translation)
  	@yml_file = YAML.load(File.read(translation.yml_file.path))
  	@translated = translated
    @translation = translation

  	def check(k, v, pop = false)
      @i += "['#{k}']"
  		if v.is_a? Hash
  			v.clone.each do |_k, _v|
  				check(_k, _v, v.length > 1)
  			end
  		else 
  			eval("@yml_file#{@i} = @translated[@counter]")
        @counter += 1
  			
        if pop
          @i.slice! "['#{k}']"
        else
          @i = "['#{@translation.from}']"
        end
  		end
  	end

    @counter = 0
    @i = "['#{translation.from}']"
    @yml_file[translation.from].each do |k, v|
      check(k, v)
    end
    @yml_file[translation.to] = @yml_file.delete(translation.from)
    File.open(translation.yml_file.path, 'w') { |f| f.write(@yml_file.to_yaml) }
  end

  def download_file(translation)
    send_file(
      File.open(translation.yml_file.path, 'r'),
      filename: translation.yml_file.identifier,
      type: "application/x-yaml",
      disposition: 'attachment',
      status: 200
    )
  end

  def get_submit_text
    @submit_text = ['Abracadabra!', 'Hocus Pocus!', 'Presto chango!', 'Shazam!'].sample
  end
end