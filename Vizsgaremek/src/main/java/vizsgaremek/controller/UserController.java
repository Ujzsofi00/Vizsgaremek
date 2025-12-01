package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
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
public class UserController {

    private final UserRepository userRepository;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    @PostMapping("/register")
    public User registerUser(@RequestBody User user) {
        System.out.println("➡ Register request received for: " + user.getEmail());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole("ROLE_USER");

        User savedUser = userRepository.save(user);
        System.out.println("User saved successfully: " + savedUser.getEmail());
        return savedUser;
    }

    @PostMapping("/login")
    public String login(@RequestBody User loginRequest) {
        System.out.println("➡ Login attempt for: " + loginRequest.getEmail());

        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            loginRequest.getEmail(),
                            loginRequest.getPassword()
                    )
            );

            SecurityContextHolder.getContext().setAuthentication(authentication);
            String token = jwtUtil.generateToken(loginRequest.getEmail());

            System.out.println("Login successful: " + loginRequest.getEmail());
            return "Bearer " + token;

        } catch (Exception e) {
            System.err.println("Login failed for: " + loginRequest.getEmail());
            e.printStackTrace();
            return "Login failed: " + e.getMessage();
        }
    }
}
