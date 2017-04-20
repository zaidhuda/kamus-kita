class FaqController < ApplicationController
  def index
    @faq_categories = t ('faq')
  end
end
