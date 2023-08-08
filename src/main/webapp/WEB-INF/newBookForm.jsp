<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Book Share</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/style.css">
</head>
<body>
	<div class="container">
		<h1>Add a Book to Your Shelf</h1>
		<a href="/books">back to the shelves</a>
		
		<form:form action="/books" method="post" modelAttribute="book">
			<div class="form-group">
				<form:label path="title">Title</form:label>
				<form:errors class="text-danger" path="title" />
				<form:input path="title" class="form-control" />
			</div>
			<div class="form-group">
				<form:label path="authorName">Author</form:label>
				<form:errors class="text-danger" path="authorName" />
				<form:input path="authorName" class="form-control" />
			</div>
			<div class="form-group">
				<form:label path="thoughts">My thoughts</form:label>
				<form:errors class="text-danger" path="thoughts" />
				<form:textarea path="thoughts" class="form-control" />
			</div>
			<button>Submit</button>
		</form:form>
	</div>
</body>
</html>