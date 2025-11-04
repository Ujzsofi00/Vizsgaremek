package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.UserXAppointment;
import vizsgaremek.repository.UserXAppointmentRepository;

import java.util.List;

@RestController
@RequestMapping("/userxappointments")
@RequiredArgsConstructor
public class UserXAppointmentController {

    private final UserXAppointmentRepository repository;

    @GetMapping
    public List<UserXAppointment> getAll() {
        return repository.findAll();
    }

    @PostMapping
    public UserXAppointment create(@RequestBody UserXAppointment uxa) {
        return repository.save(uxa);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        repository.deleteById(id);
    }
}
