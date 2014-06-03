VizAnalytics::Application.routes.draw do
  devise_for :users
  root to: "guest#home"
  get "metrics/dashboard"
  get "metrics/engagement"
  get "metrics/acquisition"
  get "metrics/metric/:metric", to: "metrics#metric"
end
