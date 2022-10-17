<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>

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
	
	<%-- ================= Add a post  ================================= --%>
	<form:form action="/share/post/process" method="POST"
		modelAttribute="newShare">
		<div>
			<form:label path="theShare">Message: </form:label>
			<form:input path="theShare" />
			<form:errors path="theShare" />
		</div>
		<form:hidden path="user" value="${ userId }" />
		<button type="submit">Share Message</button>
	</form:form>
	<div>
		<br>

	</div>
	
	
<%-- ================= Show all posts, dates, likes, comment count and names  ================================= --%>
	<c:forEach var="shares" items="${ thePosts }">
		<div>
			<h2>
				<c:out value="${ shares.user.userName }" />
				Posted:
				<c:out value="${ shares.theShare }" />
			</h2>
			<p>
				Posted on:
				<fmt:formatDate type="both" dateStyle="short" timeStyle="short"
					value="${shares.createdAt}" />
			</p>
			<p>
				Likes:
				<c:out value="${ shares.vote }" />
			</p>
			<p>
				Comments:
				<c:out value="${ shares.commentCount }" />
			</p>

		</div>

<%-- ================= Submit a Comment  ================================= --%>
		<form:form action="/share/comment/process" method="POST"
			modelAttribute="newcom">
			<div>
				<form:label path="comment">Comment: </form:label>
				<form:input path="comment" />
				<form:hidden path="user" value="${ userId }" />
				<form:hidden path="share" value="${ shares.id }" />

			</div>
				<button type="submit">Share Comment</button>
		</form:form>

<%-- ================= Loop to display comments matched with share Id ================================= --%>
				<c:forEach var="coms" items="${ theComments }">
					<c:if test="${coms.share.id.equals(shares.id) }">
						<p>
							<c:out value="${ coms.user.userName}" />
							Said:
							<c:out value="${ coms.comment }" />
						</p>
					</c:if>
				</c:forEach>

<%-- ================= Add Like  ================================= --%>

		<c:choose>
			<c:when test="${shares.receivers.contains(loggedInUser)}">
				<form method="POST" action="/shares/${shares.id }/unlike">
					<input type="hidden" name="_method" value="put" />
					<button type="submit">Unlike</button>
				</form>

			</c:when>
<%-- ================= Remove Like ================================= --%>
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