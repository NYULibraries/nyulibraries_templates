Rails.application.routes.draw do

  mount NyulibrariesTemplates::Engine => "/restaurant_menu"
end
