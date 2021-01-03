import freemarker.template.Configuration;
import freemarker.template.Template;
import java.io.StringWriter;
import java.util.Map;

class View {
	Configuration config = new Configuration();
	
	View() {
		config.setClassForTemplateLoading(View.class, "/");
	}
	
	String render(String name, Map map) {
		try {
			StringWriter writer = new StringWriter();
			Template t = config.getTemplate(name);
			t.process(map, writer);
			return writer.toString();
		} catch (Exception e) { 
			System.out.println(e);
		}
		return "File Not Found.";
	}
	
	String render(String name) {
		return render(name, null);
	}
}

