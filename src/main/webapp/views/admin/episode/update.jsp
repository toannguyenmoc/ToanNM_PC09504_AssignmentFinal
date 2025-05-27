<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
    
<div class="container">
    <div class="page-inner">
    	<div class="card p-4 w-100 d-flex flex-column overflow-hidden">
    	<div class="">
			<h2 class="text-uppercase fw-bold mb-3">Thêm Tập Phim</h2>
		</div>

		<form action="${pageContext.request.contextPath}/admin/episode/update" method="post" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label for="animeId" class="form-label">Chọn Anime</label>
                    <select name="animeId" id="animeId" class="form-select" required>
                        <option value="" disabled selected>-- Chọn anime --</option>
                        <c:forEach var="anime" items="${animes}">
                            <option value="${anime.id}" ${anime.id == episode.anime.id ? 'selected' : ''}>${anime.title}</option>
                        </c:forEach>
                    </select>
                    <small class="invalid-feedback">Vui lòng chọn phim</small>
                </div>

                <div class="mb-3">
                    <label for="episodeNumber" class="form-label">Tập số</label>
                    <input type="number" min="1" class="form-control" id="episodeNumber" name="episodeNumber" value="${episode != null ? episode.episodeNumber : ''}" required>
                    <small class="invalid-feedback">Vui lòng nhập tập phim</small>
                    <small class="text-danger">${epMessage}</small>
                </div>

                <div class="mb-3">
                    <label for="videoUrl" class="form-label">Link Video</label>
                    <input type="text" class="form-control" id="videoUrl" name="videoUrl" value="${episode != null ? episode.videoUrl : ''}" placeholder="https://player.vimeo.com/video/..." required>
                    <small class="invalid-feedback">Vui lòng nhập link phim</small>
                </div>

                <div class="d-flex gap-3">
                	<input type="hidden" id="episodeId" name="episodeId" value="${episode.id}">
                    <button type="submit" class="btn btn-success">Cập nhật Phim</button>
                   	<a href="${pageContext.request.contextPath}/admin/episode/list" class="btn btn-primary" type="button">Quay lại</a>
                </div>
            </form>

		</div>
	</div>
</div>