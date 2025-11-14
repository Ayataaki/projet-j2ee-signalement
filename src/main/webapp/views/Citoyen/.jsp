<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Espace Citoyen</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            color: #212121;
        }
        .dashboard-title {
            font-weight: 600;
            margin-bottom: 30px;
        }
        .stat-card {
            border: none;
            border-radius: 12px;
            color: white;
            padding: 20px;
            text-align: center;
        }
        .stat-icon {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .stat-title {
            font-size: 1rem;
        }
        .stat-value {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .activity-item {
            background-color: #f1f1f1;
            border-radius: 10px;
            padding: 15px;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
        }
        .map-container {
            background-color: white;
            border-radius: 12px;
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="container py-5">

    <!-- Titre -->
    <h1 class="dashboard-title text-center">Espace Citoyen</h1>

    <!-- Statistiques -->
    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="stat-card" style="background-color: #1976D2;">
                <div class="stat-icon"><i class="fas fa-file-alt"></i></div>
                <div class="stat-title">Total des signalements</div>
                <div class="stat-value">12</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card" style="background-color: #F44336;">
                <div class="stat-icon"><i class="fas fa-exclamation-circle"></i></div>
                <div class="stat-title">En attente</div>
                <div class="stat-value">3</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card" style="background-color: #FF9800;">
                <div class="stat-icon"><i class="fas fa-hourglass-half"></i></div>
                <div class="stat-title">En cours</div>
                <div class="stat-value">5</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card" style="background-color: #43A047;">
                <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                <div class="stat-title">Résolus</div>
                <div class="stat-value">4</div>
            </div>
        </div>
    </div>

    <!-- Carte des signalements -->
    <div class="map-container mb-5">
        <h4 class="mb-3">Signalements à proximité</h4>
        <div class="border rounded" style="height: 400px; background-color: #e9ecef; display: flex; align-items: center; justify-content: center;">
            <span class="text-muted">[ Carte interactive ici — intégration Google Maps ou Leaflet ]</span>
        </div>
    </div>

    <!-- Activités récentes -->
    <div class="map-container">
        <h4 class="mb-4">Activités récentes</h4>

        <div class="activity-item mb-3">
            <div class="dot" style="background-color: #43A047;"></div>
            <div>
                <p class="mb-1">Le signalement #1234 a été résolu</p>
                <small class="text-muted">Il y a 2 heures</small>
            </div>
        </div>

        <div class="activity-item mb-3">
            <div class="dot" style="background-color: #FF9800;"></div>
            <div>
                <p class="mb-1">Le signalement #1235 est en cours de traitement</p>
                <small class="text-muted">Il y a 5 heures</small>
            </div>
        </div>

        <div class="activity-item">
            <div class="dot" style="background-color: #1976D2;"></div>
            <div>
                <p class="mb-1">Nouveau signalement #1236 soumis</p>
                <small class="text-muted">Il y a 1 jour</small>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
