namespace Duplicate {
    public class Application : Gtk.Application {
        private Duplicator duplicator;

        public Application () {
            application_id = "com.paysonwallach.duplicate"; //Constants.application_id;
            flags |= GLib.ApplicationFlags.HANDLES_OPEN;
        }

        public override void open (GLib.File[] files, string str) {
            if (duplicator == null) {
                duplicator = new Duplicator ();
            }

            duplicator.duplicate (files);
        }
    }
}
