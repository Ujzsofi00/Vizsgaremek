package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vizsgaremek.entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
}
