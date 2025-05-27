<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="assetPath" value="${pageContext.request.contextPath}/assets/admin" />
<c:set var="uri" value="${pageContext.request.requestURI}" />

    <!-- Sidebar -->
    <div class="sidebar" data-background-color="dark">
      <div class="sidebar-logo">
        <!-- Logo Header -->
        <div class="logo-header" data-background-color="dark">
          <a href="${pageContext.request.contextPath}/home" class="logo">
            <img src="${assetPath}/img/kaiadmin/logo_light.svg" alt="navbar brand" class="navbar-brand" height="20" />
          </a>
          <div class="nav-toggle">
            <button class="btn btn-toggle toggle-sidebar">
              <i class="gg-menu-right"></i>
            </button>
            <button class="btn btn-toggle sidenav-toggler">
              <i class="gg-menu-left"></i>
            </button>
          </div>
          <button class="topbar-toggler more">
            <i class="gg-more-vertical-alt"></i>
          </button>
        </div>
        <!-- End Logo Header -->
      </div>
      <div class="sidebar-wrapper scrollbar scrollbar-inner">
        <div class="sidebar-content">
          <ul class="nav nav-secondary">
          
            <li class="nav-item ${uri.contains('/admin/dashboard') ? 'active' : ''}">
              <a href="${pageContext.request.contextPath}/admin/dashboard" class="collapsed" aria-expanded="false">
                <i class="fas fa-home"></i>
                <p>Dashboard</p>
              </a>
            </li>
            
            <li class="nav-section">
              <span class="sidebar-mini-icon">
                <i class="fa fa-ellipsis-h"></i>
              </span>
              <h4 class="text-section">Danh mục</h4>
            </li>
            
            <c:set var="animeActive" value="${fn:contains(uri, '/admin/anime') ? 'active' : ''}" />
            <li class="nav-item ${animeActive}">
              <a href="${pageContext.request.contextPath}/admin/anime/list">
                <i class="fas fa-video"></i>
                <p>Quản Lý Phim</p>
              </a>
            </li>
            
            <c:set var="episodeActive" value="${fn:contains(uri, '/admin/episode') ? 'active' : ''}" />
            <li class="nav-item ${episodeActive}">
              <a href="${pageContext.request.contextPath}/admin/episode/list">
                <i class="fas fa-server"></i>
                <p>Quản Lý Tập Phim</p>
              </a>
            </li>
            
            <c:set var="userActive" value="${fn:contains(uri, '/admin/user') ? 'active' : ''}" />
            <li class="nav-item ${userActive}">
              <a href="${pageContext.request.contextPath}/admin/user/list">
                <i class="fas fa-user"></i>
                <p>Quản Lý Tài Khoản</p>
              </a>
            </li>
            
            <li class="nav-item">
              <a data-bs-toggle="collapse" href="#statistical">
                <i class="fas fa-database"></i>
                <p>Thống kê</p>
                <span class="caret"></span>
              </a>
              <div class="collapse" id="statistical">
                <ul class="nav nav-collapse">
                  <li>
                    <a href="${pageContext.request.contextPath}/admin/statistical/top-active-users">
                      <span class="sub-item">Thống kê tương tác</span>
                    </a>
                  </li>
                  <li>
                    <a href="${pageContext.request.contextPath}/admin/statistical/anime-statistics">
                      <span class="sub-item">Thống kê Anime</span>
                    </a>
                  </li>
                </ul>
              </div>
            </li>
            
           
          </ul>
        </div>
      </div>
    </div>
    <!-- End Sidebar -->