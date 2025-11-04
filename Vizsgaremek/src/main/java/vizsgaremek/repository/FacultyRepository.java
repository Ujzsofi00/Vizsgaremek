package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vizsgaremek.entity.Faculty;

public interface FacultyRepository extends JpaRepository<Faculty, Integer> {
}
