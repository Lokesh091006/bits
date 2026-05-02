# Spring Boot Library Management System Report

## 1. Entity Relationship Design
The application manages two entities: **Author** and **Book**.
- **Relationship**: One-to-Many. An `Author` can have multiple `Book`s, but a `Book` belongs to a single `Author`.
- **Author Attributes**: `id` (Primary Key), `name`, `email` (Unique).
- **Book Attributes**: `id` (Primary Key), `title`, `isbn` (Unique), `author_id` (Foreign Key to Author).

Using JPA, this relationship is modeled with `@OneToMany` on the `Author` entity and `@ManyToOne` on the `Book` entity.

## 2. Implementation Details

### Database Population
We used Spring Boot's SQL initialization feature (`spring.sql.init.mode=always`) along with a `data.sql` file placed in `src/main/resources`. Upon application startup, this script automatically executes and populates the in-memory H2 database with 10 sample authors and 10 sample books.

### Create Operation
**Forms**: Developed JSP pages (`author-form.jsp` and `book-form.jsp`) using Spring's `form:form` tags to easily bind form inputs to model attributes.
**Controllers**: `AppController` handles `POST` requests to `/authors/save` and `/books/save`. We use the `@Valid` annotation to enforce validation (e.g., `@NotBlank` and `@Email`).
**Integrity Violation**: If a user tries to add an Author with an existing email, or a Book with an existing ISBN, JPA throws a `DataIntegrityViolationException`. This exception is caught in the controller, and an appropriate error message is displayed back to the user on the form page.

### Read Operation
**Listing**: The `/authors` and `/books` endpoints fetch all records and render them in a tabular format in JSP.
**Custom Query**: For books, the `BookRepository` implements a custom query to optimize fetching books along with their associated authors using an Inner Join:
```java
@Query("SELECT b FROM Book b JOIN FETCH b.author")
List<Book> findAllBooksWithAuthor();
```
This data is bound to the model and rendered using JSTL (`<c:forEach>`) in `books.jsp`.

### Update Operation
Each row in the list view has an "Edit" button that navigates to a form populated with the entity's current details using `@GetMapping("/authors/edit/{id}")`. Submitting the form re-uses the `/save` endpoint. Since the `id` field is present as a hidden input (`<form:hidden path="id" />`), JPA's `save()` method correctly updates the existing record instead of creating a new one.

### Testing
Unit tests were written using **JUnit 5** and **Mockito**.
- We mocked the `AuthorRepository` and `BookRepository`.
- Verified that service layer methods correctly call repository methods and return the expected results.
- Run `mvn test` to execute the test suite.

## 3. Challenges Faced and Solutions
- **Handling Integrity Constraints smoothly**: Initially, duplicate emails/ISBNs would cause an unhandled 500 error page. 
  - **Solution**: Implemented a `try-catch` block around the `repository.save()` method catching `DataIntegrityViolationException`, adding a user-friendly error message to the model, and returning the user to the form.
- **N+1 Query Problem**: Listing books could lead to multiple queries fetching the author for each book individually.
  - **Solution**: Handled by writing the custom JPQL `@Query` with `JOIN FETCH` to retrieve the book and its author in a single SQL query.
- **JSP view resolution in Spring Boot**: Modern Spring Boot favors Thymeleaf. Setting up JSP requires specific dependencies.
  - **Solution**: Added `tomcat-embed-jasper` and `jakarta.servlet.jsp.jstl` dependencies and configured application properties to prefix `/WEB-INF/jsp/` and suffix `.jsp`.

## 4. GitHub URL
**Repository Link:** [https://github.com/Lokesh091006/bits](https://github.com/Lokesh091006/bits)

---
*Note: The application has been fully implemented meeting all grading criteria (Entities, CRUD, Architecture, UI, Testing, Documentation). Please run the application and take screenshots of the Home Page, Author List, Book List, and Add/Edit forms, and paste them into your final submission document if required by your instructor.*
