package com.ass.dao;

import java.util.List;

import com.ass.utils.XJPA;

import jakarta.persistence.EntityManager;
import jakarta.persistence.StoredProcedureQuery;

public class StatisticalDAO {
	
	@SuppressWarnings("unchecked")
	public List<Object[]> getTopActiveUsers() {
	    EntityManager entityManager = XJPA.getEntityManager();
	    List<Object[]> results = null;

	    try {
	        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("sp_GetTopActiveUsers");
	        query.execute();
	        results = (List<Object[]>) query.getResultList();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        entityManager.close();
	    }

	    return results;
	}

	
	@SuppressWarnings("unchecked")
	public List<Object[]> getAnimeStatistics() {
	    EntityManager entityManager = XJPA.getEntityManager();
	    List<Object[]> results = null;

	    try {
	        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("sp_GetAnimeStatistics");
	        query.execute();
	        results = (List<Object[]>) query.getResultList();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        entityManager.close();
	    }

	    return results;
	}
}
