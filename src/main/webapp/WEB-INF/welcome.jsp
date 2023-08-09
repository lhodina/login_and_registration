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
					<th scope="col">Owner</th>
					<th scope="col">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${allBooks }">
					<c:if test = "${book.borrower.id == null }">
						<tr>
							<td>${book.id }</td>
							<td><a href="books/${book.id }">${book.title }</a></td>
							<td>${book.authorName }</td>
							<td>${book.user.userName }</td>
							<c:choose>
								<c:when test = "${book.user.id == currentUserId}">
									<td>
										<a href="/books/${book.id}/edit">edit</a>
										<a href="/books/${book.id }/delete">delete</a>
									</td>
								</c:when>
								<c:otherwise>
									<td>
										<a href="/books/${book.id}/borrow">borrow</a>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<br>
		<p>Books I'm borrowing:</p>
		<table class="table table-striped table-bordered table-hover thead-dark">
			<thead class="table-light">
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Title</th>
					<th scope="col">Author Name</th>
					<th scope="col">Owner</th>
					<th scope="col">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${allBooks }">
					<c:if test = "${currentUserId == book.borrower.id }">
						<tr>
							<td>${book.id }</td>
							<td><a href="books/${book.id }">${book.title }</a></td>
							<td>${book.authorName }</td>
							<td>${book.user.userName }</td>
							<td><a href="/books/${book.id}/return">return</a></td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>