<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Municipal - UrbAlert</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #1976D2;
            --primary-hover: #1565C0;
            --secondary-color: #43A047;
            --text-dark: #212121;
            --text-gray: #666;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
            background-color: #f8f9fa;
            color: var(--text-dark);
        }

        .header {
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 1rem 0;
            margin-bottom: 2rem;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--primary-color);
            font-weight: 600;
            font-size: 1.125rem;
            text-decoration: none;
        }

        .logo i {
            font-size: 1.75rem;
        }

        .form-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .form-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 2.5rem;
            transition: box-shadow 0.3s ease;
        }

        .form-card:hover {
            box-shadow: 0 4px 16px rgba(0,0,0,0.15);
        }

        .form-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        .form-subtitle {
            color: var(--text-gray);
            margin-bottom: 2rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 0.75rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(25, 118, 210, 0.1);
        }

        .required {
            color: #dc3545;
            margin-left: 0.25rem;
        }

        .btn-submit {
            background-color: var(--secondary-color);
            color: white;
            padding: 0.875rem 2rem;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .btn-submit:hover {
            background-color: #388E3C;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }

        .btn-cancel {
            background-color: white;
            color: var(--text-gray);
            padding: 0.875rem 2rem;
            border: 2px solid #e0e0e0;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .btn-cancel:hover {
            border-color: var(--text-gray);
            color: var(--text-dark);
        }

        .alert {
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }

        .input-icon {
            position: relative;
        }

        .input-icon i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-gray);
            z-index: 10;
        }

        .input-icon .form-control,
        .input-icon .form-select {
            padding-left: 40px;
        }

        .form-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23666' d='M10.293 3.293L6 7.586 1.707 3.293A1 1 0 00.293 4.707l5 5a1 1 0 001.414 0l5-5a1 1 0 10-1.414-1.414z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            padding-right: 40px;
        }

        @media (max-width: 768px) {
            .form-card {
                padding: 1.5rem;
            }

            .form-title {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header class="header">
        <div class="container">
            <a href="Accueil.jsp" class="logo">
                <i class="fas fa-building"></i>
                <span>UrbAlert</span>
            </a>
        </div>
    </header>
    
    <!-- Form Container -->
    <div class="form-container">
        <div class="form-card">
            <h1 class="form-title">Ajouter un Municipal</h1>
            <p class="form-subtitle">Enregistrez les informations d'un nouveau municipal</p>

            <!-- Messages de succès/erreur -->
            <c:if test="${not empty messageSucces}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${messageSucces}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty messageErreur}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${messageErreur}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>


			<form action="${pageContext.request.contextPath}/MunicipalServlet"
				method="post" id="municipalForm">
				<!-- Nom du municipal -->
				<div class="mb-4">
					<label for="nom" class="form-label"> Nom du municipal<span
						class="required">*</span>
					</label>
					<div class="input-icon">
						<i class="fas fa-landmark"></i> <input type="text"
							class="form-control" id="nom" name="nom"
							placeholder="Ex: Casablanca" value="${param.nom}" required>
					</div>
				</div>

				<!-- Type de municipal -->
				<div class="mb-4">
					<label for="typeMunicipal" class="form-label"> Type de
						municipal<span class="required">*</span>
					</label>
					<div class="input-icon">
						<i class="fas fa-tags"></i> <select class="form-select"
							id="typeMunicipal" name="typeMunicipal" required>
							<option value="" disabled selected>Sélectionnez un type</option>
							<option value="Commune Urbaine"
								${param.typeMunicipal == 'Commune Urbaine' ? 'selected' : ''}>Commune
								Urbaine</option>
							<option value="Commune Rurale"
								${param.typeMunicipal == 'Commune Rurale' ? 'selected' : ''}>Commune
								Rurale</option>
							<option value="Arrondissement"
								${param.typeMunicipal == 'Arrondissement' ? 'selected' : ''}>Arrondissement</option>
							<option value="Municipalité"
								${param.typeMunicipal == 'Municipalité' ? 'selected' : ''}>Municipalité</option>
						</select>
					</div>
					<small class="text-muted">Type administratif du municipal</small>
				</div>

				<!-- Région -->
				<div class="mb-4">
					<label for="idRegion" class="form-label"> Région<span
						class="required">*</span>
					</label>
					<div class="input-icon">
						<i class="fas fa-map-marked-alt"></i> <select class="form-select"
							id="idRegion" name="idRegion" required>
							<option value="" disabled selected>Sélectionnez une
								région</option>

							<c:forEach var="region" items="${regions}">
								<option value="${region.idRegion}"
									${param.idRegion == region.idRegion.toString() ? 'selected' : ''}>
									${region.nom}</option>
							</c:forEach>

						</select>
					</div>

					<small class="text-muted">Région d'appartenance du
						municipal</small>
				</div>

				<!-- Buttons -->
				<div class="d-flex gap-3 justify-content-end mt-4">
					<button type="button" class="btn btn-cancel"
						onclick="window.history.back()">
						<i class="fas fa-times me-2"></i>Annuler
					</button>
					<button type="submit" class="btn btn-submit">
						<i class="fas fa-save me-2"></i>Enregistrer le municipal
					</button>
				</div>
			</form>
		</div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>