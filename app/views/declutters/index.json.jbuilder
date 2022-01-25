json.array!(@mydeclutters) do |declutter|
  json.extract! declutter, :id, :title, :user_id
  json.start declutter.start_date
  json.end declutter.end_date
  json.url declutter_url(declutter)
end