package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vizsgaremek.entity.Faculty;

@Repository
public interface FacultyRepository extends JpaRepository<Faculty, Integer> {}
