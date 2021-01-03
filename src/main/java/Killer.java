class Killer extends Thread {
	
	Process process;
	
	Killer(Process p) {
		process = p;
	}
	
	public void run() {
		try {
			Thread.sleep(60000);
			process.destroy();
		} catch (Exception e) { }
	}
}
