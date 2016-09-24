json.extract! history, :id, :number, :building, :email, :date, :begintime, :endtime, :created_at, :updated_at
json.url history_url(history, format: :json)