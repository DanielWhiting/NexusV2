package com.meta.nexus.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.meta.nexus.models.Share;
import com.meta.nexus.models.User;
import com.meta.nexus.repositories.ShareRepository;
import com.meta.nexus.repositories.UserRepository;

@Service
public class ShareService {
	@Autowired
	private ShareRepository shareRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private UserService userService;
	
//		==========all posts============
	public List<Share> allPosts(){
		return shareRepo.findAll();
	}

//	=============get all users================
	
	public List<User> allUsers(){
		return userRepo.findAll();
	}
	
//	==========create post============
	
	public Share createPost(Share share) {
		share.setCommentCount(0);
		share.setVote(0);
		return shareRepo.save(share);
	}
	
//	===========get one share================================
	
	public Share oneShare(Long Id) {
		Optional<Share> singleShare = shareRepo.findById(Id);
		if(singleShare.isPresent()) {
			return singleShare.get();
		} else {
			return null;
		}
	}
	
//	==============get like and comment =================
	public void receiveVote(Long shareId, Long userId) {
		Share share = this.oneShare(shareId);	
		User user = userService.oneUser(userId);
		share.getReceivers().add(user);
		share.setVote(share.getVote()+1);
		shareRepo.save(share);
		}

}
