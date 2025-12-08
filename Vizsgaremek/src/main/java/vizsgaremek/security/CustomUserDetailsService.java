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
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        var userOpt = userRepository.findByEmail(email);
        if (userOpt.isPresent()) {
            var u = userOpt.get();
            return User.withUsername(u.getEmail())
                    .password(u.getPassword())
                    .build();

        }

        var workerOpt = workerRepository.findByEmail(email);
        if (workerOpt.isPresent()) {
            var w = workerOpt.get();
            return User.withUsername(w.getEmail())
                    .password(w.getPassword())
                    .build();
        }

        throw new UsernameNotFoundException("User or worker not found with email: " + email);
    }
}
