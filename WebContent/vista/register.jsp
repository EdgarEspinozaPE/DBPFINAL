<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
	<head>
		<title>CSID - Registrar</title>
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
				<h1>Registrar</h1>
			</div>
			<div class="container p-3 my-3 bg-dark text-white">
				<form action="AdminAlumno?action=register" class="needs-validation" onsubmit=" return validateForm()" method="post" novalidate>
					<div class="form-row">
						<div class="col-md-4 mb-3">
							<label for="validationCustomName">Nombres</label>
							<input type="text" class="form-control is-valid" id="validationCustomName" placeholder="Nombres" maxlength="45" required name="nombre">
							<div class="invalid-feedback">
								Por favor ingrese los nombres.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomFathersSurname">Apellido paterno</label>
							<input type="text" class="form-control is-valid" id="validationCustomFathersSurname" placeholder="Apellido paterno" maxlength="45" required name="apellido_paterno">
							<div class="invalid-feedback">
								Por favor ingrese el apellido paterno.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomMothersSurname">Apellido materno</label>
							<input type="text" class="form-control is-valid" id="validationCustomMothersSurname" placeholder="Apellido materno" maxlength="45" required name="apellido_materno">
							<div class="invalid-feedback">
								Por favor ingrese el apellido materno.
							</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-md-4 mb-3">
							<label for="validationCustomUsername">Correo institucional</label>
							<div class="input-group">
								<input type="text" class="form-control is-valid" id="validationCustomUsername" placeholder="Correo" aria-describedby="inputGroupPrepend" name="correo">
								<div class="input-group-prepend">
									<span class="input-group-text" id="inputGroupPrepend">@unsa.edu.pe</span>
								</div>
								<div class="invalid-feedback">
									Por favor ingrese el correo institucional.
								</div>
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomBirthday">Fecha de nacimiento</label>
							<input type="text" class="form-control is-valid" id="validationCustomBirthday" placeholder="yyyy-mm-dd" required name="fecha_nacimiento">
							<div class="invalid-feedback">
								Por favor ingrese la fecha de nacimiento.
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="validationCustomPhone">Teléfono</label>
							<input type="text" class="form-control is-valid" id="validationCustomPhone" placeholder="Telefono" maxlength="9" name="telefono">
							<div class="invalid-feedback">
								Por favor ingrese un número telefénico.
							</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-md-2 mb-3">
							<label for="validationCustomCUI">CUI</label>
							<input type="text" class="form-control is-valid" id="validationCustomCUI" placeholder="CUI" maxlength="8" required name="CUI">
							<div class="invalid-feedback">
								Por favor ingrese el CUI.
							</div>
						</div>
						<div class="col-md-2 mb-3">
							<label for="validationCustomDNI">DNI</label>
							<input type="text" class="form-control is-valid" id="validationCustomDNI" placeholder="DNI" maxlength="8" required name = "DNI">
							<div class="invalid-feedback">
								Por favor ingrese el DNI.
							</div>
						</div>
						<div class="col-md-8 mb-3">
							<label for="validationCustom05">Dirección</label>
							<input type="text" class="form-control is-valid" id="validationCustom05" placeholder="Direccion" name="direccion">
							<div class="invalid-feedback">
								Por favor ingrese una dirección.
							</div>
						</div>
					</div>

					<div class="form-row">
						<div class="col-md-4 mb-3">
							<label for="exampleFormControlSelect1">Nivel</label>
							<select class="form-control is-valid" id="exampleFormControlSelect1" name="nivel">
								<option value="Pre-grado">Pre-grado</option>
								<option value="Post-grado">Post-grado</option>
							</select>
						</div>
					</div>
					<button class="btn btn-primary" type="submit">Registrar</button>
				</form>
			</div>
			
		</div>
	</body>
</html>