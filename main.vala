using Gtk;

public class GuiApp : Gtk.Application {

	public GuiApp () {
		Object (application_id: "org.sadeep.comclient");
	}

	public override void activate () {

		var window = new Gtk.Window ();
		window.title = "Com Client";

		window.set_default_size (700, 300);
		window.window_position = Gtk.WindowPosition.CENTER;
		window.border_width = 10;

		var button = new Gtk.Button.with_label ("Send");
		button.show();
		window.add(button);

		this.add_window (window);
		window.show ();
	}
}




class Main : GLib.Object {

    public static int main(string[] args) {

        stdout.printf("Hello, World\n");
        new GuiApp().run();
        return 0;

        
    }
}