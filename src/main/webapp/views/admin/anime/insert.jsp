<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<div class="container">
    <div class="page-inner">
    	<div class="card p-4 w-100 d-flex flex-column overflow-hidden">
    	<div class="">
			<h2 class="text-uppercase fw-bold mb-3">Thêm Phim Mới</h2>
		</div>

		<form class="row g-3 needs-validation" method="post" 
				enctype="multipart/form-data" 
				action="${pageContext.request.contextPath}/admin/anime/insert"
				novalidate>
			<div class="col-md-6">
				<div class="row g-3">
					<div class="col-md-12">
						<label for="title" class="form-label">Tên phim</label> 
						<input type="text" class="form-control" id="title" name="title" placeholder="Tên phim" value="${anime != null ? anime.title : ''}" required> 
						<small class="invalid-feedback">Vui lòng nhập tên phim</small>
					</div>
					<div class="col-md-6">
						<label for="slug" class="form-label">Đường dẫn</label> 
						<input type="text" class="form-control" id="slug" name="slug" placeholder="ten-phim" value="${anime != null ? anime.slug : ''}" required> 
						<small class="invalid-feedback">Vui lòng nhập đường dẫn</small>
						<small class="text-danger">${errorSlug}</small>
					</div>
					<div class="col-md-6">
						<label for="author" class="form-label">Tác giả</label> 
						<input type="text" class="form-control" id="author" name="author" placeholder="Tác giả" value="${anime != null ? anime.author : ''}" required> 
						<small class="invalid-feedback">Vui lòng nhập tác giả</small>
					</div>
	
					<div class="col-md-6">
						<label for="totalEpisodes" class="form-label">Số Tập</label> 
						<input type="number" min="1" class="form-control" id="totalEpisodes" name="totalEpisodes" placeholder="" value="${anime != null ? anime.totalEpisodes : ''}" required> 
						<small class="invalid-feedback">Vui lòng nhập số tập và lớn hơn 0</small>
					</div>
					<div class="col-md-6">
						<label for="genre" class="form-label">Thể Loại</label> 
						<input type="text" class="form-control" id="genre" name="genre" placeholder="Thể loại" value="${anime != null ? anime.genre : ''}" required>
						<small class="invalid-feedback">Vui lòng nhập thể loại</small>
					</div>
					
					<div class="col-md-12">
							<div class="form-check-inline">
                                <label class="form-check-label">Trạng thái: </label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="active"
                                    value="false" checked>
                                <label class="form-check-label" for="active">Đang phát sóng</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="coming"
                                    value="true" ${anime.status ? 'checked' : ''}>
                                <label class="form-check-label" for="coming">Hoàn thành</label>
                            </div>
                        </div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="row g-3">
					<div class="col-md-6">
						<fmt:formatDate value="${anime.releaseDate}" pattern="yyyy-MM-dd" var="formattedDate" />
						<label for="releaseDate" class="form-label">Ngày phát sóng</label> 
						<input type="date" class="form-control" id="releaseDate" name="releaseDate" value="${formattedDate}" required>
						<small class="invalid-feedback">Vui lòng chọn ngày</small>
					</div>
					<div class="col-md-6">
						<label for="duration" class="form-label">Thời lượng</label> 
						<input type="number" min="1" class="form-control" id="duration" name="duration" placeholder="Thời lượng (phút)" value="${anime != null ? anime.duration : '0'}" required> 
						<small class="invalid-feedback">Vui lòng nhập thời lượng và lớn hơn 0</small>
					</div>
					<div class="col-12">
						<label for="poster" class="form-label">Poster</label> 
						<input type="file" class="form-control" id="poster" name="poster" accept=".jpg,.png,.webp" required> 
						<small class="invalid-feedback">Vui lòng chọn poster</small>
						<input type="hidden" name="oldPoster" value="${anime != null ? anime.poster : ''}">
					</div>
					<div class="col-12">
						<label for="description" class="form-label">Mô tả</label>
						<textarea class="form-control" id="description" name="description" rows="5" placeholder="Mô tả ..." required>${anime != null ? anime.description : ''}</textarea>
						<small class="invalid-feedback">Vui lòng nhập mô tả</small>
					</div>
				</div>
			</div>
			<div class="col-12">
				<input type="hidden" class="form-control" id="id" name="id" value="${anime.id}">
				<button type="submit" class="btn btn-success">Thêm phim</button>
				<a href="${pageContext.request.contextPath}/admin/anime/list" class="btn btn-primary" type="button">Quay lại</a>
			</div>
		</form>

		</div>
	</div>
</div>
