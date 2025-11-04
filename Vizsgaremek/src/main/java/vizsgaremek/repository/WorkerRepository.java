package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vizsgaremek.entity.Worker;

public interface WorkerRepository extends JpaRepository<Worker, Integer> {
}
