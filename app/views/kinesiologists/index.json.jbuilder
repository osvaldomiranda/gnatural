json.array!(@kinesiologists) do |kinesiologist|
  json.extract! kinesiologist, :id, :id_centro, :nombre, :hh_mensuales
  json.url kinesiologist_url(kinesiologist, format: :json)
end
