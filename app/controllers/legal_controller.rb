class LegalController < ApplicationController
  layout 'legal'
  def privacy
  end

  def tos
    redirect_to privacy_path, turbolinks: true
  end
end
