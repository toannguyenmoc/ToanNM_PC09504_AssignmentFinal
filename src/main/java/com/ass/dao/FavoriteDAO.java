package com.ass.dao;

import java.util.List;

import com.ass.entity.Favorite;
import com.ass.utils.XJPA;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class FavoriteDAO extends AbstractDAO<Favorite, Integer> {
	public FavoriteDAO() {
		super(Favorite.class);
	}
	
	public Favorite findUserFavoriteByAnime(Integer animeId, Integer userId) {
		EntityManager entityManager = XJPA.getEntityManager();
		String jpql = "SELECT fa FROM Favorite fa WHERE fa.anime.id = :anime_id AND fa.user.id = :user_id";
		TypedQuery<Favorite> query = entityManager.createQuery(jpql, Favorite.class);
		query.setParameter("anime_id", animeId);
		query.setParameter("user_id", userId);

		List<Favorite> result = query.getResultList();
		return result.isEmpty() ? null : result.get(0);
	}
}
