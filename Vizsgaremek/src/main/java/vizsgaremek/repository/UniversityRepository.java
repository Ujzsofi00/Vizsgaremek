package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vizsgaremek.entity.University;

public interface UniversityRepository extends JpaRepository<University, Integer> {
}
