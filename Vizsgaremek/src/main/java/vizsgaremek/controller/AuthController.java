package vizsgaremek.controller;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.repository.UserRepository;
import vizsgaremek.repository.WorkerRepository;
import vizsgaremek.security.JwtUtil;
import vizsgaremek.entity.User;
import vizsgaremek.entity.Worker;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final JwtUtil jwtUtil;
    private final UserRepository userRepository;
    private final WorkerRepository workerRepository;
    private final PasswordEncoder passwordEncoder;

    // REGISTER USER
    @PostMapping("/register-user")
    public ResponseEntity<String> registerUser(@RequestBody RegisterRequest request) {

        // Manual validation
        if (request.getEmail() == null || request.getEmail().isBlank()) {
            return ResponseEntity.badRequest().body("Email is required");
        }
        if (!request.getEmail().contains("@")) {
            return ResponseEntity.badRequest().body("Invalid email format");
        }
        if (request.getPassword() == null || request.getPassword().isBlank()) {
            return ResponseEntity.badRequest().body("Password is required");
        }
        if (request.getFirstName() == null || request.getFirstName().isBlank()) {
            return ResponseEntity.badRequest().body("First name is required");
        }
        if (request.getLastName() == null || request.getLastName().isBlank()) {
            return ResponseEntity.badRequest().body("Last name is required");
        }

        if (userRepository.findByEmail(request.getEmail()).isPresent()) {
            return ResponseEntity.badRequest().body("Email already exists");
        }

        User user = new User();
        user.setEmail(request.getEmail());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setFirstName(request.getFirstName());
        user.setLastName(request.getLastName());

        userRepository.save(user);

        return ResponseEntity.ok("User registered successfully");
    }

    // REGISTER WORKER
    @PostMapping("/register-worker")
    public ResponseEntity<String> registerWorker(@RequestBody RegisterRequest request) {

        // Manual validation
        if (request.getEmail() == null || request.getEmail().isBlank()) {
            return ResponseEntity.badRequest().body("Email is required");
        }
        if (!request.getEmail().contains("@")) {
            return ResponseEntity.badRequest().body("Invalid email format");
        }
        if (request.getPassword() == null || request.getPassword().isBlank()) {
            return ResponseEntity.badRequest().body("Password is required");
        }
        if (request.getFirstName() == null || request.getFirstName().isBlank()) {
            return ResponseEntity.badRequest().body("First name is required");
        }
        if (request.getLastName() == null || request.getLastName().isBlank()) {
            return ResponseEntity.badRequest().body("Last name is required");
        }

        if (workerRepository.findByEmail(request.getEmail()).isPresent()) {
            return ResponseEntity.badRequest().body("Email already exists");
        }

        Worker worker = new Worker();
        worker.setEmail(request.getEmail());
        worker.setPassword(passwordEncoder.encode(request.getPassword()));
        worker.setFirstName(request.getFirstName());
        worker.setLastName(request.getLastName());

        workerRepository.save(worker);

        return ResponseEntity.ok("Worker registered successfully");
    }

    // LOGIN
    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody LoginRequest request) {

        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );

        String token = jwtUtil.generateToken(request.getEmail());

        return ResponseEntity.ok()
                .header("Authorization", "Bearer " + token)
                .body(token);
    }

    @Data
    static class RegisterRequest {
        private String email;
        private String password;
        private String firstName;
        private String lastName;
    }

    @Data
    static class LoginRequest {
        private String email;
        private String password;
    }
}
