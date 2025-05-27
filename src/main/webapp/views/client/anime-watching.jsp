<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- Anime Section Begin -->
<section class="anime-details spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="anime__video__player">
					<!-- <video id="player" playsinline controls data-poster="${pageContext.request.contextPath}/assets/client/videos/anime-watch.jpg">
                            <source src="${pageContext.request.contextPath}/assets/client/videos/1.mp4" type="video/mp4" />
                            <track kind="captions" label="English captions" src="#" srclang="en" default />
                        </video> -->

					<iframe width="100%" height="640" id="iframePlayer"
						src="https://www.youtube.com/embed/${selectedEpisode}"
						title="YouTube video player" frameborder="0"
						allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
						referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

				</div>
				<div class="anime__details__episodes">
					<div class="section-title">
						<h5>List Name</h5>
					</div>
					<form action="" method="post">
						<c:forEach items="${episodes}" var="episode">
							<a
								href="${pageContext.request.contextPath}/anime-watching?slug=${slug}&episode=${episode.episodeNumber}">Ep
								<fmt:formatNumber value="${episode.episodeNumber}" pattern="00" />
							</a>

						</c:forEach>
					</form>
				</div>
			</div>
		</div>
		<div class="row">

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
										<fmt:formatDate value="${comment.created}"
											pattern="dd/MM/yyyy" />
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
						<button type="button" onclick="sendComment('${slug}')">
							<i class="fa fa-location-arrow"></i> Review
						</button>
					</form>
				</div>
			</div>

			<div class="col-lg-4 col-md-6 col-sm-8">
				<div class="product__sidebar">
					<div class="product__sidebar__view">
						<div class="section-title">
							<h5>Top Views</h5>
						</div>
						<ul class="filter__controls">
							<li class="active" data-filter="*">Day</li>
							<li data-filter=".week">Week</li>
							<li data-filter=".month">Month</li>
							<li data-filter=".years">Years</li>
						</ul>
						<div class="filter__gallery">
							<div class="product__sidebar__view__item set-bg mix day years"
								data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-1.jpg">
								<div class="ep">18 / ?</div>
								<div class="view">
									<i class="fa fa-eye"></i> 9141
								</div>
								<h5>
									<a href="#">Boruto: Naruto next generations</a>
								</h5>
							</div>
							<div class="product__sidebar__view__item set-bg mix month week"
								data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-2.jpg">
								<div class="ep">18 / ?</div>
								<div class="view">
									<i class="fa fa-eye"></i> 9141
								</div>
								<h5>
									<a href="#">The Seven Deadly Sins: Wrath of the Gods</a>
								</h5>
							</div>
							<div class="product__sidebar__view__item set-bg mix week years"
								data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-3.jpg">
								<div class="ep">18 / ?</div>
								<div class="view">
									<i class="fa fa-eye"></i> 9141
								</div>
								<h5>
									<a href="#">Sword art online alicization war of underworld</a>
								</h5>
							</div>
							<div class="product__sidebar__view__item set-bg mix years month"
								data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-4.jpg">
								<div class="ep">18 / ?</div>
								<div class="view">
									<i class="fa fa-eye"></i> 9141
								</div>
								<h5>
									<a href="#">Fate/stay night: Heaven's Feel I. presage
										flower</a>
								</h5>
							</div>
							<div class="product__sidebar__view__item set-bg mix day"
								data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-5.jpg">
								<div class="ep">18 / ?</div>
								<div class="view">
									<i class="fa fa-eye"></i> 9141
								</div>
								<h5>
									<a href="#">Fate stay night unlimited blade works</a>
								</h5>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Anime Section End -->
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
