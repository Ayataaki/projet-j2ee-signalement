<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier une Région - UrbAlert</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
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
            background-color: var(--primary-color);
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
            background-color: var(--primary-hover);
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
        }

        .input-icon .form-control {
            padding-left: 40px;
        }
    </style>
</head>
<body>

<header class="header">
    <div class="container">
        <a href="Accueil.jsp" class="logo">
            <i class="fas fa-building"></i>
            <span>UrbAlert</span>
        </a>
    </div>
</header>

<div class="form-container">
    <div class="form-card">
        <h1 class="form-title">Modifier une Région</h1>
        <p class="form-subtitle">Mettez à jour les informations de la région sélectionnée</p>

        <!-- Messages -->
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

        <form action="${pageContext.request.contextPath}/RegionServlet" method="post">
            <input type="hidden" name="action" value="modifRegion">
            <input type="hidden" name="idRegion" value="${region.idRegion}">

            <!-- Nom -->
            <div class="mb-4">
                <label for="nom" class="form-label">Nom de la région<span class="required">*</span></label>
                <div class="input-icon">
                    <i class="fas fa-map-marked-alt"></i>
                    <input type="text" class="form-control" id="nom" name="nom" 
                           value="${region.nom}" required>
                </div>
            </div>

            <!-- Superficie -->
            <div class="mb-4">
                <label for="superficie" class="form-label">Superficie (km²)<span class="required">*</span></label>
                <div class="input-icon">
                    <i class="fas fa-ruler-combined"></i>
                    <input type="number" class="form-control" id="superficie" name="superficie"
                           value="${region.superficie}" step="0.01" min="0" required>
                </div>
            </div>

            <!-- Population -->
            <div class="mb-4">
                <label for="population" class="form-label">Population<span class="required">*</span></label>
                <div class="input-icon">
                    <i class="fas fa-users"></i>
                    <input type="number" class="form-control" id="population" name="population"
                           value="${region.population}" min="0" required>
                </div>
            </div>

            <!-- Capitale Régionale -->
            <div class="mb-4">
                <label for="capitalRegional" class="form-label">Capitale Régionale<span class="required">*</span></label>
                <div class="input-icon">
                    <i class="fas fa-city"></i>
                    <input type="text" class="form-control" id="capitalRegional" name="capitalRegional"
                           value="${region.capitalRegional}" required>
                </div>
            </div>

            <!-- Boutons -->
            <div class="d-flex gap-3 justify-content-end mt-4">
                <button type="button" class="btn btn-cancel" onclick="window.history.back()">
                    <i class="fas fa-times me-2"></i>Annuler
                </button>
                <button type="submit" class="btn btn-submit">
                    <i class="fas fa-save me-2"></i>Mettre à jour
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
