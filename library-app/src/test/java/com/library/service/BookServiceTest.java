package com.library.service;

import com.library.entity.Author;
import com.library.entity.Book;
import com.library.repository.BookRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class BookServiceTest {

    @Mock
    private BookRepository bookRepository;

    @InjectMocks
    private BookService bookService;

    private Book book1;
    private Book book2;

    @BeforeEach
    void setUp() {
        Author author = new Author("John Doe", "john@example.com");
        author.setId(1L);

        book1 = new Book("Book 1", "12345", author);
        book1.setId(1L);
        book2 = new Book("Book 2", "67890", author);
        book2.setId(2L);
    }

    @Test
    void testGetAllBooksWithAuthors() {
        when(bookRepository.findAllBooksWithAuthor()).thenReturn(Arrays.asList(book1, book2));
        List<Book> books = bookService.getAllBooksWithAuthors();
        assertEquals(2, books.size());
        verify(bookRepository, times(1)).findAllBooksWithAuthor();
    }

    @Test
    void testGetBookById() {
        when(bookRepository.findById(1L)).thenReturn(Optional.of(book1));
        Optional<Book> result = bookService.getBookById(1L);
        assertTrue(result.isPresent());
        assertEquals("Book 1", result.get().getTitle());
        verify(bookRepository, times(1)).findById(1L);
    }

    @Test
    void testSaveBook() {
        when(bookRepository.save(book1)).thenReturn(book1);
        Book result = bookService.saveBook(book1);
        assertEquals("Book 1", result.getTitle());
        verify(bookRepository, times(1)).save(book1);
    }
}
