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
                    <h4 class="card-title fs-2 text-center">Thống kê tương tác</h4>
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
                            <th>Tên người dùng</th>
                            <th>Tổng yêu thích</th>
                            <th>Tổng bình luận</th>
                            <th>Tổng đánh giá</th>
                            <th>Tổng tương tác</th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>Tên người dùng</th>
                            <th>Tổng yêu thích</th>
                            <th>Tổng bình luận</th>
                            <th>Tổng đánh giá</th>
                            <th>Tổng tương tác</th>
                          </tr>
                        </tfoot>
                        <tbody>
	                        <c:forEach items="${getTopActiveUsers}" var="user">
	                          <tr>
	                            <td>${user[1]}</td>
	                            <td>${user[2]}</td> 
	                            <td>${user[3]}</td>
	                            <td>${user[4]}</td>
	                            <td>${user[5]}</td>
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

            
            