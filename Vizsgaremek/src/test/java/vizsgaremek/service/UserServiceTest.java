package vizsgaremek.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import vizsgaremek.entity.Role;
import vizsgaremek.entity.Users;
import vizsgaremek.repository.RoleRepository;
import vizsgaremek.repository.UserRepository;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private PasswordEncoder passwordEncoder;

    @Mock
    private UserRepository userRepository;

    @Mock
    private RoleRepository roleRepository;

    @InjectMocks
    private UserService userService;

    private Users user;
    private Role userRole;

    @BeforeEach
    void setUp() {
        user = new Users();
        user.setUsername("testuser");
        user.setEmail("test@example.com");
        user.setPassword("password123");
        user.setIsDeleted(false);

        userRole = new Role();
        userRole.setId(1);
        userRole.setName("ROLE_user");
    }

    @Test
    void register_ValidUser_ReturnsOkAndSavesEncodedPassword() {
        when(roleRepository.findById(1)).thenReturn(Optional.of(userRole));
        when(passwordEncoder.encode("password123")).thenReturn("encodedPassword");

        ResponseEntity<Object> response = userService.register(user);

        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals("encodedPassword", user.getPassword());
        verify(userRepository).save(user);
    }

    @Test
    void register_InvalidEmail_Returns415AndDoesNotSave() {
        user.setEmail("wrong-email");
        when(roleRepository.findById(1)).thenReturn(Optional.of(userRole));

        ResponseEntity<Object> response = userService.register(user);

        assertEquals(HttpStatus.UNSUPPORTED_MEDIA_TYPE, response.getStatusCode());
        assertEquals("invalidEmail", response.getBody());
        verify(userRepository, never()).save(any());
    }

    @Test
    void login_ValidCredentials_ReturnsOk() {
        user.setPassword("encodedPassword");
        when(userRepository.findByUsername("testuser")).thenReturn(Optional.of(user));
        when(passwordEncoder.matches("password123", "encodedPassword")).thenReturn(true);

        ResponseEntity<Object> response = userService.login("testuser", "password123");

        assertEquals(HttpStatus.OK, response.getStatusCode());
    }
}