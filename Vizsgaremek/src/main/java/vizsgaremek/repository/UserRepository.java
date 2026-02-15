package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import vizsgaremek.entity.Users;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<Users, Integer> {
    Optional<Users> findByUsername(String username);

    @Procedure(name = "getAllUsers", procedureName = "getAllUsers")
    List<Users> getAllUsers();

    @Procedure(name = "deteteUser", procedureName = "deteteUser")
    void deleteUser(@Param("idIN") Integer id);

    @Procedure(name = "getAllWorker", procedureName = "getAllWorker")
    List<Users> getAllWorker();
}
