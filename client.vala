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

		Thread.usleep(5000000);
		
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


void server(){

    try {
        var service = new SocketService ();
        service.add_inet_port (8080, null);
        service.start ();
        while (true) {
            var conn = service.accept (null);
            process_request (conn.input_stream, conn.output_stream);
        }
    } catch (Error e) {
        stderr.printf ("%s\n", e.message);
    }
    return;
}
void process_request (InputStream input, OutputStream output) throws Error {
    var data_in = new DataInputStream (input);
    string line;
    while ((line = data_in.read_line (null)) != null) {
        stdout.printf ("%s\n", line);
        if (line.strip () == "") break;
    }

}


class Main : GLib.Object {

    public static int main(string[] args) {


		Thread.create<void> (server, true);

        new GuiApp().run();
		
		return 0;
    }
}