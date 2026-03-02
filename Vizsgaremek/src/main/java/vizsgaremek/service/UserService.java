package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vizsgaremek.entity.Users;
import vizsgaremek.repository.RoleRepository;
import vizsgaremek.repository.UserRepository;

import java.util.regex.Pattern;

@Service
@RequiredArgsConstructor
@Transactional
public class UserService {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    public ResponseEntity<Object> register(Users user) {
        user.setRole(roleRepository.findById(1).get());


        if (!emailValidator(user.getEmail())) {
            return ResponseEntity.status(415).body("invalidEmail");
        }
        user.setIsDeleted(false);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        return ResponseEntity.ok().build();
    }

    public ResponseEntity<Object> login(String username, String password) {
        try {
            if (username == null || password == null) {
                return null;
            }

            Users searchedUser = userRepository.findByUsername(username).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
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

    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<Object> getAllUser() {
        try {
            return ResponseEntity.ok().body(userRepository.getAllUsers());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<Object> deleteUser(Integer id) {
        try {
            Users searchedUser = userRepository.findById(id).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }
            userRepository.deleteUser(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<Object> changeRoleOfUser(Integer id) {
        try {
            Users searchedUser = userRepository.findById(id).orElse(null);
            if (searchedUser.getRole().getName().equals("ROLE_worker")) {
                searchedUser.setRole(roleRepository.findById(1).get());
            } else {
                searchedUser.setRole(roleRepository.findById(3).get());
            }

            return ResponseEntity.ok().body(userRepository.save(searchedUser));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PreAuthorize("hasAnyRole('admin', 'worker')")
    public ResponseEntity<Object> getAllWorker() {
        try {
            return ResponseEntity.ok().body(userRepository.getAllWorker());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }


    public static Boolean emailValidator(String email) {
        if (email == null || email.length() > 100) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }
}
