package com.ass.dao;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ass.entity.Comment;
import com.ass.utils.XJPA;

import jakarta.persistence.EntityManager;

public class CommentDAO extends AbstractDAO<Comment, Integer> {
	public CommentDAO() {
		super(Comment.class);
	}
	
	public Map<Integer, Long> countCommentsByAnimeIds(List<Integer> animeIds) {
	    EntityManager entityManager = XJPA.getEntityManager();
	    if (animeIds == null || animeIds.isEmpty()) return Collections.emptyMap();

	    String jpql = "SELECT c.anime.id, COUNT(c.id) FROM Comment c WHERE c.anime.id IN :ids GROUP BY c.anime.id";
	    List<Object[]> result = entityManager.createQuery(jpql, Object[].class)
	                                          .setParameter("ids", animeIds)
	                                          .getResultList();

	    Map<Integer, Long> countMap = new HashMap<>();
	    for (Object[] row : result) {
	        countMap.put((Integer) row[0], (Long) row[1]);
	    }
	    return countMap;
	}
	
	public List<Comment> getCommentsByAnimeId(int animeId) {
	    EntityManager em = XJPA.getEntityManager();
	    String jpql = "SELECT c FROM Comment c WHERE c.anime.id = :animeId ORDER BY c.created DESC";
	    return em.createQuery(jpql, Comment.class)
	             .setParameter("animeId", animeId)
	             .getResultList();
	}


}
