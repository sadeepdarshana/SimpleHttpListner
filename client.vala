using Gtk;

public class GuiApp : Gtk.Application {


	public const string host = "localhost";

	private Entry sendText;

	public GuiApp () {
		Object (application_id: "org.sadeep.comclient");
	}

	public override void activate () {



		Builder builder = new Builder();
		builder.add_from_file ("client.ui");
		var window = builder.get_object ("mainwindow") as ApplicationWindow;
		var sendButton = builder.get_object ("sendbutton") as Button;
		sendText = builder.get_object ("sendtext") as Entry;

		sendButton.clicked.connect(send);

		this.add_window (window);
		window.show ();
	}

	private void send(){
		stdout.printf("initiating...");
		
		var resolver = Resolver.get_default ();
        var addresses = resolver.lookup_by_name (host, null);
		var address = addresses.nth_data (0);
		

        var client = new SocketClient ();
		var conn = client.connect (new InetSocketAddress (address, 8080));
		

        var message = sendText.text;
        conn.output_stream.write (message.data);
		print ("Wrote request\n");
		
	}
}




class Main : GLib.Object {

    public static int main(string[] args) {

        stdout.printf("Hello, World\n");
        new GuiApp().run();
        return 0;

        
    }
}