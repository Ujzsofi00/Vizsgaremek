package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.WorkerXAppointment;
import vizsgaremek.repository.WorkerXAppointmentRepository;

import java.util.List;

@RestController
@RequestMapping("/workerxappointments")
@RequiredArgsConstructor
public class WorkerXAppointmentController {

    private final WorkerXAppointmentRepository repository;

    @GetMapping
    public List<WorkerXAppointment> getAll() {
        return repository.findAll();
    }

    @PostMapping
    public WorkerXAppointment create(@RequestBody WorkerXAppointment wxa) {
        return repository.save(wxa);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        repository.deleteById(id);
    }
}
