package alumno.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;
import java.text.ParseException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import alumno.dao.DocumentoDAO;
import alumno.model.Alumno;
import alumno.model.Documento;

/**
 * Servlet implementation class AdminDocumento
 */
@WebServlet("/AdminDocumento")
public class AdminDocumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DocumentoDAO documentoDAO;
	public void init() {
		String jdbcURL = getServletContext().getInitParameter("jdbcURL");
		String jdbcUsername = getServletContext().getInitParameter("jdbcUsername");
		String jdbcPassword = getServletContext().getInitParameter("jdbcPassword");
		try {

			documentoDAO = new DocumentoDAO(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDocumento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Hola Servlet.."); //AL IGUAL QUE EL ADMINALUMNO ESTE ES EL SERVLET QUE VERA QUE ACCION QUIERE REALIZAR EL USUARIO
		String action = request.getParameter("action");
		System.out.println(action);
		try {
			switch (action) {
			case "nuevo":
				nuevo(request, response);
				break;
			case "register":
				System.out.println("entro");
				registrar(request, response);
				break;
			case "mostrar":
				mostrar(request, response);
				break;
			case "mostrarporNroserie":
				mostrarporNroserie(request, response);
				break;
			case "mostrarporId":
				mostrarporId(request, response);
				break;
			case "showedit":
				showEditar(request, response);
				break;	
			case "editar":
				editar(request, response);
				break;
			case "eliminar":
				eliminar(request, response);
				break;
			default:
				break;
			}			
		} catch (SQLException e) { //ESTA PARTE DEL CODE MANEJARA LAS EXCEPCIONES PRODUCIDAS POR LA BASE DE DATOS
			try {
				excepcion(request,response);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (ServletException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.getStackTrace(); 
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Hola Servlet..");
		doGet(request, response);
	}
	private void excepcion (HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException{
		//mostrar(request, response);
		RequestDispatcher dispatcher= request.getRequestDispatcher("/vista/errordocument.jsp");
		dispatcher.forward(request, response);
	}

	private void registrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		SimpleDateFormat formato=new SimpleDateFormat("yyyy/MM/dd");
		Documento documento;
		try {
			documento = new Documento(request.getParameter("CUI"), request.getParameter("categoria"),formato.parse(request.getParameter("fechadoc")),request.getParameter("nroserie"),
					request.getParameter("direcciondoc"));
			documentoDAO.insertar(documento);
			mostrar(request,response);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void nuevo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		
		String cuipaso= request.getParameter("CUI");
		List<String> listaCategories = documentoDAO.listarCategories();
		request.setAttribute("CUI", cuipaso);
		request.setAttribute("lista", listaCategories);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/vista/registerdocument.jsp");
		dispatcher.forward(request, response);
	}
	
	
	private void mostrar(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException , ServletException{
		RequestDispatcher dispatcher = request.getRequestDispatcher("/vista/mostrardocument.jsp");
		List<Documento> listaDocumentos= documentoDAO.listarDocumentos(request.getParameter("CUI"));
		List<String> listacategorias = documentoDAO.listarCategories();
		String cuipaso=request.getParameter("CUI");
		request.setAttribute("CUI", cuipaso);
		request.setAttribute("lista", listaDocumentos);
		request.setAttribute("listacategorias", listacategorias);
		dispatcher.forward(request, response);
	}
	private void mostrarporId(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException , ServletException{
		RequestDispatcher dispatcher = request.getRequestDispatcher("/vista/mostrar.jsp");
		Documento documento = documentoDAO.obtenerPorNroserie("1");
		request.setAttribute("documento", documento);
		dispatcher.forward(request, response);
	}	
	
	private void showEditar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		Documento documento = documentoDAO.obtenerPorNroserie(request.getParameter("nroserie"));
		List<String> listacategorias = documentoDAO.listarCategories();
		request.setAttribute("documento", documento);
		request.setAttribute("listacategorias", listacategorias);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/vista/editardocument.jsp");
		dispatcher.forward(request, response);
	}
	private void mostrarporNroserie(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException , ServletException{
		List<Documento> listaDocumentos;
		List<String> listacategorias = documentoDAO.listarCategories();
		request.setAttribute("listacategorias", listacategorias);
		if(request.getParameter("nroserie")=="" & request.getParameter("categoria").equals("Todos")) {
			mostrar(request,response);
		}
		else if(request.getParameter("nroserie")!=""){
			listaDocumentos= documentoDAO.listarUnitario(request.getParameter("CUI"),request.getParameter("nroserie"));
			if(listaDocumentos.isEmpty() & isDate(request.getParameter("nroserie"))) {
				if(request.getParameter("categoria").equals("Todos")==false) {
					listaDocumentos = documentoDAO.listarFecha(request.getParameter("CUI"),request.getParameter("nroserie"),request.getParameter("categoria"));
				}
				else {
					listaDocumentos = documentoDAO.listarFechaTodos(request.getParameter("CUI"), request.getParameter("nroserie"));
				}
			}
			String cuipaso = request.getParameter("CUI");
			request.setAttribute("CUI", cuipaso);
			request.setAttribute("lista", listaDocumentos);
			request.setAttribute("listacategorias", listacategorias);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/vista/mostrardocument.jsp");
			dispatcher.forward(request, response);
		}
		else {
			listaDocumentos = documentoDAO.listarPorCategoria(request.getParameter("CUI"), request.getParameter("categoria"));
			String cuipaso = request.getParameter("CUI");
			request.setAttribute("CUI", cuipaso);
			request.setAttribute("lista", listaDocumentos);
			request.setAttribute("listacategorias", listacategorias);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/vista/mostrardocument.jsp");
			dispatcher.forward(request, response);
		}	
	}
	private void editar(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException{
		SimpleDateFormat formato=new SimpleDateFormat("yyyy/MM/dd");
		Documento documento;
		try {
			documento = new Documento(request.getParameter("CUI"), request.getParameter("categoria"),formato.parse(request.getParameter("fechadoc")),request.getParameter("nroserie"),
					request.getParameter("direcciondoc"));
			documentoDAO.actualizar(documento);
			mostrar(request, response);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private void eliminar(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException{
		Documento documento = documentoDAO.obtenerPorNroserie(request.getParameter("nroserie"));
		documentoDAO.eliminar(documento);
		mostrar(request,response);
	}
	private static boolean isDate(String cadena) {
		SimpleDateFormat formato=new SimpleDateFormat("yyyy/MM/dd");
		try {
			formato.parse(cadena);
			return true;
		} catch(ParseException e) {
			return false;
		}
	}

}
