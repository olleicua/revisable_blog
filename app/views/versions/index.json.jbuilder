json.array!(@versions) do |version|
  json.extract! version, :id, :title, :content, :post_id, :time
  json.url version_url(version, format: :json)
end
