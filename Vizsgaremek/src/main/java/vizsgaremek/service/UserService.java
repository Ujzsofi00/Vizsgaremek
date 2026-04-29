package vizsgaremek.service;

import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vizsgaremek.dto.UserUpdateDto;
import vizsgaremek.email.EmailSender;
import vizsgaremek.entity.Users;
import vizsgaremek.repository.RoleRepository;
import vizsgaremek.repository.UserRepository;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.Random;
import java.util.regex.Pattern;

@Service
@RequiredArgsConstructor
@Transactional
public class UserService {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final EmailSender emailSender;

    public ResponseEntity<Object> register(Users user) {
        user.setRole(roleRepository.findById(1).get());


        if (!emailValidator(user.getEmail())) {
            return ResponseEntity.status(415).body("invalidEmail");
        }
        user.setIsDeleted(false);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);

        try {
            emailSender.sendEmailAfterRegistration(user.getEmail(), user.getFirstName() + " " + user.getLastName());
        } catch (MessagingException e) {
        }

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

    public ResponseEntity<Object> updateUser(Integer id, UserUpdateDto updatedUser) {
        Users searchedUser = userRepository.findById(id).orElse(null);
        if (searchedUser == null || searchedUser.getIsDeleted()) {
            return ResponseEntity.notFound().build();
        }

        if (!emailValidator(updatedUser.email())) {
            return ResponseEntity.status(415).body("invalidEmail");
        }

        searchedUser.setFirstName(updatedUser.firstName());
        searchedUser.setLastName(updatedUser.lastName());
        searchedUser.setEmail(updatedUser.email());
        searchedUser.setUsername(updatedUser.username());

        return ResponseEntity.ok().body(userRepository.save(searchedUser));
    }

    //passwordReset:
    public ResponseEntity<Object> getVerificationCode(String email) {
        if (!emailValidator(email.trim())) {
            return ResponseEntity.status(415).body("invalidEmail");
        } else {
            Users searchedUser = userRepository.findByEmail(email).orElse(null);
            String vCode = generateVerificationCode();
            searchedUser.setVCode(passwordEncoder.encode(vCode));
            userRepository.save(searchedUser);
            try {
                emailSender.sendEmailAboutVerificationCode(email, searchedUser.getFirstName() + " " + searchedUser.getLastName(), vCode);
            } catch (MessagingException e) {
            }
            return ResponseEntity.ok().build();
        }
    }

    public ResponseEntity<Object> checkVerificationCode(String userVCode, String email) {
        Users searchedUser = userRepository.findByEmail(email).orElse(null);

        if (userVCode.length() != 10) {
            return ResponseEntity.status(415).body("invalidVCode");
        } else {
            return ResponseEntity.ok().body(Map.of("success", passwordEncoder.matches(userVCode, searchedUser.getVCode())));
        }
    }

    public ResponseEntity<Object> updatePassword(String email, String newPassword) {
        if (!emailValidator(email)) {
            return ResponseEntity.status(415).body("invalidEmail");
        }

        Users searchedUser = userRepository.findByEmail(email).orElse(null);
        if (searchedUser == null) {
            return ResponseEntity.notFound().build();
        }

        if (!passwordValidator(newPassword)) {
            return ResponseEntity.status(415).body("invalidPassword");
        } else {
            String hashedPassword = passwordEncoder.encode(newPassword);
            searchedUser.setPassword(hashedPassword);
            userRepository.save(searchedUser);
            return ResponseEntity.ok().build();
        }
    }


    //Egyebek
    public static Boolean emailValidator(String email) {
        if (email == null || email.length() > 100) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }

    public static Boolean passwordValidator(String password) {
        if (password.length() < 8 || password.length() > 16) {
            return false;
        }

        String specialCharacters = "\"!@#$%^&*()-_=+[]{};:,.?/\"";
        String numbersText = "1234567890";
        boolean specialChecker = false;
        boolean upperCaseChecker = false;
        boolean lowerCaseChecker = false;
        boolean initChecker = false;

        for (int i = 0; i < password.trim().length(); i++) {
            String selectedChar = String.valueOf(password.charAt(i));

            if (numbersText.contains(selectedChar)) {
                initChecker = true;
            } else if (specialCharacters.contains(selectedChar)) {
                specialChecker = true;
            } else if (selectedChar.equals(selectedChar.toUpperCase())) {
                upperCaseChecker = true;
            } else if (selectedChar.equals(selectedChar.toLowerCase())) {
                lowerCaseChecker = true;
            }
        }

        return specialChecker && upperCaseChecker && lowerCaseChecker && initChecker;
    }

    public String generateVerificationCode() {
        String code = "";
        ArrayList<String> characters = new ArrayList<String>(Arrays.asList("0", "1", "2", "3", "4", "5", "6", "7", "8", "9"));

        for (int i = 97; i <= 122; i++) {
            characters.add(String.valueOf((char) i));
        }

        while (code.length() != 10) {
            Random random = new Random();
            code += characters.get(random.nextInt(characters.size()));
        }

        return code;
    }
}
