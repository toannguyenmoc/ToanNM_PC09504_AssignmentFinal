package com.ass.dao;

import java.util.List;


import com.ass.entity.Rating;
import com.ass.utils.XJPA;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class RatingDAO extends AbstractDAO<Rating, Integer> {
	public RatingDAO() {
		super(Rating.class);
	}
	
	public Rating findUserRatingByAnime(Integer animeId, Integer userId) {
		EntityManager entityManager = XJPA.getEntityManager();
		String jpql = "SELECT ra FROM Rating ra WHERE ra.anime.id = :anime_id AND ra.user.id = :user_id";
		TypedQuery<Rating> query = entityManager.createQuery(jpql, Rating.class);
		query.setParameter("anime_id", animeId);
		query.setParameter("user_id", userId);

		List<Rating> result = query.getResultList();
		return result.isEmpty() ? null : result.get(0);
	}
}
