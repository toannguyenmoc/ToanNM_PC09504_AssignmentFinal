<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

         <div class="container">
          <div class="page-inner">
        
            <div class="row">
              <div class="col-md-12">
                <div class="card">
                  <div class="card-header d-flex justify-content-between">
                    <h4 class="card-title fs-2 text-center">Danh sách Anime</h4>
                    <div class="">
                  		<a href="${pageContext.request.contextPath}/admin/anime/insert" class="btn btn-primary"><i class="fas fa-plus me-3"></i>Thêm Phim</a>
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
                            <th>Poster</th>
                            <th>Lượt xem</th>
                            <th>Đánh giá</th>
                            <th>Hành động</th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>Tên Phim</th>
                            <th>Poster</th>
                            <th>Lượt xem</th>
                            <th>Đánh giá</th>
                            <th>Hành động</th>
                          </tr>
                        </tfoot>
                        <tbody>
                        <c:forEach items="${list}" var="anime">
                          <tr>
                            <td>${anime.title}</td>
                            <td>
                            	<img src="${pageContext.request.contextPath}/images/${anime.poster}" alt="" width="85px;" height="120px;">
                            </td> 
                            <td>${anime.views}</td>
                            <td>
								<div class="star_rating text-warning">
									<i class="fas fa-star"></i>
									<i class="fas fa-star"></i>
									<i class="fas fa-star"></i>
									<i class="fas fa-star"></i>
									<i class="fas fa-star"></i>
								</div>                            
                            </td>
                            <td class="">
                            	<a href="${pageContext.request.contextPath}/admin/anime/update?id=${anime.id}" class="fs-3 me-3 text-warning">
									<i class="fas fa-edit"></i>
								</a>
								<a href="#" class="fs-3 text-danger"
								data-bs-toggle="modal" data-bs-target="#confirmDeleteModal"
								onclick="setDeleteUrl('${pageContext.request.contextPath}/admin/anime/delete?id=${anime.id}')">
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
            
            