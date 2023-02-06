import os

struct Model {
	value int
}

enum Message {
	increment
	decrement
}

fn main() {
	app_loop := spawn process_app_loop()
	app_loop.wait()
}

fn process_app_loop() {
	mut model := Model{}

	for {
		println('Press + to increment, - to decrement, or q to quit')

		match os.get_line() {
			'+' {
				model = update(Message.increment, model)
			}
			'-' {
				model = update(Message.decrement, model)
			}
			'q' {
				break
			}
			else {
				println('Invalid input')
			}
		}

		spawn view(model)
	}
}

fn update(message Message, current_model Model) Model {
	return match message {
		.increment {
			Model{
				value: current_model.value + 1
			}
		}
		.decrement {
			Model{
				value: current_model.value - 1
			}
		}
	}
}

fn view(current_model Model) {
	println(current_model.value)
}
