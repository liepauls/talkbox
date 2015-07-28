module ChatroomsHelper

	def access_room(index)
		Room.all.as_json[index]["name"]
	end

end
