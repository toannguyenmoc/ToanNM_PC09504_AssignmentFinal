<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

         <div class="container">
          <div class="page-inner">
        
            <div class="row">
              <div class="col-md-12">
                <div class="card">
                  <div class="card-header d-flex justify-content-between">
                    <h4 class="card-title fs-2 text-center">Danh sách Tập Anime</h4>
                    <div class="">
                  		<a href="${pageContext.request.contextPath}/admin/episode/insert" class="btn btn-primary"><i class="fas fa-plus me-3"></i>Thêm Tập Phim</a>
                  	</div>
                  </div>
                  
                  <div class="card-body">
                    <div class="table-responsive">
                      <table
                        id="basic-datatables"
                        class="display table table-striped table-hover">
                        <thead>
                          <tr>
                            <th>Tên Phim</th>
                            <th>Tập</th>
                            <th>Video_URL</th>
                            <th style="width: 100px;">Ngày tạo</th>
                            <th style="width: 100px;">Hành động</th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>Tên Phim</th>
                            <th>Tập</th>
                            <th>Video_URL</th>
                            <th>Ngày tạo</th>
                            <th>Hành động</th>
                          </tr>
                        </tfoot>
                        <tbody>
                        <c:forEach items="${list}" var="episode">
                          <tr>
                            <td>${episode.anime.title}</td>
                            <td>${episode.episodeNumber}</td> 
                            <td>${episode.videoUrl}</td>
                            <td><fmt:formatDate value="${episode.releaseDate}" pattern="dd-MM-yyyy" /></td>
                            <td class="">
                            	<a href="${pageContext.request.contextPath}/admin/episode/update?id=${episode.id}" class="fs-3 me-3 text-warning">
									<i class="fas fa-edit"></i>
								</a>
								<a href="#" class="fs-3 text-danger"
								data-bs-toggle="modal" data-bs-target="#confirmDeleteModal"
								onclick="setDeleteUrl('${pageContext.request.contextPath}/admin/episode/delete?id=${episode.id}')">
									<i class="fas fa-trash-alt"></i>
								</a>
                            </td>
                          </tr>
                          </c:forEach>
                        </tbody>
                      </table>
             <!-- Modal Xác Nhận Xóa -->
			<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
			    <div class="modal-dialog">
			    
				        <div class="modal-content">
				            <div class="modal-header">
				                <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
				                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				            </div>
				            <div class="modal-body">
				                Bạn có chắc chắn muốn xóa phim này không?
				            </div>
				            <div class="modal-footer">
				                <a id="confirmDelete" href="#" class="btn btn-danger">Xóa</a>
				                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
				            </div>
				        </div>
				        
			    </div>
			</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
       </div>
       
<script>
function setDeleteUrl(url) {
    document.getElementById('confirmDelete').href = url;
}
</script>     
            
            