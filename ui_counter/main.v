import ui

[heap]
struct App {
mut:
	window ui.Window
	label  ui.Label
	model  Model
}

struct Model {
	counter_value int
}

enum Message {
	increment
	decrement
}

fn main() {
	mut app := App{}
	setup_app(mut app)

	ui.run(app.window)
}

fn setup_app(mut app App) {
	app.window = ui.window(
		width: 400
		height: 400
		title: 'MVU counter'
		children: [
			ui.column(
				margin: ui.Margin{50, 50, 50, 50}
				spacing: 5
				children: [
					app.label,
					ui.row(
						spacing: 5
						children: [
							ui.button(
								text: 'Increment'
								width: 100
								height: 50
								text_size: 20
								on_click: app.send_increment_signal
							),
							ui.button(
								text: 'Decrement'
								width: 100
								height: 50
								text_size: 20
								on_click: app.send_decrement_signal
							),
						]
					),
				]
			),
		]
	)

	app.label = ui.label(text: '0', text_size: 36)
}

fn (mut app App) send_increment_signal(_ &ui.Button) {
	app.model = update(Message.increment, app.model)
	app.react_on_model_change()
}

fn (mut app App) send_decrement_signal(_ &ui.Button) {
	app.model = update(Message.decrement, app.model)
	app.react_on_model_change()
}

fn update(message Message, current_model Model) Model {
	return match message {
		.increment {
			Model{
				counter_value: current_model.counter_value + 1
			}
		}
		.decrement {
			Model{
				counter_value: current_model.counter_value - 1
			}
		}
	}
}

fn (mut app App) react_on_model_change() {
	app.label.text = app.model.counter_value.str()
}
