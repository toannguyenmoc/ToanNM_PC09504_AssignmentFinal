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
@Table(name="Animes")
public class Anime {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	private String title;
	private String slug;
	private String description;
	private int duration;
	private String genre;
	private String author;
	
	@Column(name="release_date")
	private Date releaseDate;
	
	@Column(name="total_episodes")
	private int totalEpisodes;
	
	private Boolean status;
	private String poster;
	private int views;
	
	@Column(name="avg_rating")
	private float avgRating;
	
	@OneToMany(mappedBy = "anime")
	private List<Episode> episodes;
	
	@OneToMany(mappedBy = "anime")
	private List<Favorite> favorites;
	
	@OneToMany(mappedBy = "anime")
	private List<Comment> comments;
	
	@OneToMany(mappedBy = "anime")
	private List<Rating> ratings;
}
