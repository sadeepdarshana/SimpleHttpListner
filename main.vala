using Gtk;

public class GuiApp : Gtk.Application {

	public GuiApp () {
		Object (application_id: "org.sadeep.comapp");
	}

	public override void activate () {

		var window = new Gtk.Window ();
		window.title = "Welcome to GNOME";


		//window.border_width = 10;
		//window.set_default_size (350, 70);
		//window.window_position = Gtk.WindowPosition.CENTER;

		/* Add the window to this application. */
		this.add_window (window);

		/* Show the window. */
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