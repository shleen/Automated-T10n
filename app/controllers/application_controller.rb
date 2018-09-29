class ApplicationController < ActionController::Base

unless Rails.env.production?
  ENV['GOOGLE_API_KEY'] = "AIzaSyBbbM4Tj4TXELeu6gVoridm85IdrFT8kiE"
end
end