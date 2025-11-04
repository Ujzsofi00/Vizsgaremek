package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vizsgaremek.entity.Worker;

import java.util.Optional;

public interface WorkerRepository extends JpaRepository<Worker, Integer> {
    Optional<Worker> findByEmail(String email);
}
