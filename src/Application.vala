/*
 * Duplicate
 *
 * Copyright (c) 2019 Payson Wallach
 *
 * Released under the terms of the GNU General Public License, version 3
 * (https://gnu.org/licenses/gpl.html)
 */

namespace Duplicate {
    public class Application : Gtk.Application {
        private Duplicator duplicator;

        public Application () {
            application_id = "com.paysonwallach.duplicate";
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
