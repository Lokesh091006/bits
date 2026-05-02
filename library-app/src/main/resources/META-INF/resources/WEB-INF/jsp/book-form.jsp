<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${book.id != null ? 'Edit Book' : 'Add Book'}</title>
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
        <h2>${book.id != null ? 'Edit Book' : 'Add New Book'}</h2>
        
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <form:form action="/books/save" modelAttribute="book" method="post">
            <form:hidden path="id" />
            
            <div class="form-group">
                <label for="title">Title:</label>
                <form:input path="title" id="title" />
                <form:errors path="title" cssClass="error-text" />
            </div>
            
            <div class="form-group">
                <label for="isbn">ISBN:</label>
                <form:input path="isbn" id="isbn" />
                <form:errors path="isbn" cssClass="error-text" />
            </div>
            
            <div class="form-group">
                <label for="author">Author:</label>
                <form:select path="author.id" id="author">
                    <form:option value="" label="-- Select Author --"/>
                    <form:options items="${authors}" itemValue="id" itemLabel="name" />
                </form:select>
                <form:errors path="author" cssClass="error-text" />
            </div>
            
            <button type="submit" class="btn">${book.id != null ? 'Update Book' : 'Save Book'}</button>
            <a href="/books" class="btn" style="background: #95a5a6; margin-left: 10px;">Cancel</a>
        </form:form>
    </div>
</body>
</html>
