package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vizsgaremek.entity.User;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findByEmail(String email);
}
