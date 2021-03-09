node 'rogue1' {
	notify { 'HelloWorld!': }
	include ssh
}
