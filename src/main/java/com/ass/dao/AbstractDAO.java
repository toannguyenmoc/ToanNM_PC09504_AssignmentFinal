package com.ass.dao;

import java.util.List;

import com.ass.utils.XJPA;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public abstract class AbstractDAO<E,K> {
	
	private Class<E> entityClass;

    // Constructor nhận vào class của entity
    public AbstractDAO(Class<E> entityClass) {
        this.entityClass = entityClass;
    }

    public Integer insert(E entity) {
    	EntityManager entityManager = XJPA.getEntityManager();
        try {
        	entityManager.getTransaction().begin();
            entityManager.persist(entity);
            entityManager.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            entityManager.getTransaction().rollback();
            return 0;
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    public Integer update(E entity) {
    	EntityManager entityManager = XJPA.getEntityManager();
        try {
        	entityManager.getTransaction().begin();
            entityManager.merge(entity);
            entityManager.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            entityManager.getTransaction().rollback();
            return 0;
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    public Integer delete(K id) {
    	EntityManager entityManager = XJPA.getEntityManager();
        try {
        	entityManager.getTransaction().begin();
            E entity = entityManager.find(entityClass, id);
            if (entity != null) {
                entityManager.remove(entity);
                entityManager.getTransaction().commit();
                return 1;
            }else {
            	return -1;
            }
        } catch (Exception e) {
            e.printStackTrace();
            entityManager.getTransaction().rollback();
            return 0;
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    public List<E> selectAll() {
    	EntityManager entityManager = XJPA.getEntityManager();
    	try {
			String jpql = "SELECT e FROM " + entityClass.getSimpleName() + " e";
	        TypedQuery<E> query = entityManager.createQuery(jpql, entityClass);
	        return query.getResultList();
		} finally {
			if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
		}   
    }
    
    public List<E> getPaginatonList(Integer pageNumber, Integer pageSize) {
    	EntityManager entityManager = XJPA.getEntityManager();
    	try {
			String jpql = "SELECT e FROM " + entityClass.getSimpleName() + " e ORDER BY id DESC";
	        TypedQuery<E> query = entityManager.createQuery(jpql, entityClass);
	        
	        query.setFirstResult((pageNumber-1) * pageSize);
	        query.setMaxResults(pageSize);
	        return query.getResultList();
		} finally {
			if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
		}   
    }
    
    public Integer getSize() {
    	EntityManager entityManager = XJPA.getEntityManager();
    	try {
			String jpql = "SELECT COUNT(e) FROM " + entityClass.getSimpleName() + " e";
	        TypedQuery<E> query = entityManager.createQuery(jpql, entityClass);
	        
	        return Integer.parseInt(query.getSingleResult().toString());
		} finally {
			if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
		} 
    }

    public E selectByID(K id) {
    	EntityManager entityManager = XJPA.getEntityManager();
    	return entityManager.find(entityClass, id);	
    }

    public List<E> selectByJPQL(String jpql, int firstResult, int maxResults, Object... args) {
        EntityManager entityManager = XJPA.getEntityManager();
        try {
            TypedQuery<E> query = entityManager.createQuery(jpql, entityClass);

            for (int i = 0; i < args.length; i++) {
                query.setParameter(i + 1, args[i]);
            }

            if (firstResult >= 0 && maxResults > 0) {
                query.setFirstResult(firstResult);
                query.setMaxResults(maxResults);
            }

            return query.getResultList();
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }
    
    // hàm tìm kiếm
    public List<E> searchByParam(String columnName, String value, int pageNumber, int pageSize) {
        EntityManager entityManager = XJPA.getEntityManager();
        if (value == null || value.trim().isEmpty()) {
            return List.of();
        }

        if (pageNumber < 1) {
            pageNumber = 1;
        }

        try {
            // Xử lý chuỗi tìm kiếm để hỗ trợ tìm kiếm tương đối
            String searchValue = "%" + String.join("%", value.trim().toLowerCase().split("\\s+")) + "%";

            String jpql = "SELECT e FROM " + entityClass.getSimpleName() 
                        + " e WHERE LOWER(e." + columnName + ") LIKE :searchValue"
                        + " ORDER BY e.id DESC";

            TypedQuery<E> query = entityManager.createQuery(jpql, entityClass);
            query.setParameter("searchValue", searchValue);

            query.setFirstResult((pageNumber - 1) * pageSize);
            query.setMaxResults(pageSize);

            return query.getResultList();
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }
    
    // lấy kích thước list tìm kiếm
    public int getSizeSearch(String columnName, String value) {
        EntityManager entityManager = XJPA.getEntityManager();
        if (value == null || value.trim().isEmpty()) {
            return 0;
        }

        try {
            String searchValue = "%" + String.join("%", value.trim().toLowerCase().split("\\s+")) + "%";

            String jpql = "SELECT COUNT(e) FROM " + entityClass.getSimpleName() 
                        + " e WHERE LOWER(e." + columnName + ") LIKE :searchValue";

            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            query.setParameter("searchValue", searchValue);

            return query.getSingleResult().intValue();
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }
    
    public E selectByParam(String columnName, Object value) {
        EntityManager entityManager = XJPA.getEntityManager();
        try {
            String jpql = "SELECT e FROM " + entityClass.getSimpleName() + " e WHERE e." + columnName + " = :value";
            TypedQuery<E> query = entityManager.createQuery(jpql, entityClass);
            query.setParameter("value", value);
            return query.getResultList().get(0);
        } finally {
            entityManager.close();
        }
    }

 
}
