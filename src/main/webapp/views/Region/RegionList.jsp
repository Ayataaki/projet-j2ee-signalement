<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Régions - UrbAlert</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .container { margin-top: 50px; }
        .table thead { background-color: #1976D2; color: white; }
        .btn-add {
            background-color: #43A047;
            color: white;
            font-weight: 600;
        }
        .btn-add:hover { background-color: #388E3C; }
    </style>
</head>
<body>

<div class="container">
    <h2 class="mb-4">Liste des Régions</h2>


<!-- 		<form class="form-inline border-bottom border-dange" -->
<!-- 			action="GerantDash" method="Post"> -->
<!-- 			<input type="hidden" name="btn" value="Equipes"> -->
<!-- 			<button -->
<!-- 				class="btn btn-outline-light btn-lg btn-block mb-4 mt-5 ml-2 mr-2" -->
<!-- 				type="submit"> -->
<!-- 				<i class="fas fa-tshirt"></i> Equipes -->
<!-- 			</button> -->
<!-- 		</form> -->

<!-- 		<div class="mb-3 text-end"> -->
<!-- 			<a -->
<%-- 				href="${pageContext.request.contextPath}/RegionServlet?action=afficherFormAjout" --%>
<!-- 				class="btn btn-add"> <i class="fas fa-plus-circle"></i> Ajouter -->
<!-- 				une région -->
<!-- 			</a> -->
<!-- 		</div> -->

		<form action="${pageContext.request.contextPath}/RegionServlet"
			method="get" class="text-end">
			<input type="hidden" name="action" value="ajoutRegion">
			<button type="submit" class="btn btn-add">
				<i class="fas fa-plus-circle"></i> Ajouter une région
			</button>
		</form>

		
		<c:if test="${empty regions}">
        <div class="alert alert-info">Aucune région enregistrée pour le moment.</div>
    </c:if>

    <c:if test="${not empty regions}">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Nom</th>
                    <th>Superficie (km²)</th>
                    <th>Population</th>
                    <th>Capitale régionale</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="region" items="${regions}">
                    <tr>
                        <td>${region.idRegion}</td>
                        <td>${region.nom}</td>
                        <td>${region.superficie}</td>
                        <td>${region.population}</td>
                        <td>${region.capitaleRegionale}</td>
                        <td>
                            <a href="RegionServlet?action=modifRegion&id=${region.idRegion}" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i> Modifier
                            </a>
                            <a href="RegionServlet?action=suppReg&id=${region.idRegion}" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Voulez-vous vraiment supprimer cette région ?');">
                                <i class="fas fa-trash-alt"></i> Supprimer
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
