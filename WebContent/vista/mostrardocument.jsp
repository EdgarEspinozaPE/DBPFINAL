<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>CSID - Documentos</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
	</head>
<body>
	<div class="container pt-5">
		<div class="text-center">
			<h1>Documentos del Estudiante</h1>
		</div>
		<div class="text pt-5">
			<h2>Lista de Documentos</h2>
		</div>
		<div class="row">
			<div class="col-md-4 mb-4 pt-4">
          			<form class="form-inline md-form mr-auto" action ="AdminDocumento?action=mostrarporNroserie&CUI=${CUI}" method="post">
            			<input class="form-control" type="text" placeholder="Buscar" aria-label="Search" name="nroserie">
            			<button class="btn btn-primary" type="submit">Buscar</button>
            			<select class="form-control" id="exampleFormControlSelect1" name="categoria" >
							<option value="Todos">Todos</option>
							<c:forEach var="categorias" items="${listacategorias}">
								<option value="${categorias}">${categorias}</option>
							</c:forEach>
						</select>
          			</form>
        		</div>
        	<div class="col-md-3 mb-4 pt-3">
				<a class="btn btn-primary btn-lg btn-block" href="AdminDocumento?action=nuevo&CUI=${CUI}" role="button">Añadir documento</a>
			</div>
			<div class="col-md-2 mb-4 pt-3">
				<a class="btn btn-primary btn-lg btn-block" href="AdminAlumno?action=mostrarporCUI&CUI=<c:out value="${CUI}" />" role="button">Volver</a>
			</div>
		</div>
		<div class="container">
			<table class="table table-striped table-dark">
				<thead>
					<tr>
						<th scope="col">Categoría</th> 
						<th scope="col">Fecha</th>
						<th scope="col">N° de serie</th>
						<th scope="col">Dirección</th>
						<th scope="col" colspan="2">Acciones</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="documento" items="${lista}">
						<tr>
							<th scope="row"><c:out value="${documento.categoria}"/></th>
							<td><c:out value="${documento.fechadoc}"/></td>
							<td><c:out value="${documento.nroserie}"/></td>
							<td> <a href="${documento.direcciondoc}"/>${documento.direcciondoc}</a></td>
							<td><a href="AdminDocumento?action=showedit&nroserie=<c:out value="${documento.nroserie}"/>">Editar</a></td>
							<td><a href="AdminDocumento?action=eliminar&nroserie=<c:out value="${documento.nroserie}"/> &CUI=<c:out value="${CUI}" />">Eliminar</a></td>
						</tr>
					</c:forEach>
				</tbody>
  			</table>
		</div>
	</div>
</body>
</html>