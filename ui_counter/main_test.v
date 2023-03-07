module ui_counter

fn test_update_returns_incremented_model_on_increment() {
	model := Model{}
	incremented_model := update(Message.increment, model)

	assert incremented_model.counter_value == 1
}

fn test_update_returns_decremented_model_on_decrement() {
	model := Model{}
	decremented_model := update(Message.decrement, model)

	assert decremented_model.counter_value == -1
}
