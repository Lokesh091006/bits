<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Management System</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <header>
        <h1>Welcome to the Library Management System</h1>
    </header>
    <nav>
        <a href="/">Home</a>
        <a href="/authors">Manage Authors</a>
        <a href="/books">Manage Books</a>
    </nav>
    <div class="container">
        <h2>Dashboard</h2>
        <p>This system allows you to manage Authors and Books. Use the navigation links above to view, create, or update records.</p>
        
        <div style="display: flex; gap: 20px; margin-top: 30px;">
            <div style="flex: 1; padding: 20px; background: #ecf0f1; border-radius: 8px; text-align: center;">
                <h3>Authors</h3>
                <p>Manage author profiles.</p>
                <a href="/authors" class="btn">View Authors</a>
            </div>
            <div style="flex: 1; padding: 20px; background: #ecf0f1; border-radius: 8px; text-align: center;">
                <h3>Books</h3>
                <p>Manage books catalog.</p>
                <a href="/books" class="btn">View Books</a>
            </div>
        </div>
    </div>
</body>
</html>
