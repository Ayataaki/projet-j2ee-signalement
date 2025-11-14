<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Technicien - UrbAlert</title>
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
            font-family: 'Segoe UI', Roboto, sans-serif;
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

        .logo i { font-size: 1.75rem; }

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
        }

        .form-title { font-size: 2rem; font-weight: 700; margin-bottom: 0.5rem; }
        .form-subtitle { color: var(--text-gray); margin-bottom: 2rem; }

        .form-label { font-weight: 600; color: var(--text-dark); }
        .form-control, .form-select {
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 0.75rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(25, 118, 210, 0.1);
        }

        .required { color: #dc3545; }

        .btn-submit {
            background-color: var(--secondary-color);
            color: white;
            padding: 0.875rem 2rem;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-submit:hover { background-color: #388E3C; transform: translateY(-2px); }

        .btn-cancel {
            background-color: white;
            color: var(--text-gray);
            padding: 0.875rem 2rem;
            border: 2px solid #e0e0e0;
            border-radius: 50px;
            font-weight: 600;
        }

        .btn-cancel:hover { border-color: var(--text-gray); color: var(--text-dark); }
    </style>
</head>
<body>

<header class="header">
    <div class="container">
        <a href="Accueil.jsp" class="logo">
            <i class="fas fa-tools"></i>
            <span>UrbAlert</span>
        </a>
    </div>
</header>

<div class="form-container">
    <div class="form-card">
        <h1 class="form-title">Ajouter un Technicien</h1>
        <p class="form-subtitle">Enregistrez les informations d’un nouveau technicien</p>

        <c:if test="${not empty messageSucces}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle me-2"></i>${messageSucces}
            </div>
        </c:if>

        <c:if test="${not empty messageErreur}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle me-2"></i>${messageErreur}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/TechnicienServlet" method="post">
            
            <!-- Nom -->
            <div class="mb-4">
                <label class="form-label">Nom<span class="required">*</span></label>
                <input type="text" name="nom" class="form-control" placeholder="Ex: El Amrani" required>
            </div>

            <!-- Prénom -->
            <div class="mb-4">
                <label class="form-label">Prénom<span class="required">*</span></label>
                <input type="text" name="prenom" class="form-control" placeholder="Ex: Youssef" required>
            </div>

            <!-- CIN -->
            <div class="mb-4">
                <label class="form-label">CIN<span class="required">*</span></label>
                <input type="text" name="cin" class="form-control" placeholder="Ex: AB123456" required>
            </div>

            <!-- Lieu de naissance -->
            <div class="mb-4">
                <label class="form-label">Lieu de naissance<span class="required">*</span></label>
                <input type="text" name="lieuNaissance" class="form-control" placeholder="Ex: Casablanca" required>
            </div>

            <!-- Téléphone -->
            <div class="mb-4">
                <label class="form-label">Téléphone<span class="required">*</span></label>
                <input type="text" name="telephone" maxlength="10" class="form-control" placeholder="Ex: 0612345678" required>
            </div>

            <!-- Email -->
            <div class="mb-4">
                <label class="form-label">Email<span class="required">*</span></label>
                <input type="email" name="email" class="form-control" placeholder="Ex: tech@urbalert.ma" required>
            </div>

            <!-- Date de naissance -->
            <div class="mb-4">
                <label class="form-label">Date de naissance<span class="required">*</span></label>
                <input type="date" name="dateNaissance" class="form-control" required>
            </div>

            <!-- Spécialité -->
            <div class="mb-4">
                <label class="form-label">Spécialité<span class="required">*</span></label>
                <input type="text" name="specialite" class="form-control" placeholder="Ex: Électricité, Réseau, Plomberie..." required>
            </div>

            <!-- Compétence -->
            <div class="mb-4">
                <label class="form-label">Compétence<span class="required">*</span></label>
                <input type="text" name="competence" class="form-control" placeholder="Ex: Maintenance, Installation, Réparation..." required>
            </div>

            <!-- Disponibilité -->
            <div class="mb-4">
                <label class="form-label">Disponibilité</label>
                <select name="disponibilite" class="form-select">
                    <option value="true" selected>Disponible</option>
                    <option value="false">Non disponible</option>
                </select>
            </div>

<!--             Mot de passe -->
<!--             <div class="mb-4"> -->
<!--                 <label class="form-label">Mot de passe<span class="required">*</span></label> -->
<!--                 <input type="password" name="motDePasse" class="form-control" placeholder="********" required> -->
<!--             </div> -->

            <!-- Boutons -->
            <div class="d-flex gap-3 justify-content-end mt-4">
                <button type="button" class="btn btn-cancel" onclick="window.history.back()">
                    <i class="fas fa-times me-2"></i>Annuler
                </button>
                <button type="submit" class="btn btn-submit">
                    <i class="fas fa-save me-2"></i>Enregistrer le technicien
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
