package com.ass.dao;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ass.entity.Episode;
import com.ass.utils.XJPA;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class EpisodeDAO extends AbstractDAO<Episode, Integer> {

	public EpisodeDAO() {
		super(Episode.class);
	}
	
	public Episode selectByAnimeIdAndEpisodeNumberExceptId(Integer animeId, Integer episodeNumber, Integer excludeEpisodeId) {
	    EntityManager entityManager = XJPA.getEntityManager();
	    try {
	        String jpql = "SELECT e FROM Episode e WHERE e.anime.id = :animeId AND e.episodeNumber = :episodeNumber AND e.id <> :excludeEpisodeId";
	        TypedQuery<Episode> query = entityManager.createQuery(jpql, Episode.class);
	        query.setParameter("animeId", animeId);
	        query.setParameter("episodeNumber", episodeNumber);
	        query.setParameter("excludeEpisodeId", excludeEpisodeId);

	        List<Episode> result = query.getResultList();
	        return result.isEmpty() ? null : result.get(0);
	    } finally {
	        entityManager.close();
	    }
	}

	public List<Episode> selectByAnimeId(Integer animeId){
		EntityManager entityManager = XJPA.getEntityManager();
		try {
	        String jpql = "SELECT e FROM Episode e WHERE e.anime.id = :animeId";
	        TypedQuery<Episode> query = entityManager.createQuery(jpql, Episode.class);
	        query.setParameter("animeId", animeId);
	        return query.getResultList();
	    } finally {
	        entityManager.close();
	    }
	}
	
	public Map<Integer, Long> countEpisodesByAnimeIds(List<Integer> animeIds) {
		EntityManager entityManager = XJPA.getEntityManager();
	    if (animeIds == null || animeIds.isEmpty()) return Collections.emptyMap();

	    String jpql = "SELECT e.anime.id, COUNT(e.id) FROM Episode e WHERE e.anime.id IN :ids GROUP BY e.anime.id";
	    List<Object[]> result = entityManager.createQuery(jpql, Object[].class)
	                              .setParameter("ids", animeIds)
	                              .getResultList();

	    Map<Integer, Long> countMap = new HashMap<>();
	    for (Object[] row : result) {
	        countMap.put((Integer) row[0], (Long) row[1]);
	    }
	    return countMap;
	}


}
