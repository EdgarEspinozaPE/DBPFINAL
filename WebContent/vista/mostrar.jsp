<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>CSID - Estudiante</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">		
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
			(function() {
				'use strict';
				window.addEventListener('load', function() {
					// Fetch all the forms we want to apply custom Bootstrap validation styles to
					var forms = document.getElementsByClassName('needs-validation');
					// Loop over them and prevent submission
					var validation = Array.prototype.filter.call(forms, function(form) {
						form.addEventListener('submit', function(event) {
							if (form.checkValidity() === false) {
								event.preventDefault();
								event.stopPropagation();
							}
							form.classList.add('was-validated');
						}, false);
					});
				}, false);
			})();
	</script>
</head>

<body>
		<div class="container pt-5">
			<div class="text-center">
				<h1>Estudiante</h1>
			</div>

			<div class="row d-flex justify-content-center">
				<div class="col-md-4 mb-4 pt-5">
					<form class="form-inline md-form mr-auto needs-validation" action ="AdminAlumno?action=mostrarporCUI" method="post" novalidate >
						<input class="form-control is-valid" type="text" placeholder="Buscar" aria-label="Search" name="CUI" required >
						<div class="invalid-feedback">
							Por favor ingrese su b�squeda.
						</div>
						<button class="btn btn-primary" type="submit">Buscar</button>
					</form>
				</div>
			</div>

			<div class="container p-3 my-3 bg-dark d-flex justify-content-center">
				<div class="card" style="width:400px">
					<img class="card-img-top" src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/768px-User_icon_2.svg.png" alt="Card image" style="width:100%">
					<div class="card-body">
						<h4 class="card-title text-black">
							<c:out value="${alumno.apellidopaterno}"></c:out>
							<c:out value="${alumno.apellidomaterno}"></c:out>
							<c:out value="${alumno.nombre}"></c:out>
						</h4>
						<p class="card-text text-black">
							CUI: <c:out value="${alumno.CUI}"></c:out><br>
							DNI: <c:out value="${alumno.DNI}"></c:out><br>
							Correo:<c:out value="${alumno.correo}"></c:out>@unsa.edu.pe<br>
							Fecha de Nacimiento: <c:out value="${alumno.fechanacimiento}"></c:out><br>
							Direccion: <c:out value="${alumno.direccion}"></c:out><br>
							Telefono: <c:out value="${alumno.telefono}"></c:out><br>
							Nivel: <c:out value="${alumno.nivel}"></c:out>
						</p>
						<a href="AdminDocumento?action=mostrar&CUI=<c:out value="${alumno.CUI}" />" class="btn btn-primary">Ver Documentos</a>
					</div>
				</div>
			</div>
			<div class="row d-flex justify-content-center">
				<div class="col-md-4 pt-1">
					<a class="btn btn-primary btn-lg btn-block" href="AdminAlumno?action=showedit&id=<c:out value="${alumno.id}" />" role="button">Editar</a>
				</div>
				<div class="col-md-4 pt-1">
					<a class="btn btn-primary btn-lg btn-block" href="AdminAlumno?action=eliminar&id=<c:out value="${alumno.id}" />" role="button">Eliminar</a>
				</div>
				<div class="col-md-4 pt-1">
					<a class="btn btn-primary btn-lg btn-block" href="AdminAlumno?action=index" role="button">Volver</a>
				</div>
			</div>
		</div>
</body>
</html>