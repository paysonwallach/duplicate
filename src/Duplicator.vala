namespace Duplicate {
    public class Duplicator {
        public void duplicate (GLib.File[] files) {
            foreach (var file in files) {
                string name = "";

                try {
                    FileInfo file_info = file.query_info (GLib.FileAttribute.STANDARD_NAME, GLib.FileQueryInfoFlags.NONE);

                    name = file_info.get_name ();
                } catch (Error err) {
                    error (err.message);
                }

                string[] name_split = name.split(".");

                name_split[0] = name_split[0].concat (" (copy)");
                name = string.joinv(".", name_split);

                var dest_file_path = GLib.Path.build_path (file.get_parent ().get_path (), name);
                var dest_file = File.new_for_path (dest_file_path);

                try {
                    file.copy (dest_file, FileCopyFlags.NONE);
                } catch (Error err) {
                    error (err.message);
                }
            }
        }

        private void error (string message) {
            Gtk.MessageDialog dialog = new Gtk.MessageDialog (null, 0, Gtk.MessageType.ERROR, Gtk.ButtonsType.CLOSE, message);
            dialog.run ();
            dialog.destroy ();
        }
    }
}
