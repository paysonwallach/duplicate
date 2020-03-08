namespace Duplicate {
    public class Duplicator {

        private enum Generation {
            PARENT,
            CHILD,
            GRANDCHILD,
            DESCENDENT
        }

        private string get_destination_filename_base(string[] filename_components, Generation generation, int iteration) {
            var builder = new StringBuilder ();

            builder.append (filename_components[0]);

            switch (generation) {
            case PARENT:
                builder
                    .append (" (")
                    .append (_("copy"))
                    .append (")");

                break;
            case CHILD:
                builder
                    .append (" ")
                    .append (iteration.to_string ())
                    .append (filename_components[5]);

                break;
            case GRANDCHILD:
                builder
                    .append (filename_components[3])
                    .append (filename_components[4])
                    .append ("-")
                    .append (iteration.to_string ())
                    .append (filename_components[5]);
                break;
            case DESCENDENT:
                builder.append (filename_components[1]);

                if (iteration == 1) {
                    builder
                        .append (filename_components[4])
                        .append ("-")
                        .append (iteration.to_string ());
                } else {
                    builder
                        .append (iteration.to_string ());
                }

                builder.append (filename_components[5]);

                break;
            };

            return builder.str;
        }

        private GLib.File get_destination_file(
            GLib.File source,
            string filename,
            GLib.Regex filename_regex,
            Generation generation)
        {
            var iteration = 1;
            GLib.File? destination_file = null;
            string[] name_split = filename.split(".");

            do {
                var filename_components = filename_regex.split(name_split[0]);

                name_split[0] = get_destination_filename_base (filename_components, generation, iteration++);

                if (generation == Generation.PARENT) {
                    generation = Generation.CHILD;
                } else if (generation == Generation.GRANDCHILD) {
                    generation = Generation.DESCENDENT;
                }

                var destination_filename = string.joinv (".", name_split);
                var dest_file_path = GLib.Path.build_path (source.get_parent ().get_path (), destination_filename);

                destination_file = GLib.File.new_for_path (dest_file_path);
            } while (destination_file.query_exists ());

            return destination_file;
        }

        private void error (string message) {
            Gtk.MessageDialog dialog = new Gtk.MessageDialog (null, 0, Gtk.MessageType.ERROR, Gtk.ButtonsType.CLOSE, message);

            dialog.run ();
            dialog.destroy ();
        }

        public int duplicate (GLib.File[] files) {
            foreach (var file in files) {
                string name = "";

                try {
                    FileInfo file_info = file.query_info (GLib.FileAttribute.STANDARD_NAME, GLib.FileQueryInfoFlags.NONE);

                    name = file_info.get_name ();
                } catch (Error err) {
                    error (err.message);

                    return 1;
                }

                GLib.Regex filename_regex = new GLib.Regex ("((?:(?:\\d+)(\\-))+)*(\\s)*(\\d*)(\\))$");
                GLib.MatchInfo match_info;

                var match = filename_regex.match(name, GLib.RegexMatchFlags.NOTEMPTY, out match_info);
                var generation = Generation.PARENT;

                if (match) {
                    if (match_info.fetch(5).length > 0) {
                        generation = Generation.CHILD;

                        if (match_info.fetch(3).length > 0) {
                            generation = Generation.GRANDCHILD;
                        } else if (match_info.fetch(2).length > 0) {
                            generation = Generation.DESCENDENT;
                        }
                    }
                }

                var dest_file = get_destination_file (file, name, filename_regex, generation);

                try {
                    file.copy (dest_file, FileCopyFlags.NOFOLLOW_SYMLINKS);
                } catch (Error err) {
                    error (err.message);
                }
            }

            return 0;
        }
    }
}
