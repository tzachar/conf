import dbus
import dbus.glib
import dbus.service
import gobject
import sys
import gtk

def pin_entry(address):
	# build dialog
	dialog = gtk.Dialog("New bluetooth connection", None, gtk.DIALOG_MODAL,
			(gtk.STOCK_CANCEL, gtk.RESPONSE_REJECT, gtk.STOCK_OK, gtk.RESPONSE_ACCEPT))
	dialog.set_default_response(gtk.RESPONSE_ACCEPT)
	dialog.set_position(gtk.WIN_POS_CENTER)

	# tabulka
	table = gtk.Table(2, 2, False)
	dialog.vbox.pack_start(table)
	table.show()

	# entry
	entry = gtk.Entry()
	entry.set_activates_default(True)
	table.attach(entry, 1, 2, 1, 2, gtk.EXPAND|gtk.FILL, gtk.EXPAND|gtk.FILL, 10, 2)
	entry.show()

	# icon
	icon = gtk.Image()
	icon.set_from_stock(gtk.STOCK_DIALOG_AUTHENTICATION, gtk.ICON_SIZE_DIALOG)
	table.attach(icon, 0, 1, 0, 2, gtk.FILL, gtk.FILL, 12, 12)
	icon.show()

	# label
	label = gtk.Label("New bluetooth connection to " + address + "\nPlease enter PIN:")
	label.set_alignment(0, 1)
	table.attach(label, 1, 2, 0, 1, gtk.EXPAND|gtk.FILL, gtk.EXPAND|gtk.FILL, 10, 2)
	label.show()
	
	# run dialog
	if dialog.run() == gtk.RESPONSE_ACCEPT:
		pin = entry.get_text()
	else:
		pin = ""
	dialog.destroy()
	return pin


class PasskeyAgent(dbus.service.Object):
	def __init__(self, path):
		dbus.service.Object.__init__(self, dbus.SystemBus(), path)

	@dbus.service.method(dbus_interface='org.bluez.PasskeyAgent',
						 in_signature='ssb', out_signature='s')

	def Request(self, path, address, numeric):
		try:
			pin = pin_entry(address)
			return pin
		except:
			return ""

if __name__ == "__main__":
	PATH = '/my/PasskeyAgent'
	bus = dbus.SystemBus();
	handler = PasskeyAgent(PATH)
	adapter = bus.get_object('org.bluez', '/org/bluez/hci0')
	sec = dbus.Interface(adapter, 'org.bluez.Security')
	sec.RegisterDefaultPasskeyAgent(PATH)
	main_loop = gobject.MainLoop()
	main_loop.run()

