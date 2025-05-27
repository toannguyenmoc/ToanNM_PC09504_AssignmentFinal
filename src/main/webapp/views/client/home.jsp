<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
    <!-- Hero Section Begin -->
    <section class="hero">
        <div class="container">
            <div class="hero__slider owl-carousel">
                <div class="hero__items set-bg" data-setbg="${pageContext.request.contextPath}/assets/client/img/hero/hero-1.jpg">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="hero__text">
                                <div class="label">Adventure</div>
                                <h2>Fate / Stay Night: Unlimited Blade Works</h2>
                                <p>Sau 30 ngày du lịch vòng quanh thế giới...</p>
                                <a href="#"><span>Xem Ngay</span> <i class="fa fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="hero__items set-bg" data-setbg="${pageContext.request.contextPath}/assets/client/img/hero/hero-1.jpg">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="hero__text">
                                <div class="label">Adventure</div>
                                <h2>Fate / Stay Night: Unlimited Blade Works</h2>
                                <p>After 30 days of travel across the world...</p>
                                <a href="#"><span>Watch Now</span> <i class="fa fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="hero__items set-bg" data-setbg="${pageContext.request.contextPath}/assets/client/img/hero/hero-1.jpg">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="hero__text">
                                <div class="label">Adventure</div>
                                <h2>Fate / Stay Night: Unlimited Blade Works</h2>
                                <p>After 30 days of travel across the world...</p>
                                <a href="#"><span>Watch Now</span> <i class="fa fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Hero Section End -->

    <!-- Product Section Begin -->
    <section class="product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="trending__product">
                        <div class="row">
                            <div class="col-lg-8 col-md-8 col-sm-8">
                                <div class="section-title">
                                    <h4>Trending Now</h4>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4">
                                <div class="btn__all">
                                    <a href="#" class="primary-btn" onclick="window.location.search = 'viewAll=true';">View All <span class="arrow_right"></span></a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                        <c:choose>
        				<c:when test="${not empty list}">
                        	<c:forEach items="${list}" var="anime">
                        	<c:set var="count" value="${episodeCounts[anime.id]}" />
                        	<c:set var="commentCount" value="${commentCounts[anime.id]}" />
	                            <div class="col-lg-4 col-md-6 col-sm-6">
	                                <div class="product__item">
	                                    <div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath}/images/${anime.poster}">
	                                        <div class="ep">${count != null ? count : "?"} / ${anime.totalEpisodes}</div>
	                                        <div class="comment"><i class="fa fa-comments"></i> ${commentCount != null ? commentCount : 0}</div>
	                                        <div class="view"><i class="fa fa-eye"></i> ${anime.views}</div>
	                                    </div>
	                                    <div class="product__item__text">
	                                        <ul>
	                                            <li>Active</li>
	                                            <li>Movie</li>
	                                        </ul>
	                                        <h5><a href="${pageContext.request.contextPath}/anime-details?slug=${anime.slug}">${anime.title}</a></h5>
	                                    </div>
	                                </div>
	                            </div>
                           	</c:forEach>
                         </c:when>
				        <c:otherwise>
				            <div class="text-danger fs-2 fw-bold text-center mx-auto">Không tìm thấy phim phù hợp!</div>
				        </c:otherwise>
				    </c:choose>                         
                        </div>
                        <form action="" method="get" class="d-flex justify-content-center">
                        <input type="hidden" name="searchQuery" value="${searchQuery}"> 
                        <nav aria-label="Page navigation example">
							<c:if test="${totalPages > 0}">
							  <ul class="pagination rounded-circle">
							    <c:if test="${currentPage > 1}">
								    <li class="page-item mx-1">
								        <button class="page-link shadow-none rounded-circle" aria-label="Previous" name="pageNumber" value="${currentPage - 1}">
								            <span aria-hidden="true">&laquo;</span>
								        </button>
								    </li>
								</c:if>
							    <c:forEach var="i" begin="1" end="${totalPages}">
								    <li class="page-item mx-1 ${i == currentPage ? 'active' : ''}">
								        <button class="page-link shadow-none rounded-circle" value="${i}" name="pageNumber">${i}</button>
								    </li>
								</c:forEach>
							    <c:if test="${currentPage < totalPages}">
								    <li class="page-item mx-1">
								        <button class="page-link shadow-none rounded-circle" aria-label="Next" name="pageNumber" value="${currentPage + 1}">
								            <span aria-hidden="true">&raquo;</span>
								        </button>
								    </li>
								</c:if>
							  </ul>
						 	</c:if>
						</nav>
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
                                <div class="view"><i class="fa fa-eye"></i> 9141</div>
                                <h5><a href="#">Boruto: Naruto next generations</a></h5>
                            </div>
                            <div class="product__sidebar__view__item set-bg mix month week"
                            data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-2.jpg">
                            <div class="ep">18 / ?</div>
                            <div class="view"><i class="fa fa-eye"></i> 9141</div>
                            <h5><a href="#">The Seven Deadly Sins: Wrath of the Gods</a></h5>
                        </div>
                        <div class="product__sidebar__view__item set-bg mix week years"
                        data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-3.jpg">
                        <div class="ep">18 / ?</div>
                        <div class="view"><i class="fa fa-eye"></i> 9141</div>
                        <h5><a href="#">Sword art online alicization war of underworld</a></h5>
                    </div>
                    <div class="product__sidebar__view__item set-bg mix years month"
                    data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-4.jpg">
                    <div class="ep">18 / ?</div>
                    <div class="view"><i class="fa fa-eye"></i> 9141</div>
                    <h5><a href="#">Fate/stay night: Heaven's Feel I. presage flower</a></h5>
                </div>
                <div class="product__sidebar__view__item set-bg mix day"
                data-setbg="${pageContext.request.contextPath}/assets/client/img/sidebar/tv-5.jpg">
                <div class="ep">18 / ?</div>
                <div class="view"><i class="fa fa-eye"></i> 9141</div>
                <h5><a href="#">Fate stay night unlimited blade works</a></h5>
            </div>
        </div>
    </div>
    <div class="product__sidebar__comment">
        <div class="section-title">
            <h5>New Comment</h5>
        </div>
        <div class="product__sidebar__comment__item">
            <div class="product__sidebar__comment__item__pic">
                <img src="${pageContext.request.contextPath}/assets/client/img/sidebar/comment-1.jpg" alt="">
            </div>
            <div class="product__sidebar__comment__item__text">
                <ul>
                    <li>Active</li>
                    <li>Movie</li>
                </ul>
                <h5><a href="#">The Seven Deadly Sins: Wrath of the Gods</a></h5>
                <span><i class="fa fa-eye"></i> 19.141 Viewes</span>
            </div>
        </div>
        <div class="product__sidebar__comment__item">
            <div class="product__sidebar__comment__item__pic">
                <img src="${pageContext.request.contextPath}/assets/client/img/sidebar/comment-2.jpg" alt="">
            </div>
            <div class="product__sidebar__comment__item__text">
                <ul>
                    <li>Active</li>
                    <li>Movie</li>
                </ul>
                <h5><a href="#">Shirogane Tamashii hen Kouhan sen</a></h5>
                <span><i class="fa fa-eye"></i> 19.141 Viewes</span>
            </div>
        </div>
        <div class="product__sidebar__comment__item">
            <div class="product__sidebar__comment__item__pic">
                <img src="${pageContext.request.contextPath}/assets/client/img/sidebar/comment-3.jpg" alt="">
            </div>
            <div class="product__sidebar__comment__item__text">
                <ul>
                    <li>Active</li>
                    <li>Movie</li>
                </ul>
                <h5><a href="#">Kizumonogatari III: Reiket su-hen</a></h5>
                <span><i class="fa fa-eye"></i> 19.141 Viewes</span>
            </div>
        </div>
        <div class="product__sidebar__comment__item">
            <div class="product__sidebar__comment__item__pic">
                <img src="${pageContext.request.contextPath}/assets/client/img/sidebar/comment-4.jpg" alt="">
            </div>
            <div class="product__sidebar__comment__item__text">
                <ul>
                    <li>Active</li>
                    <li>Movie</li>
                </ul>
                <h5><a href="#">Monogatari Series: Second Season</a></h5>
                <span><i class="fa fa-eye"></i> 19.141 Viewes</span>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</div>
    </section>
<!-- Product Section End -->