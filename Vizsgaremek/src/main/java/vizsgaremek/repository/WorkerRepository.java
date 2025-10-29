package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vizsgaremek.entity.Worker;

@Repository
public interface WorkerRepository extends JpaRepository<Worker, Integer> {
}
