<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signaler un problème - UrbAlert</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Leaflet CSS pour OpenStreetMap -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
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

        /* Header */
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

        /* Form Container */
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

        /* Form Styles */
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

        /* Image Upload */
        .image-upload-area {
            border: 2px dashed #e0e0e0;
            border-radius: 12px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            background-color: #fafafa;
        }

        .image-upload-area:hover {
            border-color: var(--primary-color);
            background-color: rgba(25, 118, 210, 0.02);
        }

        .image-upload-area.drag-over {
            border-color: var(--primary-color);
            background-color: rgba(25, 118, 210, 0.05);
        }

        .upload-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .image-preview {
            max-width: 100%;
            max-height: 300px;
            border-radius: 8px;
            margin-top: 1rem;
        }

        /* Location Input with Icon */
        .input-with-icon {
            position: relative;
        }

        .input-with-icon i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-gray);
        }

        .input-with-icon .form-control {
            padding-left: 40px;
        }

        /* Map Styles */
        #map {
            height: 400px;
            border-radius: 8px;
            margin-top: 1rem;
            border: 2px solid #e0e0e0;
            z-index: 1;
        }

        .leaflet-container {
            border-radius: 8px;
        }

        /* Buttons */
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

        /* Character Counter */
        .char-counter {
            font-size: 0.875rem;
            color: var(--text-gray);
            text-align: right;
            margin-top: 0.25rem;
        }

        /* Loading indicator */
        .loading-text {
            color: var(--primary-color);
            font-size: 0.875rem;
        }

        @media (max-width: 768px) {
            .form-card {
                padding: 1.5rem;
            }

            .form-title {
                font-size: 1.5rem;
            }

            #map {
                height: 300px;
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
                <span>UrbAlert – Signalez, Suivez, Améliorez Votre Ville</span>
            </a>
        </div>
    </header>

    <!-- Form Container -->
    <div class="form-container">
        <div class="form-card">
            <h1 class="form-title">Signaler un problème</h1>
            <p class="form-subtitle">Aidez-nous à améliorer votre ville en signalant les problèmes que vous rencontrez</p>

            <form action="SignalerProblemeServlet" method="post" enctype="multipart/form-data" id="reportForm">
                
                <!-- Description -->
                <div class="mb-4">
                    <label for="description" class="form-label">
                        Description du problème <span class="text-danger">*</span>
                    </label>
                    <textarea 
                        class="form-control" 
                        id="description" 
                        name="description" 
                        rows="4" 
                        placeholder="Décrivez le problème en détail..."
                        maxlength="500"
                        required></textarea>
                    <div class="char-counter">
                        <span id="charCount">0</span>/500 caractères
                    </div>
                </div>

                <!-- Localisation -->
                <div class="mb-4">
                    <label for="localisation" class="form-label">
                        Localisation <span class="text-danger">*</span>
                    </label>
                    <div class="input-with-icon">
                        <i class="fas fa-map-marker-alt"></i>
                        <input 
                            type="text" 
                            class="form-control" 
                            id="localisation" 
                            name="localisation" 
                            placeholder="Cliquez sur la carte pour sélectionner l'emplacement"
                            readonly
                            required>
                        <input type="hidden" id="latitude" name="latitude">
                        <input type="hidden" id="longitude" name="longitude">
                    </div>
                    
                    <!-- Carte OpenStreetMap -->
                    <div id="map"></div>
                    
                    <small class="text-muted d-block mt-2">
                        <i class="fas fa-info-circle"></i> Cliquez sur la carte pour sélectionner l'emplacement exact du problème
                    </small>
                    <small class="loading-text d-none" id="loadingText">
                        <i class="fas fa-spinner fa-spin"></i> Chargement de l'adresse...
                    </small>
                </div>

                <!-- Image Upload -->
                <div class="mb-4">
                    <label class="form-label">
                        Photo du problème <span class="text-danger">*</span>
                    </label>
                    <div class="image-upload-area" id="uploadArea">
                        <i class="fas fa-cloud-upload-alt upload-icon"></i>
                        <p class="mb-2"><strong>Cliquez pour télécharger</strong> ou glissez-déposez une image</p>
                        <p class="text-muted small">PNG, JPG jusqu'à 5MB</p>
                        <input 
                            type="file" 
                            class="d-none" 
                            id="imageInput" 
                            name="image" 
                            accept="image/*"
                            required>
                    </div>
                    <img id="imagePreview" class="image-preview d-none" alt="Aperçu">
                </div>

                <!-- Commentaire additionnel -->
                <div class="mb-4">
                    <label for="commentaire" class="form-label">Commentaire additionnel</label>
                    <textarea 
                        class="form-control" 
                        id="commentaire" 
                        name="commentaire" 
                        rows="3" 
                        placeholder="Ajoutez des informations supplémentaires (optionnel)..."></textarea>
                </div>

                <!-- Buttons -->
                <div class="d-flex gap-3 justify-content-end">
                    <button type="button" class="btn btn-cancel" onclick="window.history.back()">
                        Annuler
                    </button>
                    <button type="submit" class="btn btn-submit">
                        <i class="fas fa-paper-plane me-2"></i>Soumettre le signalement
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Leaflet JS pour OpenStreetMap -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    
    <script>
        let map;
        let marker;

        // ========================================
        // 1. INITIALISATION DE LA CARTE
        // ========================================
        document.addEventListener('DOMContentLoaded', function() {
            try {
                // Créer la carte centrée sur Rabat
                map = L.map('map', {
                    center: [34.020882, -6.841650],
                    zoom: 13,
                    zoomControl: true
                });

                // Ajouter les tuiles OpenStreetMap (GRATUIT)
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
                    maxZoom: 19,
                    minZoom: 3
                }).addTo(map);

                // Message d'information au centre de la carte
                const centerMessage = L.popup()
                    .setLatLng([34.020882, -6.841650])
                    .setContent('<strong>Cliquez sur la carte</strong><br>pour sélectionner l\'emplacement')
                    .openOn(map);

                // Écouter les clics sur la carte
                map.on('click', onMapClick);

                console.log("✅ Carte OpenStreetMap chargée avec succès!");
            } catch (error) {
                console.error("❌ Erreur lors de l'initialisation de la carte:", error);
                document.getElementById("map").innerHTML = 
                    '<div style="display:flex;align-items:center;justify-content:center;height:100%;color:#dc3545;">' +
                    '<i class="fas fa-exclamation-triangle me-2"></i>Erreur de chargement de la carte</div>';
            }
        });

        // ========================================
        // 2. GESTION DU CLIC SUR LA CARTE
        // ========================================
        function onMapClick(e) {
            const lat = e.latlng.lat;
            const lng = e.latlng.lng;

            // Ajouter ou déplacer le marqueur
            if (marker) {
                marker.setLatLng(e.latlng);
            } else {
                marker = L.marker(e.latlng, {
                    draggable: true,
                    title: "Position du problème"
                }).addTo(map);

                // Permettre de déplacer le marqueur
                marker.on('dragend', function(event) {
                    const position = event.target.getLatLng();
                    reverseGeocode(position.lat, position.lng);
                });
            }

            // Centrer la carte sur le marqueur
            map.setView(e.latlng, map.getZoom());

            // Remplir les champs latitude et longitude
            document.getElementById("latitude").value = lat.toFixed(6);
            document.getElementById("longitude").value = lng.toFixed(6);

            // Faire du reverse geocoding (obtenir l'adresse)
            reverseGeocode(lat, lng);
        }

     // ========================================
     // 3. REVERSE GEOCODING (Coordonnées → Adresse)
     // ========================================
    function reverseGeocode(lat, lng) {
    const localisationInput = document.getElementById('localisation');
    const loadingText = document.getElementById('loadingText');
    
    // Masquer le loading immédiatement
    loadingText.classList.add('d-none');
    
    // Afficher directement les coordonnées
    const coordinatesText = `Lat: ${lat.toFixed(6)}, Lng: ${lng.toFixed(6)}`;
    localisationInput.value = coordinatesText;
    
    // Mettre à jour le popup du marqueur
    if (marker) {
        marker.bindPopup(`<strong>Emplacement sélectionné</strong><br>${coordinatesText}`).openPopup();
    }
}
        // ========================================
        // 6. VALIDATION DU FORMULAIRE
        // ========================================
        document.getElementById('reportForm').addEventListener('submit', function(e) {
            const lat = document.getElementById('latitude').value;
            const lng = document.getElementById('longitude').value;
            
            if (!lat || !lng) {
                e.preventDefault();
                alert('⚠️ Veuillez sélectionner un emplacement sur la carte');
                return false;
            }
        });
    </script>

</body>
</html>