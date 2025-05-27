<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- Anime Section Begin -->
<section class="anime-details spad">
	<div class="container">
		<div class="anime__details__content">
			<div class="row">
				<div class="col-lg-3">
					<div class="anime__details__pic set-bg"
						data-setbg="${pageContext.request.contextPath}/images/${anime.poster}">
						<div class="comment">
							<i class="fa fa-comments"></i> ${comments.size()}
						</div>
						<div class="view">
							<i class="fa fa-eye"></i> ${anime.views}
						</div>
					</div>
				</div>
				<div class="col-lg-9">
					<div class="anime__details__text">
						<div class="anime__details__title">
							<h3>${anime.title}</h3>
							<span>${anime.author}</span>
						</div>
						<div class="anime__details__rating">
							<div class="rating">
								<c:choose>
									<c:when test="${not empty sessionScope.user}">
										<c:forEach var="i" begin="1" end="5">
											<i
												class="fa fa-star text-secondary rating-star ${i <= rating.rating ? 'text-warning' : ''}"
												data-value="${i}"
												onclick="rateAnime('${sessionScope.user.id}', '${anime.id}', ${i})"></i>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="i" begin="1" end="5">
											<i class="fa fa-star text-warning rating-star disabled"
												data-value="${i}"></i>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>

							<span>1.029 Votes</span>
						</div>
						<p>${anime.description}</p>
						<div class="anime__details__widget">
							<div class="row">
								<div class="col-lg-6 col-md-6">
									<ul>
										<li><span>Loại:</span> Phim Hoạt Hình</li>
										<li><span>Ngày phát sóng:</span> <fmt:formatDate
												value="${anime.releaseDate}" pattern="dd/MM/yyyy" /></li>
										<li><span>Trạng thái:</span> ${anime.status?"Đang phát sóng":"Hoàn thành"}</li>
										<li><span>Thể loại:</span> ${anime.genre}</li>
									</ul>
								</div>
								<div class="col-lg-6 col-md-6">
									<ul>
										<li><span>Xếp hạng:</span> 9.5</li>
										<li><span>Thời lượng:</span> ${anime.duration} phút / tập</li>
										<li><span>Chất lượng:</span> HD</li>
										<li><span>Lượt xem:</span> ${anime.views}</li>
									</ul>
								</div>
							</div>
						</div>

						<div class="anime__details__btn">
							<a href="#"
								class="follow-btn ${favorite ? 'bg-danger' : 'bg-secondary'}"
								onclick="favorite(${sessionScope.user.id},${anime.id})"
								id="btn-like-${anime.id}"> <i class="fa fa-heart-o"></i>${favorite ? "Bỏ thích": "Yêu thích"}
							</a> <a
								href="${pageContext.request.contextPath}/anime-watching?slug=${anime.slug}&episode=1"
								class="watch-btn"><span>Xem ngay</span> <i
								class="fa fa-angle-right"></i></a>
						</div>
					</div>
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
						<button class="comment" type="button"
							onclick="sendComment('${anime.slug}')">
							<i class="fa fa-location-arrow"></i> Review
						</button>
					</form>
				</div>
			</div>
			<div class="col-lg-4 col-md-4">
				<div class="anime__details__sidebar">
					<div class="section-title">
						<h5>you might like...</h5>
					</div>
					<div class="product__sidebar__view__item set-bg"
						data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-1.jpg">
						<div class="ep">18 / ?</div>
						<div class="view">
							<i class="fa fa-eye"></i> 9141
						</div>
						<h5>
							<a href="#">Boruto: Naruto next generations</a>
						</h5>
					</div>
					<div class="product__sidebar__view__item set-bg"
						data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-2.jpg">
						<div class="ep">18 / ?</div>
						<div class="view">
							<i class="fa fa-eye"></i> 9141
						</div>
						<h5>
							<a href="#">The Seven Deadly Sins: Wrath of the Gods</a>
						</h5>
					</div>
					<div class="product__sidebar__view__item set-bg"
						data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-3.jpg">
						<div class="ep">18 / ?</div>
						<div class="view">
							<i class="fa fa-eye"></i> 9141
						</div>
						<h5>
							<a href="#">Sword art online alicization war of underworld</a>
						</h5>
					</div>
					<div class="product__sidebar__view__item set-bg"
						data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-4.jpg">
						<div class="ep">18 / ?</div>
						<div class="view">
							<i class="fa fa-eye"></i> 9141
						</div>
						<h5>
							<a href="#">Fate/stay night: Heaven's Feel I. presage flower</a>
						</h5>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Anime Section End -->
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
	
    <script>
        const favorite = (userId, animeId) => {

            const data = {
                "userId": userId,
                "animeId": animeId
            };

            const url = "${pageContext.request.contextPath}/favorite/action";
            const option = {
                method: "POST",
                body: JSON.stringify(data)
            };

            fetch(url, option)
                .then(resp => resp.json())
                .then(json => {

                    if (json.status === "ok") {
                        var likeButton = document.getElementById("btn-like-" + animeId);
                        if (likeButton) {
                            likeButton.innerHTML = '<i class="fa fa-heart-o"></i>' + (json.favorited ? " Bỏ thích" : " Yêu thích");
                            if (json.favorited) {
                                likeButton.classList.add("bg-danger");
                                likeButton.classList.remove("bg-secondary");
                            } else {
                                likeButton.classList.add("bg-secondary");
                                likeButton.classList.remove("bg-danger");
                            }
                        }
                    }
                })
                .catch(error => {
                    console.error("Lỗi khi gửi yêu cầu yêu thích:", error);
                });
        };

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

        document.addEventListener("DOMContentLoaded", () => {
            const userId = "${sessionScope.user != null ? sessionScope.user.id : ''}";

            document.querySelectorAll(".follow-btn").forEach(button => {
                button.addEventListener("click", (event) => {
                    event.preventDefault();

                    if (!userId || userId === '') {
                        alert("Vui lòng đăng nhập để yêu thích anime!");
                        return;
                    }

                    const animeId = button.getAttribute("data-anime-id");
                    favorite(userId, animeId);
                });
            });

            document.querySelectorAll(".comment").forEach(button => {
                button.addEventListener("click", (event) => {
                    event.preventDefault();

                    if (!userId || userId === '') {
                        alert("Vui lòng đăng nhập để bình luận!");
                        return;
                    }

                    sendComment(slug);
                });
            });
        });
                

        document.addEventListener("DOMContentLoaded", () => {
            const userId = "${sessionScope.user != null ? sessionScope.user.id : ''}";
            const animeId = "${anime.id}";
            const stars = document.querySelectorAll(".rating i");
           	let userRating = "${rating.rating}";
            let selectedRating = userRating || 0;

            stars.forEach(star => {
                star.addEventListener("mouseover", function () {
                    const rating = parseInt(star.getAttribute("data-value"));
                    highlightStars(rating);
                });

                star.addEventListener("mouseout", function () {
                    highlightStars(selectedRating);
                });

                star.addEventListener("click", function () {

                    selectedRating = parseInt(star.getAttribute("data-value"));
                    console.log(`Người dùng ${userId} đánh giá ${animeId} với ${selectedRating} sao`);

                    highlightStars(selectedRating);

                    const data = {
                        "userId": userId,
                        "animeId": animeId,
                        "rating": selectedRating
                    };

                    fetch('${pageContext.request.contextPath}/rating', {
                        method: "POST",
                        body: JSON.stringify(data)
                    })
                        .then(resp => resp.json())
                        .then(json => console.log("Phản hồi từ server:", json))
                        .catch(error => console.error("Lỗi khi gửi đánh giá:", error));
                });
            });

            function highlightStars(rating) {
                stars.forEach((s, index) => {
                    s.classList.toggle("text-warning", index < rating);
                    s.classList.toggle("text-secondary", index >= rating);
                });
            }
            });
            

    </script>