<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


	<div class="col-lg-8 col-md-8">
		<div class="anime__details__review">
			<div class="section-title">
				<h5>Reviews</h5>
			</div>

			<div class="comment-list" id="comment-list">
				<c:forEach items="${comments}" var="comment">
					<div class="anime__review__item">
						<div class="anime__review__item__pic">
							<img
								src="${pageContext.request.contextPath}/assets/client/img/anime/review-1.jpg"
								alt="">
						</div>
						<div class="anime__review__item__text">
							<h6>${comment.user.username}
								-
								<fmt:formatDate value="${comment.created}" pattern="dd/MM/yyyy" />
							</h6>
							<p>${comment.content}</p>
						</div>
					</div>
				</c:forEach>
			</div>

		</div>
		<div class="anime__details__form">
			<div class="section-title">
				<h5>Your Comment</h5>
			</div>
			<form>
				<textarea placeholder="Your Comment" name="content" id="content"
					class="text-dark"></textarea>
				<button type="button" onclick="sendComment('${anime.slug}')">
					<i class="fa fa-location-arrow"></i> Review
				</button>
			</form>
		</div>
	</div>


<script>
function sendComment(slug) {
    var content = document.getElementById("content").value;

    const data = {
        slug: slug,
        content: content
    };

    fetch("${pageContext.request.contextPath}/comment/insert", {
        method: "POST",
        body: JSON.stringify(data)
    })
    .then(resp => resp.json())
    .then(json => {
        if (json && json.content) {
            
        	 const commentList = document.getElementById("comment-list");
             const newComment = document.createElement("div");
             newComment.classList.add("anime__review__item");

             newComment.innerHTML =
            	    '<div class="anime__review__item__pic">' +
            	        '<img src="${pageContext.request.contextPath}/assets/client/img/anime/review-1.jpg" alt="">' +
            	    '</div>' +
            	    '<div class="anime__review__item__text">' +
            	        '<h6>' + json.username + ' - ' + formatDate(json.created) + '</h6>' +
            	        '<p>' + json.content + '</p>' +
            	    '</div>';


             commentList.prepend(newComment);
             document.getElementById("content").value = "";
             
        } else {
            alert("Đăng nhập để bình luận.");
        }
    })
    .catch(error => {
        console.error("Lỗi khi gửi bình luận:", error);
    });
};

function formatDate(dateString) {
    const date = new Date(dateString);
    const day = String(date.getDate()).padStart(2, "0");
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const year = date.getFullYear();
    return day + '/' + month + '/' + year;
}
</script>