package com.ass.dao;

import java.util.List;
import com.ass.entity.User;
import com.ass.utils.XJPA;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

public class UserDAO extends AbstractDAO<User, Integer> {

	public UserDAO() {
		super(User.class);
	}

	public User selectByEmail(String email) {
		String jpql = "SELECT u FROM User u WHERE u.email = ?1";
		List<User> users = selectByJPQL(jpql, 0, 1, email);

		if (!users.isEmpty()) {
			return users.get(0);
		} else {
			return null;
		}
	}

	public List<User> findUserHasLike() {
		EntityManager entityManager = XJPA.getEntityManager();
		String jpql = "SELECT u FROM User u WHERE u.likes IS NOT EMPTY";
		TypedQuery<User> query = entityManager.createQuery(jpql, User.class);
		return query.getResultList();
	}

	@Override
	public List<User> selectAll() {
		EntityManager entityManager = XJPA.getEntityManager();
		try {
			String jpql = "SELECT e FROM User e WHERE e.role = false";
			TypedQuery<User> query = entityManager.createQuery(jpql, User.class);
			return query.getResultList();
		} finally {
			if (entityManager != null && entityManager.isOpen()) {
				entityManager.close();
			}
		}
	}

	public void adminUpdate(User entity) {
		EntityManager entityManager = XJPA.getEntityManager();
		try {
			entityManager.getTransaction().begin();
			String jpql = "UPDATE User u SET u.active = :active WHERE u.id = :id";
			Query query = entityManager.createQuery(jpql);
			query.setParameter("active", entity.getActive());
			query.setParameter("id", entity.getId());
			query.executeUpdate();
			entityManager.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			entityManager.getTransaction().rollback();
		} finally {
			if (entityManager != null && entityManager.isOpen()) {
				entityManager.close();
			}
		}
	}
	
	public boolean updatePassword(String email, String newPassword) {
	    EntityManager entityManager = XJPA.getEntityManager();
	    try {
	        entityManager.getTransaction().begin();
	        String jpql = "UPDATE User u SET u.password = :password WHERE u.email = :email";
	        Query query = entityManager.createQuery(jpql);
	        query.setParameter("password", newPassword);
	        query.setParameter("email", email);
	        query.executeUpdate();
	        entityManager.getTransaction().commit();
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        entityManager.getTransaction().rollback();
	        return false;
	    } finally {
	        if (entityManager != null && entityManager.isOpen()) {
	            entityManager.close();
	        }
	    }
	}
	
	public boolean updateUsername(Integer id, String newUsername) {
	    EntityManager entityManager = XJPA.getEntityManager();
	    try {
	        entityManager.getTransaction().begin();
	        String jpql = "UPDATE User u SET u.username = :newUsername WHERE u.id = :id";
	        Query query = entityManager.createQuery(jpql);
	        query.setParameter("newUsername", newUsername);
	        query.setParameter("id", id);
	        query.executeUpdate();
	        entityManager.getTransaction().commit();
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        entityManager.getTransaction().rollback();
	        return false;
	    } finally {
	        if (entityManager != null && entityManager.isOpen()) {
	            entityManager.close();
	        }
	    }
	}


}
