package com.codingdojo.authentication.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.authentication.models.Book;
import com.codingdojo.authentication.models.LoginUser;
import com.codingdojo.authentication.models.User;
import com.codingdojo.authentication.services.BookService;
import com.codingdojo.authentication.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomeController {
     @Autowired
     private UserService userServ;
     
  	@Autowired
  	BookService bookServ;
     	
	@GetMapping("/")
	public String index(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "index.jsp";
	}
	
	@PostMapping("/register")
	public String register(
			@Valid @ModelAttribute("newUser") User newUser,
			BindingResult result, 
			Model model, 
			HttpSession session) {
		userServ.register(newUser, result);
		if(result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "index.jsp";
		} else {
			session.setAttribute("currentUserId", newUser.getId());
			return "redirect:/books";
		}
	}
	
	@PostMapping("/login")
	public String login(
			@Valid @ModelAttribute("newLogin") LoginUser newLogin,
			BindingResult result,
			Model model,
			HttpSession session) {
        User user = userServ.login(newLogin, result);
		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "index.jsp";
		}

		session.setAttribute("currentUserId", user.getId());
		return "redirect:/books";
	}
	
	@GetMapping("/books")
	public String welcome(Model model, HttpSession session, RedirectAttributes flash) {
		if (session.getAttribute("currentUserId") == null) {
			flash.addFlashAttribute("accessDenied", "You must be logged in to view books");
			return "redirect:/";
		}
		
		User currentUser = userServ.find((Long) session.getAttribute("currentUserId"));
		List<Book> allBooks = bookServ.allBooks();
		
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("allBooks", allBooks);
		return "welcome.jsp";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}


	@GetMapping("/books/new")
	public String newBookForm(
			@ModelAttribute("book") Book book,
			HttpSession session,
			RedirectAttributes flash) {
		if (session.getAttribute("currentUserId") == null) {
			flash.addFlashAttribute("accessDenied", "You must be logged in to add a book");
			return "redirect:/";
		}
		return "newBookForm.jsp";
	}
	
	@PostMapping("/books")
	public String createBook(
			@Valid @ModelAttribute("book") Book book,
			BindingResult result,
			HttpSession session) {
		if (result.hasErrors()) {
			return "newBookForm.jsp";
		} else {
			Long userId = (Long) session.getAttribute("currentUserId");
			User user = userServ.find(userId);
			book.setUser(user);
			bookServ.createBook(book);
			return "redirect:/books";
		}
	}
	
	@GetMapping("/books/{bookId}")
	public String showBook(Model model, @PathVariable("bookId") Long bookId) {
		Book book = bookServ.findBook(bookId);
		model.addAttribute(book);
		return "showBook.jsp";
	}
	
	@GetMapping("/books/{id}/edit")
	public String getEditForm(@PathVariable("id") Long id, Model model) {
		Book book = bookServ.findBook(id);
		model.addAttribute("book", book);
		return "editBook.jsp";
	}
	
	@RequestMapping(value="/books/{id}", method=RequestMethod.PUT)
	public String update(@Valid @ModelAttribute("book") Book book, 
			BindingResult result, 
			Model model, 
			HttpSession session) {
		if (result.hasErrors()) {
			model.addAttribute("book", book);
			return "editBook.jsp";
		} else {
			Long userId = (Long) session.getAttribute("currentUserId");
			User user = userServ.find(userId);
			book.setUser(user);
			bookServ.updateBook(book);
			return "redirect:/books";
		}
	}
	
	@DeleteMapping("/books/{id}/delete")
	public String destroy(@PathVariable("id") Long id) {
		bookServ.deleteBook(id);
		return "redirect:/books";
	}
}
