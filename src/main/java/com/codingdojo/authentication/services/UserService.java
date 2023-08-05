package com.codingdojo.authentication.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.codingdojo.authentication.models.LoginUser;
import com.codingdojo.authentication.models.User;
import com.codingdojo.authentication.repositories.UserRepository;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepo;

    public User register(User newUser, BindingResult result) {
    	Optional<User> potentialUser = userRepo.findByEmail(newUser.getEmail());
        if(potentialUser.isPresent()) {
        	result.rejectValue("email", "exists", "Email already exists");
        } 
    	
    	if(!newUser.getPassword().equals(newUser.getConfirm())) {
    		result.rejectValue("confirm", "Matches", "confirm password must match password");
    	}
        
    	if (result.hasErrors()) {
    		return null;
    	}
    	
    	String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
    	newUser.setPassword(hashed);
    	newUser.setConfirm(hashed);
    	userRepo.save(newUser);
    	return newUser;
    }
    
    public User login(LoginUser newLoginObject, BindingResult result) {
    	Optional<User> potentialUser = userRepo.findByEmail(newLoginObject.getEmail());
        if(!potentialUser.isPresent()) {
        	result.rejectValue("email", "exists", "Email not found");
        	return null;
        } 
        
        User user = potentialUser.get();
        if(!BCrypt.checkpw(newLoginObject.getPassword(), user.getPassword())) {
        	result.rejectValue("password", "Matches", "Invalid password");
        	return null;
        }
        
    	if (result.hasErrors()) {
    		return null;
    	}
    	
    	return user;
    }
    
    public User find(Long id) {
    	Optional<User> potentialUser = userRepo.findById(id);
    	if (potentialUser.isPresent()) {
    		User user = potentialUser.get();
    		return user;
    	}
    	return null;
    }
}
