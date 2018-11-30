extends GridContainer

func _ready():
	var result_types = results.shooter_data.keys()
	for result_type in result_types:
		var description = Label.new()
		description.text = result_type
		add_child(description)
		var value = Label.new()
		value.text = str(results.shooter_data[result_type])
		add_child(value)
	pass

