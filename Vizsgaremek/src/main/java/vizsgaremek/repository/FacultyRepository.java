package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import vizsgaremek.entity.Faculty;

import java.util.List;

public interface FacultyRepository extends JpaRepository<Faculty, Integer> {

    @Procedure(name = "getAllFaculties", procedureName = "getAllFaculties")
    List<Faculty> getAllFaculties();
}
