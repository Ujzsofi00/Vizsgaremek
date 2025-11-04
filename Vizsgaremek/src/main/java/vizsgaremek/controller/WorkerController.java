package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.Worker;
import vizsgaremek.repository.WorkerRepository;

import java.util.List;

@RestController
@RequestMapping("/workers")
@RequiredArgsConstructor
public class WorkerController {

    private final WorkerRepository workerRepository;

    @GetMapping
    public List<Worker> getAllWorkers() {
        return workerRepository.findAll();
    }

    @GetMapping("/{id}")
    public Worker getWorker(@PathVariable Integer id) {
        return workerRepository.findById(id).orElse(null);
    }

    @PostMapping
    public Worker setWorker(@RequestBody Worker worker) {
        return workerRepository.save(worker);
    }

    @DeleteMapping("/{id}")
    public void deleteWorker(@PathVariable Integer id) {
        workerRepository.deleteById(id);
    }
}
