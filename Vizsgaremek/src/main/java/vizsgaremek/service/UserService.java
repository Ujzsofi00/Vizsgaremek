package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import vizsgaremek.entity.Appointment;
import vizsgaremek.entity.User;
import vizsgaremek.repository.AppointmentRepository;
import vizsgaremek.repository.UserRepository;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public ResponseEntity<Object> getAllUsers() {
//        return userRepository.findAll();
        return null;
    }

    public ResponseEntity<Object> getUserById(Integer id) {
//        return userRepository.findById(id);
        return null;
    }

    public ResponseEntity<Object> register(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        return ResponseEntity.ok().build();
    }

    public ResponseEntity<Object> login(String username, String password) {
        try {
            if (username == null || password == null) {
                return null;
            }

            User searchedUser = userRepository.findByUsername(username).orElse(null);
            if (searchedUser == null) {
                return ResponseEntity.notFound().build();
            } else {
                if (passwordEncoder.matches(password, searchedUser.getPassword())) {
                    return ResponseEntity.ok().body(searchedUser);
                } else {
                    return ResponseEntity.notFound().build();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public ResponseEntity<Object> deleteUser(Integer id) {
//        userRepository.deleteById(id);
        return null;
    }

}
