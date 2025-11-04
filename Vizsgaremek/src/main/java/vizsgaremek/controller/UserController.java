package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.User;
import vizsgaremek.repository.UserRepository;
import vizsgaremek.security.JwtUtil;

@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    private final UserRepository userRepository;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    @PostMapping("/register")
    public User registerUser(@RequestBody User user) {
        log.info("Register request received for email: {}", user.getEmail());
        try {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            user.setRole("ROLE_USER");
            User savedUser = userRepository.save(user);
            log.info("User saved successfully: {}", savedUser.getEmail());
            return savedUser;
        } catch (Exception e) {
            log.error("Error registering user: {}", e.getMessage(), e);
            throw e;
        }
    }

    @PostMapping("/login")
    public String login(@RequestBody User loginRequest) {
        log.info("Login attempt for email: {}", loginRequest.getEmail());
        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginRequest.getEmail(), loginRequest.getPassword())
            );

            SecurityContextHolder.getContext().setAuthentication(authentication);
            String token = jwtUtil.generateToken(loginRequest.getEmail());

            log.info("Login successful for email: {}", loginRequest.getEmail());
            return "Bearer " + token;
        } catch (Exception e) {
            log.error("Login failed for email: {} | Error: {}", loginRequest.getEmail(), e.getMessage(), e);
            throw e;
        }
    }
}
