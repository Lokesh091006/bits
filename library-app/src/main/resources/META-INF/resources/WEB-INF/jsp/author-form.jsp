<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${author.id != null ? 'Edit Author' : 'Add Author'}</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <header>
        <h1>Library Management System</h1>
    </header>
    <nav>
        <a href="/">Home</a>
        <a href="/authors">Manage Authors</a>
        <a href="/books">Manage Books</a>
    </nav>
    <div class="container">
        <h2>${author.id != null ? 'Edit Author' : 'Add New Author'}</h2>
        
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <form:form action="/authors/save" modelAttribute="author" method="post">
            <form:hidden path="id" />
            
            <div class="form-group">
                <label for="name">Name:</label>
                <form:input path="name" id="name" />
                <form:errors path="name" cssClass="error-text" />
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <form:input path="email" id="email" type="email" />
                <form:errors path="email" cssClass="error-text" />
            </div>
            
            <button type="submit" class="btn">${author.id != null ? 'Update Author' : 'Save Author'}</button>
            <a href="/authors" class="btn" style="background: #95a5a6; margin-left: 10px;">Cancel</a>
        </form:form>
    </div>
</body>
</html>
