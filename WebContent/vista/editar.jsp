<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>CSID - Editar</title>
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
				var nombres, apellidopaterno, apellidomaterno, CUI, DNI, telefono, fecha;

				nombres = document.getElementById("validationCustomName").value;
				apellidopaterno = document.getElementById("validationCustomFathersSurname").value;
				apellidomaterno = document.getElementById("validationCustomMothersSurname").value;
				CUI = document.getElementById("validationCustomCUI").value;
				DNI = document.getElementById("validationCustomDNI").value;
				telefono = document.getElementById("validationCustomPhone").value;
				fecha = document.getElementById("validationCustomBirthday").value;

				var fechaToParse = fecha.split('-');
				var yyyy = fechaToParse[0];
				var mm = fechaToParse[1];
				var dd = fechaToParse[2];

				expresionHasChar = /[A-z]/;
				expresionHasNumber = /[0-9]/;
				expresionHasSymbol = /[.:$#@^&*]/;

				if ((1900 <= yyyy && yyyy <= 2100) && (1 <= mm <= 12) && (1 <= dd <= 31)) {
					var fechaParsed = yyyy + '/' + mm + '/' + dd;
					document.getElementById("validationCustomBirthday").value = fechaParsed;
				}
				else {
					alert("La fecha no sigue el formato indicado");
					return false;
				}

				alert(fechaParsed);

				if (!expresionHasChar.test(nombres)) {
					alert("Los nombres solo deben contener caracteres");
					return false;
				} else if (!expresionHasChar.test(apellidopaterno) || expresionHasNumber.test(apellidopaterno) || expresionHasSymbol.test(apellidopaterno)) {
					alert("El apellido paterno solo debe contener caracteres");
					return false;
				} else if (!expresionHasChar.test(apellidomaterno) || expresionHasNumber.test(apellidomaterno) || expresionHasSymbol.test(apellidomaterno)) {
					alert("El apellido materno solo debe contener caracteres");
					return false;
				} else if (!expresionHasNumber.test(CUI) || expresionHasChar.test(CUI) || expresionHasSymbol.test(CUI)) {
					alert("Ingrese un CUI válido");
					return false;
				} else if (!expresionHasNumber.test(DNI) || expresionHasChar.test(DNI) || 	expresionHasSymbol.test(DNI)) {
					alert("Ingrese un DNI válido");
					return false;
				} else if (!expresionHasNumber.test(telefono) || expresionHasChar.test(telefono) || expresionHasSymbol.test(telefono)) {
					alert("Ingrese un telefono válido");
					return false;
				}
				return true;
			}
		</script>
	</head>
	<body>
		<div class="container pt-5">
			<div class="text-center">
				<h1>Editar Estudiante</h1>
			</div>

			<div class="container p-3 my-3 bg-dark text-white">
				<form action='AdminAlumno?action=editar&id=<c:out value="${alumno.id}" />' class="needs-validation" method="post" onsubmit="return validateForm()" novalidate>
					<div class="form-row">
						<div class="col-md-4 mb-3">
							<label for="validationCustomName">Nombres</label>
							<input type="text" class="form-control is-valid" id="validationCustomName" placeholder="Nombres" maxlength="45" name ="nombre" value='<c:out value="${alumno.nombre}"></c:out>' required>
							<div class="invalid-feedback">
								Por favor ingrese los nombres del estudiante.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomFathersSurname">Apellido paterno</label>
							<input type="text" class="form-control is-valid" id="validationCustomFathersSurname" placeholder="Father's surname" maxlength="45" name ="apellido_paterno" value='<c:out value="${alumno.apellidopaterno}"></c:out>' required>
							<div class="invalid-feedback">
								Por favor ingrese el apellido paterno del estudiante.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomMothersSurname">Apellido materno</label>
							<input type="text" class="form-control is-valid" id="validationCustomMothersSurname" placeholder="Mother's surname" maxlength="45" name= "apellido_materno" value='<c:out value="${alumno.apellidomaterno}"></c:out>' required>
							<div class="invalid-feedback">
								Por favor ingrese el apellido materno del estudiante.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomUsername">Correo institucional</label>
							<div class="input-group">
								<input type="text" class="form-control is-valid" id="validationCustomUsername" placeholder="Correo" maxlength="45" value='<c:out value="${alumno.correo}"></c:out>' name="correo" aria-describedby="inputGroupPrepend">
								<div class="input-group-prepend">
									<span class="input-group-text" id="inputGroupPrepend">@unsa.edu.pe</span>
								</div>
								<div class="invalid-feedback">
									Por favor ingrese el correo institucional.
								</div>
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomCUI">CUI</label>
							<input type="text" class="form-control is-valid" id="validationCustomCUI" placeholder="CUI" maxlength="8" name="CUI" value='<c:out value="${alumno.CUI}"></c:out>' required>
							<div class="invalid-feedback">
								Por favor ingrese un CUI.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomDNI">DNI</label>
							<input type="text" class="form-control is-valid" id="validationCustomDNI" placeholder="DNI" maxlength="8" name="DNI" value='<c:out value="${alumno.DNI}"></c:out>' required>
							<div class="invalid-feedback">
								Por favor ingrese un DNI.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomBirthday">Fecha Nacimiento</label>
							<input type="text" class="form-control is-valid" id="validationCustomBirthday" placeholder="yyyy/mm/dd" maxlength="45" name="fecha_nacimiento" value='<c:out value="${alumno.fechanacimiento}"></c:out>' required>
							<div class="invalid-feedback">
								Por favor ingrese la fecha de nacimiento del estudiante.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomDirection">Dirección</label>
							<input type="text" class="form-control is-valid" id="validationCustomDirection" placeholder="DirecciÃ³n" maxlength="45" name="direccion" value='<c:out value="${alumno.direccion}"></c:out>'>
							<div class="invalid-feedback">
								Por favor ingrese una dirección.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomPhone">Telefono</label>
							<input type="text" class="form-control is-valid" id="validationCustomPhone" placeholder="TelÃ©fono" maxlength="9" name="telefono" value='<c:out value="${alumno.telefono}"></c:out>'>
							<div class="invalid-feedback">
								Por favor ingrese un teléfono.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="exampleFormControlSelect1">Nivel</label>
							<select class="form-control is-valid" id="exampleFormControlSelect1" value='<c:out value="${alumno.nivel}"></c:out>' name="nivel">
								<option value="Pre-grado">Pre-grado</option>
								<option value="Post-grado">Post-grado</option>
							</select>
						</div>
					</div>
					<button class="btn btn-primary" type="submit">Guardar</button>
				</form>
			</div>
		</div>
	</body>
</html>