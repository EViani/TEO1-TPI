package codigo;

public class Simbolos {
	private String nombre;
	private String token;
	private String tipo;
	private String valor;
	private int longitud;
	
	public Simbolos(String n, String to) {
		this.nombre=n;
		this.token=to;
		this.longitud=0;
		this.valor="";
		this.tipo="--";
		if (to != "ID") {
			if (to == "CONST_STRING") {
				this.longitud = nombre.length()-2;
				this.nombre=nombre.substring(1,nombre.length()-1);
			}
			this.valor=nombre;
			this.nombre= "_"+this.nombre;
		
		} else {
			this.tipo="ID";
		}
	};
	
	public Simbolos(String n, String to, String ti) {
		this.nombre=n;
		this.token=to;
		this.longitud=0;
		this.valor="";
		this.tipo=ti;
		if (to != "ID") {
			if (to == "CONST_STRING") {
				this.longitud = nombre.length()-2;
				this.nombre=nombre.substring(1,nombre.length()-1);
			}
			this.valor=nombre;
			this.nombre= "_"+this.nombre;
		}
	};
	
	public String getNombre() {
		return nombre;
	}

	public String getToken() {
		return token;
	}

	public String getTipo() {
		return tipo;
	}

	public String getValor() {
		return valor;
	}

	public int getLongitud() {
		return longitud;
	}
	
	public void setTipo(String t) {
		this.tipo=t;
	}
	@Override
	public String toString() {
		String s ="";
		s+= String.format("%s | %s | %s | %s | %d | %n",nombre,token,tipo,valor,longitud);
		return s;
	}
}
