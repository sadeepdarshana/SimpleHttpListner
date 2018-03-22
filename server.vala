void process_request (InputStream input, OutputStream output) throws Error {
    var data_in = new DataInputStream (input);
    string line;
    while ((line = data_in.read_line (null)) != null) {
        stdout.printf ("%s\n", line);
        if (line.strip () == "") break;
    }

}

int main () {
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
    return 0;
}