<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div>
<h1>Joy Bundler Names</h1>

</div>
<form:form action="/register" method="POST" modelAttribute="newUser">
	<form:label path="userName">User Name: </form:label>
<form:errors path="userName" />
<form:input path="userName"/>

<form:label path="email">Email: </form:label>
<form:errors path="email"/>
<form:input path="email"/>

<form:label path="password">Password: </form:label>
<form:errors path="password"/>
<form:input path="password" type="password"/>

<form:label path="confirm">Confirm Password: </form:label>
<form:errors path="confirm"/>
<form:input path="confirm" type="password"/>



<button type="submit">Register</button>
</form:form>

<div>
<h1>Login</h1>
</div>
<form:form action="/login" method="POST" modelAttribute="newLogin">

<form:label path="email">Email: </form:label>
<form:errors path="email"/>
<form:input path="email"/>

<form:label path="password">Password: </form:label>
<form:errors path="password"/>
<form:input path="password" type="password"/>

<button type="submit">Login</button>
</form:form>

</body>
</html>