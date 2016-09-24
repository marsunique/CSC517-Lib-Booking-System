json.extract! room, :id, :number, :size, :building, :created_at, :updated_at
json.url room_url(room, format: :json)