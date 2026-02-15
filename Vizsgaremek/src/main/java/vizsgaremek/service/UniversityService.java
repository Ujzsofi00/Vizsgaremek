package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vizsgaremek.entity.University;
import vizsgaremek.repository.UniversityRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class UniversityService {
    private final UniversityRepository universityRepository;

    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<Object> getAllUniversity() {
        try {
            return ResponseEntity.ok().body(universityRepository.getAllUniversities());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<Object> addUniversity(University newUniversity) {
        try {
            if (newUniversity.getId() != null) {
                return ResponseEntity.status(415).body("invalidObject");
            }

            return ResponseEntity.ok(universityRepository.save(newUniversity));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<Object> updateUniversity(University updatedUniversity) {
        try {
            if (updatedUniversity.getId() == null) {
                return ResponseEntity.status(415).body("invalidObject");
            }

            return ResponseEntity.ok(universityRepository.save(updatedUniversity));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<Object> deleteUniversity(Integer id) {
        try {
            University searchedUniversity = universityRepository.findById(id).orElse(null);
            if (searchedUniversity == null || searchedUniversity.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            } else {
                universityRepository.deleteUniversity(id);
                return ResponseEntity.ok().build();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public ResponseEntity<Object> getUniversityByName(String name) {
        try {
            return ResponseEntity.ok().body(universityRepository.getUniversityByName(name));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
