package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.Appointment;
import vizsgaremek.entity.User;
import vizsgaremek.service.AppointmentService;
import vizsgaremek.service.UserService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final AppointmentService appointmentService;

    @GetMapping
    public List<User> getAllUsers() {
        return userService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> getUser(@PathVariable int id) {
        return userService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public User createUser(@RequestBody User user) {
        return userService.save(user);
    }

    @DeleteMapping("/{id}")
    public void deleteUser(@PathVariable int id) {
        userService.deleteById(id);
    }


    @GetMapping("/{id}/appointments")
    public ResponseEntity<List<Appointment>> getUserAppointments(@PathVariable int id) {
        Optional<User> userOpt = userService.findById(id);
        return userOpt.map(user -> ResponseEntity.ok(user.getAppointments()))
                .orElse(ResponseEntity.notFound().build());
    }


    @PostMapping("/{id}/appointments")
    public ResponseEntity<Appointment> createAppointmentForUser(@PathVariable int id,
                                                                @RequestBody Appointment appointment) {
        try {
            Appointment saved = appointmentService.createForUser(id, appointment);
            return ResponseEntity.ok(saved);
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.notFound().build();
        }
    }
}
