package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.Worker;
import vizsgaremek.service.WorkerService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/workers")
@RequiredArgsConstructor
public class WorkerController {

    private final WorkerService workerService;

    @GetMapping
    public List<Worker> getAllWorkers() {
        return workerService.findAll();
    }

    @GetMapping("/{id}")
    public Optional<Worker> getWorkerById(@PathVariable int id) {
        return workerService.findById(id);
    }

    @PostMapping
    public Worker createWorker(@RequestBody Worker worker) {
        return workerService.save(worker);
    }

    @DeleteMapping("/{id}")
    public void deleteWorker(@PathVariable int id) {
        workerService.deleteById(id);
    }
}
