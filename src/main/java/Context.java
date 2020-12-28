import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

class Context {
	
	PrintWriter out;
	HttpServletRequest request;
	HttpServletResponse response;
	
	Context(HttpServletRequest request, 
			HttpServletResponse response) {
		this.request = request;
		this.response = response;
		try {
			out = response.getWriter();
		} catch (Exception e) { }
	}
	
	void print(Object o) {
		out.print(o);
	}
	
	void println(Object o) {
		out.println(o);
	}
}

