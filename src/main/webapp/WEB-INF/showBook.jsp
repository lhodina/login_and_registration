<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Read Share</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/style.css">
</head>
<body>
	<div class="container">
		<div class="header">
			<h1>${book.title }</h1>
			<a href="/books">back to the shelves</a>
		</div>
		<p class="summary"><span class="user">
		<c:choose>
			<c:when test="${book.user.id == currentUserId}">
				<c:out value="You" />
			</c:when>
			<c:otherwise>
				<c:out value="${book.user.userName}"></c:out>
			</c:otherwise>
		</c:choose>
		</span> read <span class="title"><c:out value="${book.title}"></c:out></span> by <span class="author"><c:out value="${book.authorName}"></c:out></span>.</p>
		<p class="summary">Here are
		<c:choose>
			<c:when test="${book.user.id == currentUserId}">
				<c:out value="your" />
			</c:when>
			<c:otherwise>
				<c:out value="${book.user.userName}'s"></c:out>
			</c:otherwise>
		</c:choose>
		 thoughts:</p>
		<div class="thoughts">
			<p>"<c:out value="${book.thoughts}"></c:out>"</p>
		</div>
		<c:if test = "${book.user.id == currentUserId}">
			<div>
				<a class="btn btn-light border" href="/books/${bookId}/edit">edit</a>
				<form action="/books/${bookId }/delete" method="post">
					<input type="hidden" name="_method" value="delete">
					<button class="btn btn-light border">delete</button>
				</form>
			</div>
		</c:if>
	</div>
</body>
</html>