package com.ass.utils;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import org.apache.commons.beanutils.converters.DateTimeConverter;

public class XParam {
	static public String getString(String name, String defaultValue) {
		HttpServletRequest request = RRSharer.getRequest();
		String value = request.getParameter(name);
		if(value == null) {
			return defaultValue;
		}
		return value;
	}
	
	static public int getInt(String name, int defaultValue) {
		String value = getString(name, String.valueOf(defaultValue));
		return Integer.valueOf(value);
	}
	
	static public double getDouble(String name, int defaultValue) {
		String value = getString(name, String.valueOf(defaultValue));
		return Double.valueOf(value);
	}
	
	static public boolean getBoolean(String name, int defaultValue) {
		String value = getString(name, String.valueOf(defaultValue));
		return Boolean.valueOf(value);
	}
	
	static public Date getDate(String name, String pattern) {
		String value = getString(name, null);
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		try {
			return format.parse(value);
		} catch (Exception e) {
			return null;
		}
	}
	
	static public File getFile(String name, String folder) {
		HttpServletRequest request = RRSharer.getRequest();
		try {
			Part part = request.getPart(name);
			File dir = new File(request.getServletContext().getRealPath(folder));
			if(!dir.exists()) {
				dir.mkdirs();
			}
			File file = new File(dir, part.getSubmittedFileName());
			part.write(file.getAbsolutePath());
			return file;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	static public <T> T getBean(Class<T> beanClass) {
		DateTimeConverter dtc = new DateConverter(new Date());
		dtc.setPatterns(new String[] {"MM/dd/yyyy","yyyy-MM-dd"});
		ConvertUtils.register(dtc, Date.class);
		try {
			T bean = beanClass.getDeclaredConstructor().newInstance();
			HttpServletRequest request = RRSharer.getRequest();
			BeanUtils.populate(bean, request.getParameterMap());
			return bean;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
