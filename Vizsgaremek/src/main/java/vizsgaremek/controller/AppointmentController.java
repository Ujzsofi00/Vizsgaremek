package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.Appointment;
import vizsgaremek.service.AppointmentService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/appointments")
@RequiredArgsConstructor
public class AppointmentController {

    private final AppointmentService appointmentService;

    @GetMapping
    public List<Appointment> getAllAppointments() {
        return appointmentService.findAll();
    }

    @GetMapping("/{id}")
    public Optional<Appointment> getAppointmentById(@PathVariable int id) {
        return appointmentService.findById(id);
    }

    @PostMapping
    public Appointment createAppointment(@RequestBody Appointment appointment) {
        return appointmentService.save(appointment);
    }

    @DeleteMapping("/{id}")
    public void deleteAppointment(@PathVariable int id) {
        appointmentService.deleteById(id);
    }
}
