package com.ass.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Episodes")
public class Episode {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name="episode_number")
	private int episodeNumber;
	
	@Column(name="video_url")
	private String videoUrl;
	
	@Column(name="release_date")
	private Date releaseDate;
	
	@ManyToOne
	@JoinColumn(name="anime_id")
	private Anime anime;

}
