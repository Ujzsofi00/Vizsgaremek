package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vizsgaremek.repository.FacultyRepository;

@Service
@Transactional
@RequiredArgsConstructor
public class FacultyService {
    private final FacultyRepository facultyRepository;

    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<Object> getAllFaculty() {
        try {
            return ResponseEntity.ok().body(facultyRepository.getAllFaculties());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
