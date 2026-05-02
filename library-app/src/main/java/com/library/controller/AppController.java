package com.library.controller;

import com.library.entity.Author;
import com.library.entity.Book;
import com.library.service.AuthorService;
import com.library.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;

@Controller
public class AppController {

    @Autowired
    private AuthorService authorService;

    @Autowired
    private BookService bookService;

    @GetMapping("/")
    public String index() {
        return "index";
    }

    // --- Author Operations ---

    @GetMapping("/authors")
    public String listAuthors(Model model) {
        model.addAttribute("authors", authorService.getAllAuthors());
        return "authors";
    }

    @GetMapping("/authors/new")
    public String newAuthorForm(Model model) {
        model.addAttribute("author", new Author());
        return "author-form";
    }

    @PostMapping("/authors/save")
    public String saveAuthor(@Valid @ModelAttribute("author") Author author, BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "author-form";
        }
        try {
            authorService.saveAuthor(author);
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("error", "An author with this email already exists or another integrity violation occurred.");
            return "author-form";
        }
        return "redirect:/authors";
    }

    @GetMapping("/authors/edit/{id}")
    public String editAuthorForm(@PathVariable("id") Long id, Model model) {
        Author author = authorService.getAuthorById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid author Id:" + id));
        model.addAttribute("author", author);
        return "author-form";
    }

    // --- Book Operations ---

    @GetMapping("/books")
    public String listBooks(Model model) {
        // Read operation with inner join fetching authors
        model.addAttribute("books", bookService.getAllBooksWithAuthors());
        return "books";
    }

    @GetMapping("/books/new")
    public String newBookForm(Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("authors", authorService.getAllAuthors());
        return "book-form";
    }

    @PostMapping("/books/save")
    public String saveBook(@Valid @ModelAttribute("book") Book book, BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("authors", authorService.getAllAuthors());
            return "book-form";
        }
        try {
            bookService.saveBook(book);
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("authors", authorService.getAllAuthors());
            model.addAttribute("error", "A book with this ISBN already exists or another integrity violation occurred.");
            return "book-form";
        }
        return "redirect:/books";
    }

    @GetMapping("/books/edit/{id}")
    public String editBookForm(@PathVariable("id") Long id, Model model) {
        Book book = bookService.getBookById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));
        model.addAttribute("book", book);
        model.addAttribute("authors", authorService.getAllAuthors());
        return "book-form";
    }
}
