package alumno.model;
import java.util.Date;
public class Documento { //LA CLASE DE DOCUMENT MODELADA EN EL BACKEND
	private String CUI;
	private String categoria;
	private java.sql.Date fechadoc;
	private String nroserie;
	private String direcciondoc;
	
	public Documento(String CUI, String categoria, Date fechadoc,String nroserie,
			String direcciondoc) {
		this.CUI = CUI;
		this.categoria = categoria;
		this.fechadoc = new java.sql.Date(fechadoc.getTime());
		this.nroserie = nroserie;
		this.direcciondoc = direcciondoc;
	}
	public Documento(String CUI, String categoria, java.sql.Date fechadoc,String nroserie,
			String direcciondoc) {
		this.CUI = CUI;
		this.categoria = categoria;
		this.fechadoc = fechadoc;
		this.nroserie = nroserie;
		this.direcciondoc = direcciondoc;
	}
	//getters y setters
	public String getCUI() {
		return CUI;
	}
	public void setCUI(String CUI) {
		this.CUI = CUI;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public java.sql.Date getFechadoc() {
		return fechadoc;
	}
	public void setFechadoc(java.sql.Date fechadoc) {
		this.fechadoc = fechadoc;
	}
	public String getNroserie() {
		return nroserie;
	}
	public void setNroserie(String nroserie) {
		this.nroserie = nroserie;
	}
	public String getDirecciondoc() {
		return direcciondoc;
	}
	public void setDireccionimagen (String direcciondoc) {
		this.direcciondoc = direcciondoc;
	}
}
