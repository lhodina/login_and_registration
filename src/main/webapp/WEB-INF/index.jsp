<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Login and Registration</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/style.css">
</head>
<body>
	<h1>Welcome</h1>
	<div class="container">
		<p class="text-danger"><c:out value="${accessDenied }" /></p>
		<form:form action="/register" method="post" modelAttribute="newUser">
			<h2>Register</h2>
			<div class="form-group">
				<form:label path="userName">User Name</form:label>
				<form:errors class="text-danger" path="userName" />
				<form:input path="userName" class="form-control" />
			</div>
			<div class="form-group">
				<form:label path="email">Email</form:label>
				<form:errors class="text-danger" path="email" />
				<form:input path="email" class="form-control" />
			</div>
			<div class="form-group">
				<form:label path="password">Password</form:label>
				<form:errors class="text-danger" path="password" />
				<form:input type="password" path="password" class="form-control" />
			</div>
			<div class="form-group">
				<form:label path="confirm">Confirm Password</form:label>
				<form:errors class="text-danger" path="confirm" />
				<form:input type="password" path="confirm" class="form-control" />
			</div>
			<button class="btn btn-primary">Submit</button>
		</form:form>
		
		<form:form action="/login" method="post" modelAttribute="newLogin">
			<h2>Login</h2>
			<div class="form-group">
				<form:label path="email">Email</form:label>
				<form:errors class="text-danger" path="email" />
				<form:input path="email" class="form-control" />
			</div>
			<div class="form-group">
				<form:label path="password">Password</form:label>
				<form:errors class="text-danger" path="password" /> 
				<form:input path="password" class="form-control" />
			</div>
			<button class="btn btn-primary">Submit</button>
		</form:form>
	</div>

</body>
</html>