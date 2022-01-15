json.array!(@mydeclutters) do |declutter|
  json.extract! declutter, :id, :title
  json.start declutter.start_date
  json.end declutter.end_date
  json.url declutter_url(declutter)
end