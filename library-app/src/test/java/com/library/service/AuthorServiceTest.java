package com.library.service;

import com.library.entity.Author;
import com.library.repository.AuthorRepository;
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
public class AuthorServiceTest {

    @Mock
    private AuthorRepository authorRepository;

    @InjectMocks
    private AuthorService authorService;

    private Author author1;
    private Author author2;

    @BeforeEach
    void setUp() {
        author1 = new Author("John Doe", "john@example.com");
        author1.setId(1L);
        author2 = new Author("Jane Doe", "jane@example.com");
        author2.setId(2L);
    }

    @Test
    void testGetAllAuthors() {
        when(authorRepository.findAll()).thenReturn(Arrays.asList(author1, author2));
        List<Author> authors = authorService.getAllAuthors();
        assertEquals(2, authors.size());
        verify(authorRepository, times(1)).findAll();
    }

    @Test
    void testGetAuthorById() {
        when(authorRepository.findById(1L)).thenReturn(Optional.of(author1));
        Optional<Author> result = authorService.getAuthorById(1L);
        assertTrue(result.isPresent());
        assertEquals("John Doe", result.get().getName());
        verify(authorRepository, times(1)).findById(1L);
    }

    @Test
    void testSaveAuthor() {
        when(authorRepository.save(author1)).thenReturn(author1);
        Author result = authorService.saveAuthor(author1);
        assertEquals("John Doe", result.getName());
        verify(authorRepository, times(1)).save(author1);
    }
}
