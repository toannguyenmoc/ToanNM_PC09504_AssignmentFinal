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
                    <h4 class="card-title fs-2 text-center">Danh sách tài khoản</h4>
                    <div class="">
                  		
                  	</div>
                  </div>
                  
                  <div class="card-body">
                    <div class="table-responsive">
                      <table
                        id="basic-datatables"
                        class="display table table-striped table-hover">
                        <thead>
                          <tr>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>Ngày tạo</th>
                            <th>Quyền</th>
                            <th>Hành động</th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>Ngày tạo</th>
                            <th>Quyền</th>
                            <th>Hành động</th>
                          </tr>
                        </tfoot>
                        <tbody>
	                        <c:forEach items="${list}" var="user">
	                          <tr>
	                            <td>${user.username}</td>
	                            <td>${user.email}</td> 
	                            <td><fmt:formatDate value="${user.created}" pattern="dd-MM-yyyy" /></td>
	                            <td>${user.role?"admin":"user"}</td>
	                            <td>
	                            	<div class="form-check form-switch p-0">
									  <input class="form-check-input fs-5 status" type="checkbox" role="switch"
									   id="${user.id}" ${user.active?"checked":""}>
									</div>
	                            </td>
	                          </tr>
	                         </c:forEach> 
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
       </div>

<script>
	document.addEventListener("DOMContentLoaded", function () {
	    // Lấy tất cả checkbox
	    const checkboxes = document.querySelectorAll('.status');
	
	    // Gắn sự kiện 'change' cho từng checkbox
	    checkboxes.forEach(checkbox => {
	        checkbox.addEventListener('change', function () {
	            const id = this.id; // Lấy ID của checkbox
	            const status = this.checked; // Lấy trạng thái (true nếu checked, false nếu không)
	
	            console.log("User ID:", id);
	            console.log("Status:", status);
	
	            const params = new URLSearchParams();
	            params.append('id', id);
	            params.append('status', status);

	            fetch(`${pageContext.request.contextPath}/admin/user/list`, {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/x-www-form-urlencoded', // Định nghĩa kiểu dữ liệu
	                },
	                body: params.toString()
	            })
	            .then(response => response.text())
	            .then(data => {
	                console.log("Phản hồi từ server:", data);
	            })
	            .catch(error => {
	                console.error("Lỗi khi gửi dữ liệu:", error);
	            });
	        });
	    });
	});
</script>
            
            