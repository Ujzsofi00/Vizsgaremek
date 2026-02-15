package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import vizsgaremek.entity.User;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByUsername(String username);

    @Procedure(name = "getAllUsers", procedureName = "getAllUsers")
    List<User> getAllUsers();

    @Procedure(name = "deteteUser", procedureName = "deteteUser")
    void deleteUser(@Param("idIN") Integer id);

    @Procedure(name = "getAllWorker", procedureName = "getAllWorker")
    List<User> getAllWorker();
}
