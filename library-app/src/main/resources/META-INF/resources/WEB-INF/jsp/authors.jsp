<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Authors List</title>
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
        <h2>Authors</h2>
        <a href="/authors/new" class="btn" style="margin-bottom: 15px;">Add New Author</a>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="author" items="${authors}">
                    <tr>
                        <td>${author.id}</td>
                        <td>${author.name}</td>
                        <td>${author.email}</td>
                        <td>
                            <a href="/authors/edit/${author.id}" class="btn" style="background: #f39c12;">Edit</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty authors}">
                    <tr>
                        <td colspan="4" style="text-align: center;">No authors found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
