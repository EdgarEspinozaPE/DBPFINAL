<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>CSID - Edit</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
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

			function validateForm() {
				var fecha;

				fecha = document.getElementById("validationCustomDate").value;

				var fechaToParse = fecha.split('-');
				var yyyy = fechaToParse[0];
				var mm = fechaToParse[1];
				var dd = fechaToParse[2];

				if ((1900 <= yyyy && yyyy <= 2100) && (1 <= mm <= 12) && (1 <= dd <= 31)) {
					var fechaParsed = yyyy + '/' + mm + '/' + dd;
					document.getElementById("validationCustomDate").value = fechaParsed;
				}
				else {
					alert("La fecha no sigue el formato indicado");
					return false;
				}
				return true;
			}
		</script>
	</head>
	<body>
		<div class="container pt-5">
			<div class="text-center">
				<h1>Editar Documento</h1>
			</div>

			<div class="container p-3 my-3 bg-dark text-white">
				<form class="needs-validation" action="AdminDocumento?action=editar&CUI=${documento.CUI}" method="post" onsubmit="return validateForm()" novalidate>
					<div class="form-row">
						<div class="col-md-4 mb-3">
							<label for="exampleFormControlSelect1">Categoría</label>
							<select class="form-control" id="exampleFormControlSelect1" name="categoria" value="${documento.categoria}">
								<c:forEach var="categorias" items="${listacategorias}">
									<option value="${categorias}">${categorias}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomDate">Fecha</label>
							<input type="text" class="form-control is-valid" id="validationCustomDate" placeholder="yyyy-mm-dd" required value="${documento.fechadoc}" name="fechadoc" >
							<div class="invalid-feedback">
								Por favor ingrese la fecha.
							</div>
						</div>						
						<div class="col-md-4 mb-3">
							<label for="validationSerialNumber">N° de serie</label>
							<input type="text" class="form-control is-valid" id="validationSerialNumber" placeholder="Número de serie" maxlength="8" required value="${documento.nroserie}" name="nroserie">
							<div class="invalid-feedback">
								Por favor ingrese un número de serie.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationLink">Link</label>
							<input type="text" class="form-control is-valid" id="validationLink" placeholder="Link" maxlength="300" required value="${documento.direcciondoc}" name="direcciondoc">
							<div class="invalid-feedback">
								Por favor ingrese un link.
							</div>
						</div>
					</div>
					<button class="btn btn-primary" type="submit">Guardar</button>
				</form>
			</div>
		</div>
	</body>
</html>