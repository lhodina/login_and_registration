<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Dashboard</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/style.css">
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="header-left">
				<h1>Welcome, ${currentUser.userName }</h1>
				<p>Books from everyone's shelves:</p>
			</div>
			<div class="header-right">
				<p><a href="/logout">logout</a></p>
				<p><a href="/books/new">+ Add a book to my shelf</a></p>
			</div>
		</div>
		<table class="table table-striped table-bordered table-hover thead-dark">
			<thead class="table-light">
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Title</th>
					<th scope="col">Author Name</th>
					<th scope="col">Posted By</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${allBooks }">
					<tr>
						<td>${book.id }</td>
						<td><a href="books/${book.id }">${book.title }</a></td>
						<td>${book.authorName }</td>
						<td>${book.user.userName }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>