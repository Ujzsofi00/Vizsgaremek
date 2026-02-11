package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import vizsgaremek.entity.University;

import java.util.List;

public interface UniversityRepository extends JpaRepository<University, Integer> {

    @Procedure(name = "getAllUniversities", procedureName = "getAllUniversities")
    List<University> getAllUniversities();

    @Procedure(name = "getUniversityByName", procedureName = "getUniversityByName")
    List<University> getUniversityByName(@Param("nameIN") String name);

    @Procedure(name = "deleteUniversity", procedureName = "deleteUniversity")
    void deleteUniversity(@Param("idIN") Integer id);
}
