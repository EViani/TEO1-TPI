package codigo;

public class Lexema {
	private String lexemas;
	private String token;
	
	public Lexema(String l, String t) {
		this.lexemas=l;
		this.token=t;
	}
	
	public String getLexema() {return this.lexemas;};
	public String getToken() {return this.token;};
}
