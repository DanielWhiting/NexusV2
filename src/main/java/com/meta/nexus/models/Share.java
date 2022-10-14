package com.meta.nexus.models;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="shares")
public class Share {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotNull
	@Size(min = 3, max = 200)
	private String theShare;
	

	private Integer vote;
	
	private Integer commentCount;
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="share_id")
	private User user;
	
	@Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;
	
//	this is like doing the default function in MySQL to create date and update date
	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}
	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}
	
	@ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "received_shares", 
        joinColumns = @JoinColumn(name = "share_id"), 
        inverseJoinColumns = @JoinColumn(name = "user_id")
    )
   private List<User> receivers;
	
	@OneToMany(mappedBy = "share")
	Set<Comment> comments;
	

	
	public Share(){}
	
	
	public Set<Comment> getComments() {
		return comments;
	}
	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTheShare() {
		return theShare;
	}
	public void setTheShare(String theShare) {
		this.theShare = theShare;
	}
	public Integer getVote() {
		return vote;
	}
	public void setVote(Integer vote) {
		this.vote = vote;
	}
	public Integer getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(Integer commentCount) {
		this.commentCount = commentCount;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	public List<User> getReceivers() {
		return receivers;
	}
	public void setReceivers(List<User> receivers) {
		this.receivers = receivers;
	}

	
}
