package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.Appointment;
import vizsgaremek.entity.User;
import vizsgaremek.service.UserService;

import java.util.List;

@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping
    public List<User> getAllUsers() {
        return userService.getAllUsers();
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Integer id) {
        return userService.getUserById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public User createUser(@RequestBody User user) {
        return userService.saveUser(user);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Integer id) {
        userService.deleteUser(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{userId}/appointments")
    public ResponseEntity<User> addAppointmentToUser(
            @PathVariable Integer userId,
            @RequestBody Appointment appointment) {
        User user = userService.addAppointmentToUser(userId, appointment);
        return ResponseEntity.ok(user);
    }

    @DeleteMapping("/{userId}/appointments/{appointmentId}")
    public ResponseEntity<Void> removeAppointmentFromUser(
            @PathVariable Integer userId,
            @PathVariable Integer appointmentId) {
        userService.removeAppointmentFromUser(userId, appointmentId);
        return ResponseEntity.noContent().build();
    }
}
