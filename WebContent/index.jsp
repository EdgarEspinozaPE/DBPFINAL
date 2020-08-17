<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
	<head>
		<title>CSID - Inicio</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	</head>
	<body>
		<div class="container pt-5">
			<div class="text-center">
				<h1>¡Bienvenido a CSID!</h1>
			</div>
			<div class="row d-flex justify-content-center pt-5">
				<div class="col-md-5 mb-3">
					<div class="container p-3 my-3 bg-dark">
						<img src="search.png" class="mx-auto d-block" style="width:50%">
						<div class="container pt-3">
							<a class="btn btn-primary btn-lg btn-block" href="AdminAlumno?action=mostrar" role="button">Buscar</a>
						</div>
					</div>
				</div>
				<div class="col-md-5 mb-3">
					<div class="container p-3 my-3 bg-dark">
						<img src="register.png" class="mx-auto d-block" style="width:50%">
						<div class="container pt-3">
							<a class="btn btn-primary btn-lg btn-block" href="AdminAlumno?action=nuevo" role="button">Registrar</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>