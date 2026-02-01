package vizsgaremek.security;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import vizsgaremek.repository.UserRepository;
import vizsgaremek.repository.WorkerRepository;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;
    private final WorkerRepository workerRepository;

    @Override
    public UserDetails loadUserByUsername(String email)
            throws UsernameNotFoundException {

        return userRepository.findByEmail(email)
                .map(u -> User.withUsername(u.getEmail())
                        .password(u.getPassword())
                        .authorities("ROLE_USER")
                        .build())
                .orElseGet(() ->
                        workerRepository.findByEmail(email)
                                .map(w -> User.withUsername(w.getEmail())
                                        .password(w.getPassword())
                                        .authorities("ROLE_WORKER")
                                        .build())
                                .orElseThrow(() ->
                                        new UsernameNotFoundException(
                                                "User or worker not found with email: " + email
                                        ))
                );
    }
}
