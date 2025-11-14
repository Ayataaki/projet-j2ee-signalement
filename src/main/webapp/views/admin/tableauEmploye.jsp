<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Citoyens</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        :root {
            --primary-color: #1976D2;
            --primary-hover: #1565C0;
        }
        
        body {
            background-color: #f8f9fa;
            padding: 2rem;
        }
        
        .table-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 1.5rem;
        }
        
        .table thead {
            background-color: #f8f9fa;
        }
        
        .table thead th {
            border-bottom: 2px solid var(--primary-color);
            color: #495057;
            font-weight: 600;
            padding: 1rem;
        }
        
        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
        }
        
        .btn-action {
            padding: 0.375rem 0.75rem;
            margin: 0 0.25rem;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="table-card">
            <h4 class="mb-4">
                <i class="bi bi-people me-2 text-primary"></i>
                Liste des Citoyens
            </h4>
            
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Nom Utilisateur</th>
                            <th>CIN</th>
                            <th>Lieu Naissance</th>
                            <th>Téléphone</th>
                            <th>Email</th>
                            <th>Email Auth</th>
                            <th>Date Naissance</th>
                            <th>ID Région</th>
                            <th>Date Création</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>                        
                        <tr>
                            <td>5</td>
                            <td>Tazi</td>
                            <td>Omar</td>
                            <td>o.tazi</td>
                            <td>IJ901234</td>
                            <td>Tanger</td>
                            <td>0622334455</td>
                            <td>omar@email.com</td>
                            <td>omar.auth@email.com</td>
                            <td>1987-09-25</td>
                            <td>5</td>
                            <td>2024-05-05 16:00:00</td>
                            <td>
                                <button class="btn btn-sm btn-outline-primary btn-action" title="Modifier">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger btn-action" title="Supprimer" onclick="confirmDelete(5)">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function confirmDelete(id) {
            if (confirm('Êtes-vous sûr de vouloir supprimer ce citoyen ?')) {
                alert('Citoyen ID ' + id + ' supprimé.');
                // Ajoutez ici votre logique de suppression
            }
        }
    </script>
</body>
</html>