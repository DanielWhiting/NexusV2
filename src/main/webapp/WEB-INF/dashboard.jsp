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
<h1>Welcome, ${ userName }</h1>
<a href="/logout">logout</a>
<p>Share a message</p>
</div>
<form:form action="/share/post/process" method="POST" modelAttribute="newShare">

<div>
	<form:label path="theShare">Tweet: </form:label>
	<form:input path="theShare"/>
	<form:errors path="theShare"/>
</div>


<form:hidden path="user" value="${ userId }" />

<button type="submit">Share Message</button>

</form:form>
<div>
<br>

</div>

	<c:forEach var="shares" items="${ thePosts }">
<div>
		<h2> <c:out value="${ shares.user.userName }"/> Posted:
		<c:out value="${ shares.theShare }"/></h2>
		<p>Likes: <c:out value="${ shares.vote }"/></p>	
		<p>Comments: <c:out value="${ shares.commentCount }"/></p>	
</div>
		
		
<c:choose>
	<c:when test="${shares.receivers.contains(loggedInUser)}">
	</c:when>
	
<c:otherwise>
 	<form method="POST" action="/shares/${shares.id }/receive">
 	<input type="hidden" name="_method" value="put" />
	 <button type="submit">Like</button>
 </form>
 

 
 
</c:otherwise>
</c:choose>	
	</c:forEach>

</body>
</html>