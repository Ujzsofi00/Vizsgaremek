package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import vizsgaremek.entity.Worker;
import vizsgaremek.repository.WorkerRepository;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class WorkerService {

    private final WorkerRepository workerRepository;

    public List<Worker> findAll() {
        return workerRepository.findAll();
    }

    public Optional<Worker> findById(int id) {
        return workerRepository.findById(id);
    }

    public Worker save(Worker worker) {
        return workerRepository.save(worker);
    }

    public void deleteById(int id) {
        workerRepository.deleteById(id);
    }
}
