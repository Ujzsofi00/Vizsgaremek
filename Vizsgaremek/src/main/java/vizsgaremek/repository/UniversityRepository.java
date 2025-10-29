package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vizsgaremek.entity.University;

@Repository
public interface UniversityRepository extends JpaRepository<University, Integer> {}
