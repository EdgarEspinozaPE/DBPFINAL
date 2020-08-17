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

import alumno.dao.AlumnoDAO;
import alumno.dao.DocumentoDAO;
import alumno.model.Alumno;

/**
 * Servlet implementation class AdminAlumno
 */
@WebServlet("/AdminAlumno")
public class AdminAlumno extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AlumnoDAO alumnoDAO;
	public void init() {
		String jdbcURL = getServletContext().getInitParameter("jdbcURL");
		String jdbcUsername = getServletContext().getInitParameter("jdbcUsername");
		String jdbcPassword = getServletContext().getInitParameter("jdbcPassword");
		try {

			alumnoDAO = new AlumnoDAO(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}  

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminAlumno() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Hola Servlet..");
		String action = request.getParameter("action");
		System.out.println(action);
		try {
			switch (action) { //LE PERMITE AL SERVIDOR SABER QUE ES LO SE EL USUARIO DESEA HACER Y EJECUTA LA FUNCION DADO EL CASO
			case "index":
				index(request, response);
				break;
			case "nuevo":
				nuevo(request, response);
				break;
			case "register":
				System.out.println("entro");
				registrar(request, response);
				break;
			case "mostrar":
				mostrar(request,response);
			case "mostrarporId":
				mostrarporId(request, response);
				break;
			case "mostrarporCUI":
				mostrarporCUI(request, response);
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
		} catch (SQLException e) {
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
	private void index (HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException{
		RequestDispatcher dispatcher= request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
	}
	private void excepcion (HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException{
		//mostrar(request, response);
		RequestDispatcher dispatcher= request.getRequestDispatcher("/vista/error.jsp");
		dispatcher.forward(request, response);
	}
	private void mostrar (HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException{
		RequestDispatcher dispatcher= request.getRequestDispatcher("/vista/mostraraux.jsp");
		dispatcher.forward(request, response);
	}
	private void registrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		SimpleDateFormat formato=new SimpleDateFormat("yyyy/MM/dd");
		Alumno alumno;
		try {
			alumno = new Alumno(0, request.getParameter("CUI"), request.getParameter("DNI"), request.getParameter("nombre"), request.getParameter("apellido_paterno"), 
					request.getParameter("apellido_materno"),formato.parse(request.getParameter("fecha_nacimiento")),request.getParameter("direccion"),
					request.getParameter("telefono"),request.getParameter("nivel"),request.getParameter("correo"));
			alumnoDAO.insertar(alumno);
			RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
			dispatcher.forward(request, response);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void nuevo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/vista/register.jsp");
		dispatcher.forward(request, response);
	}
	
	private void mostrarporId(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException , ServletException{ //FUNCION QUE NOS SIRVE 
		RequestDispatcher dispatcher = request.getRequestDispatcher("/vista/mostrar.jsp");													//PARA RECUPERAR RAPIDAMENTE UN ALUMNO POR EJEMPLO PARA EDITAR
		Alumno alumno = alumnoDAO.obtenerPorId(Integer.parseInt(request.getParameter("id")));
		request.setAttribute("alumno", alumno);
		dispatcher.forward(request, response);
	}
	private void mostrarporCUI(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException , ServletException{ //AUNQUE LA FUNCION SE LLAME ASI ES UNA BUSQUEDA SOBRECARGADA
		RequestDispatcher dispatcher = request.getRequestDispatcher("/vista/mostrar.jsp");
		Alumno alumno = alumnoDAO.obtenerPorCUI(request.getParameter("CUI")); //EL CUI ES NUESTRO CRITERIO DE BUSQUEDA NO NECESARIAMENTE ES UN CUI SOLO LO RECIBE CON ESE NOMBRE DESDE EL FRONTEND 
		if(alumno == null) {
			if( isNumeric(request.getParameter("CUI"))==false ) {
				String[] apellidos= request.getParameter("CUI").split(" ");
				alumno=alumnoDAO.obtenerPorApellidos(apellidos[0], apellidos[1]);
				if(alumno==null)
				{
					mostrar(request,response);
				}
				else {
					request.setAttribute("alumno", alumno);
					dispatcher.forward(request, response);
				}
			}
			else {
				alumno=alumnoDAO.obtenerPorDNI(request.getParameter("CUI"));
				if(alumno==null)
				{
					mostrar(request,response);
				}
				else {
					request.setAttribute("alumno", alumno);
					dispatcher.forward(request, response);
				}
			}
		}
		else
			request.setAttribute("alumno", alumno);
			dispatcher.forward(request, response);
	}
	
	private void showEditar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		Alumno alumno = alumnoDAO.obtenerPorId(Integer.parseInt(request.getParameter("id")));
		request.setAttribute("alumno", alumno);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/vista/editar.jsp");
		dispatcher.forward(request, response);
	}
	
	private void editar(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException{
		SimpleDateFormat formato=new SimpleDateFormat("yyyy/MM/dd");
		Alumno alumno;
		try {
			alumno = new Alumno(Integer.parseInt(request.getParameter("id")), request.getParameter("CUI"), request.getParameter("DNI"),request.getParameter("nombre"), request.getParameter("apellido_paterno"), 
					request.getParameter("apellido_materno"),formato.parse(request.getParameter("fecha_nacimiento")),request.getParameter("direccion"),
					request.getParameter("telefono"),request.getParameter("nivel"),request.getParameter("correo"));
			alumnoDAO.actualizar(alumno);
			index(request, response);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private void eliminar(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException{
		Alumno alumno = alumnoDAO.obtenerPorId(Integer.parseInt(request.getParameter("id")));
		alumnoDAO.eliminar(alumno);
		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
		
	}
	private static boolean isNumeric(String cadena) {
		try {
			Integer.parseInt(cadena);
			return true;
		} catch(NumberFormatException nfe) {
			return false;
		}
	}
}
