package com.ass.utils;

import javax.management.RuntimeErrorException;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class XJPA {
	private static EntityManagerFactory factory;

	static {
		try {
			factory = Persistence.createEntityManagerFactory("ToanNM_PC09504_AssignmentFinal");
		} catch (Exception e) {
			System.err.println("Lỗi khởi tạo EntityManagerFactory: " + e.getMessage());
			e.printStackTrace();
		}
	}

	public static EntityManager getEntityManager() {
		if (factory == null || !factory.isOpen()) {
			 throw new RuntimeErrorException(null);
		}
		return factory.createEntityManager();
	}

	public static void closeFactory() {
		if (factory != null && factory.isOpen()) {
			factory.close();
		}
	}
}
