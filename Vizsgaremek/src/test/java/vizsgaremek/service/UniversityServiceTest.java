package vizsgaremek.service;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import vizsgaremek.entity.University;
import vizsgaremek.repository.UniversityRepository;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UniversityServiceTest {

    @Mock
    private UniversityRepository universityRepository;

    @InjectMocks
    private UniversityService universityService;

    @Test
    void addUniversity_WithNullId_ReturnsOk() {
        University university = new University();
        university.setName("ELTE");

        when(universityRepository.save(university)).thenReturn(university);

        ResponseEntity<Object> response = universityService.addUniversity(university);

        assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    @Test
    void addUniversity_WithExistingId_Returns415() {
        University university = new University();
        university.setId(1);

        ResponseEntity<Object> response = universityService.addUniversity(university);

        assertEquals(HttpStatus.UNSUPPORTED_MEDIA_TYPE, response.getStatusCode());
        assertEquals("invalidObject", response.getBody());
        verify(universityRepository, never()).save(any());
    }

    @Test
    void deleteUniversity_WhenNotFound_Returns404() {
        when(universityRepository.findById(99)).thenReturn(Optional.empty());

        ResponseEntity<Object> response = universityService.deleteUniversity(99);

        assertEquals(HttpStatus.NOT_FOUND, response.getStatusCode());
    }
}