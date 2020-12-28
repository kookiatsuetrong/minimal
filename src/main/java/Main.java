import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.FileWriter;
import java.io.FileReader;
import java.util.Map;
import java.util.HashMap;
import java.util.Scanner;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Main extends HttpServlet {
	
	Map<String,String> mime = new HashMap<>();
	
	@Override public void 
	init() {
		String real = this.getServletContext().getRealPath(".");
		/*
		try {
			File file = new File(real + "/WEB-INF/minimal.sml");
			Scanner in = new Scanner(file);
			while (in.hasNextLine()) {
				String line = in.nextLine();
				String [] fields = line.split("=");
				for (int i = 0; i < fields.length; i++) {
					fields[i] = fields[i].trim();
				}
				if (fields.length >= 2 && fields[0].equals("path")) {
					path = fields[1];
				}
			}
			path = new File(path).getAbsolutePath();
		} catch (Exception e) { }
		*/
		
		try {
			File m = new File(real + "/WEB-INF/mime.sml");
			Scanner in = new Scanner(m);
			while (in.hasNextLine()) {
				String s = in.nextLine();
				String[] f = s.split("=");
				if (f.length == 2) {
					f[0] = f[0].trim();
					f[1] = f[1].trim();
					mime.put(f[0], f[1]);
				}
			}
		} catch (Exception e) { }
	}
	
	@Override public void 
	service(HttpServletRequest request, 
			HttpServletResponse response) {
		try {
			Context context = new Context(request, response);
			String uri = request.getRequestURI();
			switch (uri) {
				default             -> showError(context);
				case "/"            -> showIndex(context);
				case "/run-c"       -> runC(context);
				case "/run-java"    -> runJava(context);
				case "/list-folder" -> listFolder(context);
				case "/read-file"   -> readFile(context);
				case "/write-file"  -> writeFile(context);
				case "/execute"     -> execute(context);
			}
		} catch (Exception e) { }
	}
	
	void 
	execute(Context context) {
		context.response.setHeader("Content-Type", 
					"text/plain; charset=utf-8;");
		String command = context.request.getParameter("command");
		String result = execute(command);
		context.print(result);
	}
	
	String
	execute(String command) {
		StringBuilder result = new StringBuilder();
		try {
			Process process = Runtime.getRuntime().exec(command);
			Killer killer = new Killer(process);
			killer.start();
			int k;
			InputStream error = process.getErrorStream();
			do {
				k = error.read();
				if (k >= 0) {
					result.append((char)k);
				}
			} while (k != -1);
			
			InputStream in = process.getInputStream();
			do {
				k = in.read();
				if (k >= 0) {
					result.append((char)k);
				}
			} while (k != -1);
		} catch (Exception e) {
			result.append(e.toString());
		} finally {
//			File f = new File(name);
//			f.delete();
		}
		return result.toString();
	}
	
	void
	readFile(Context context) {
		String name = context.request.getParameter("name");
		try {
			FileReader reader = new FileReader(name);
			StringBuilder builder = new StringBuilder();
			while (true) {
				int k = reader.read();
				if (k < 0) {
					break;
				}
				builder.append((char)k);
			}
			context.print(builder.toString());
		} catch (Exception e) { 
			context.print(e);
		}
	}
	
	void
	writeFile(Context context) {
		context.response.setHeader("Content-Type", 
					"text/plain; charset=utf-8;");
		String name = context.request.getParameter("name");
		String text = context.request.getParameter("text");
		if (name == null) {
			context.println("Incorrect File Name");
		} else {
			try {
				FileWriter writer = new FileWriter(name);
				writer.write(text);
				writer.close();
				context.println("Success");
			} catch (Exception e) { 
				context.println(e.toString());
			}
		}
	}
	
	void 
	listFolder(Context context) {
		context.response.setHeader("Content-Type", 
				"text/plain; charset=utf-8;");
		String result = listFolder(".");
		context.print(result);
	}
	
	String
	listFolder(String current) {
		String result = "";
		File file = new File(current);
		if (file.isDirectory()) {
			String[] all = file.list();
			for (String s : all) {
				if (s.startsWith(".")) {
					
				} else {
					result += listFolder(current + "/" + s);
				}
			}
		}
		return current + "\n" + result;
	}
	
	void
	showIndex(Context context) {
		context.response.setHeader("Content-Type", 
					"text/plain; charset=utf-8;");
		context.print("The First Page");
	}
	
	void
	showError(Context context) {
		String uri = context.request.getRequestURI();
		String start = context.request.getServletContext().getRealPath("./");
		
		try {
			File file = new File(start + uri);
			if (file.isFile()) {
				String type = null;
				String[] block = uri.split("\\.");
				int last = block.length - 1;
				if (block.length > 0) {
					type = mime.get( block[last] );
				}
				if (type == null) {
					type = "text/plain";
				}
				type += "; charset=utf-8;";
				context.response.setHeader("Content-Type", type);
				Scanner in = new Scanner(file);
				StringBuilder builder = new StringBuilder();
				while (in.hasNextLine()) {
					builder.append( in.nextLine() );
					builder.append( "\n" );
				}
				context.println(builder.toString());
			} else {
				context.println("Not Found");
			}
		} catch (Exception e) { }
	}
	
	void
	runC(Context context) {
		context.response.setHeader("Content-Type", "text/plain;charset=utf-8;");
		context.print("Running C");
	}
	
	void 
	runJava(Context context) {
		context.response.setHeader("Content-Type", "text/plain;charset=utf-8;");
		context.print("Running Java");
	}
}
