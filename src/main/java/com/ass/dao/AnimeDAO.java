package com.ass.dao;

import java.util.List;

import com.ass.entity.Anime;
import com.ass.utils.XJPA;

import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.StoredProcedureQuery;
import jakarta.persistence.TypedQuery;

public class AnimeDAO extends AbstractDAO<Anime, Integer>{
	public AnimeDAO() {
		super(Anime.class);
	}
	
	public Boolean selectBySlug(String slug) {
	    EntityManager entityManager = XJPA.getEntityManager();
	    String jpql = "SELECT COUNT(e) FROM Anime e WHERE e.slug = :slug";
	    TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
	    query.setParameter("slug", slug);   
	    
	    Long count = query.getSingleResult();  
	    return count > 0; 
	}
	
	public Boolean isSlugExist(String slug, Integer id) {
	    EntityManager entityManager = XJPA.getEntityManager();
	    String jpql = "SELECT COUNT(e) FROM Anime e WHERE e.slug = :slug AND e.id != :id";
	    TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
	    query.setParameter("slug", slug);  
	    query.setParameter("id", id);  
	    
	    Long count = query.getSingleResult();  
	    return count > 0; 
	}
	
	public List<Anime> findAnimeByUserId(Integer userId){
		EntityManager entityManager = XJPA.getEntityManager();
		String jpql = "SELECT fa.anime FROM Favorite fa WHERE fa.user.id = :user_id";
		TypedQuery<Anime> query = entityManager.createQuery(jpql, Anime.class);
		query.setParameter("user_id", userId);
		return query.getResultList();
	}
	
	public int getViews(int animeId) {
		EntityManager entityManager = XJPA.getEntityManager();
		TypedQuery<Integer> query = entityManager.createQuery(
			"SELECT a.views FROM Anime a WHERE a.id = :id", Integer.class);
		query.setParameter("id", animeId);
		return query.getSingleResult();
	}

	public void updateViews(int animeId, int views) {
		EntityManager entityManager = XJPA.getEntityManager();
	    try {
	    	entityManager.getTransaction().begin();

	        Anime anime = entityManager.find(Anime.class, animeId);
	        if (anime != null) {
	            anime.setViews(views);
	            entityManager.merge(anime);
	        }

	        entityManager.getTransaction().commit();
	    } catch (Exception e) {
	        if (entityManager.getTransaction().isActive()) {
	        	entityManager.getTransaction().rollback();
	        }
	        e.printStackTrace(); 
	    }
	}
	
	public void increaseViews(int animeId) {
		EntityManager entityManager = XJPA.getEntityManager();
	    try {
	    	entityManager.getTransaction().begin();
	        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("UpdateViews");
	        query.registerStoredProcedureParameter("anime_id", Integer.class, ParameterMode.IN);
	        query.setParameter("anime_id", animeId);
	        query.execute();
	        entityManager.getTransaction().commit();
	    } catch (Exception e) {
	        e.printStackTrace();
	        if (entityManager.getTransaction().isActive()) entityManager.getTransaction().rollback();
	    } finally {
	    	entityManager.close();
	    }
	}

	
}
