<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Books List</title>
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
        <h2>Books</h2>
        <a href="/books/new" class="btn" style="margin-bottom: 15px;">Add New Book</a>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>ISBN</th>
                    <th>Author</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>${book.id}</td>
                        <td>${book.title}</td>
                        <td>${book.isbn}</td>
                        <td>${book.author.name}</td>
                        <td>
                            <a href="/books/edit/${book.id}" class="btn" style="background: #f39c12;">Edit</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty books}">
                    <tr>
                        <td colspan="5" style="text-align: center;">No books found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
