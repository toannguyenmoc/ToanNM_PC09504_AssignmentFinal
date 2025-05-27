package com.ass.entity;

import java.util.Date;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(unique = true)
	private String email;
	private String username;
	private String password;
	
	@Column(name = "created_at")
	private Date created;
	private Boolean role;
	private Boolean active;
	
	@OneToMany(mappedBy = "user")
	private List<Favorite> favorites;
	
	@OneToMany(mappedBy = "user")
	private List<Comment> comments;
	
	@OneToMany(mappedBy = "user")
	private List<Rating> ratings;

	public User(Integer id, Boolean active) {
		super();
		this.id = id;
		this.active = active;
	}
	
	
}
