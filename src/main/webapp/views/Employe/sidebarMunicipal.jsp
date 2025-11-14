<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String activePage = request.getParameter("activePage");
    if (activePage == null) activePage = "dashboard";
%>

<div class="sidebar">
    <div class="logo">
        <h4 class="mb-0 text-primary">
            <i class="fas fa-city me-2"></i>
            Espace Municipal
        </h4>
        <small class="text-muted">Gestion des signalements</small>
    </div>
    
    <nav class="nav flex-column">
        <a href="DashboardMunicipalServlet" class="nav-link <%= activePage.equals("dashboard") ? "active" : "" %>">
            <i class="fas fa-chart-line"></i>
            Tableau de bord
        </a>
        <a href="GererSignalementsServlet" class="nav-link <%= activePage.equals("signalements") ? "active" : "" %>">
            <i class="fas fa-clipboard-list"></i>
            Gérer Signalements
        </a>
        <a href="GererTechniciensServlet" class="nav-link <%= activePage.equals("techniciens") ? "active" : "" %>">
            <i class="fas fa-users-cog"></i>
            Signaler un problème
        </a>
        <a href="ProfilMunicipalServlet" class="nav-link <%= activePage.equals("profil") ? "active" : "" %>">
            <i class="fas fa-user-circle"></i>
            Mon Profil
        </a>
    </nav>

    <div class="mt-auto p-3">
        <div class="user-info">
            <div class="d-flex align-items-center mb-2">
                <div class="avatar-sm me-2">
                    <i class="fas fa-user-shield"></i>
                </div>
                <div>
                    <small class="d-block fw-semibold">${sessionScope.userNom}</small>
                    <small class="text-muted">Agent Municipal</small>
                </div>
            </div>
            <a href="LogoutServlet" class="btn btn-outline-danger btn-sm w-100">
                <i class="fas fa-sign-out-alt me-1"></i>
                Déconnexion
            </a>
        </div>
    </div>
</div>

<style>
    .avatar-sm {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1rem;
    }
</style>