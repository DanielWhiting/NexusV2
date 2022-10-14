package com.meta.nexus.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.meta.nexus.models.Share;
import com.meta.nexus.services.ShareService;
import com.meta.nexus.services.UserService;

@Controller
public class ShareController {
@Autowired
private UserService userService;
@Autowired
private ShareService shareService;

@GetMapping("/home")
public String renderHome(HttpSession session, Model model,  Share share) {
	if(session.getAttribute("userId")==null) {
		return "redirect:/logout";
	}
	model.addAttribute("newShare", new Share());
	Long userId = (Long) session.getAttribute("userId");
	model.addAttribute("loggedInUser", userService.oneUser(userId));
	
	List<Share> allShares = shareService.allPosts();
	model.addAttribute("thePosts", allShares);
	
	return "dashboard.jsp";
	
}

@PostMapping("/share/post/process")
public String newPost(@Valid @ModelAttribute("newShare") Share share,
		BindingResult result, Model model) {
	
	if(result.hasErrors()) {
		return "create.jsp";
	} else {
		shareService.createPost(share);
		return "redirect:/home";
	}
}
//===============create post===================

//@GetMapping("/shares/new")
//public String renderNewShare(Model model) {
//	model.addAttribute("newShare", new Share());
//	return "create.jsp";
//}

//====================Many to Many==============================
@PutMapping("/shares/{id}/receive")
public String receiveVote(@PathVariable("id")Long id, HttpSession session) {
	Long userId = (Long) session.getAttribute("userId");
	shareService.receiveVote(id, userId);
	return "redirect:/home";
}

}
