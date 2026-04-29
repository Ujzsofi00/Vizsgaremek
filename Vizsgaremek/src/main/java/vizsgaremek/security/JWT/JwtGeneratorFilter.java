package vizsgaremek.security.JWT;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import vizsgaremek.entity.Users;
import vizsgaremek.repository.UserRepository;

import java.io.IOException;
import java.util.Date;
import java.util.concurrent.TimeUnit;

@Component
@RequiredArgsConstructor
public class JwtGeneratorFilter extends OncePerRequestFilter {

    private final UserRepository userRepository;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        Authentication givenAuthentication = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("ASD");

        if (givenAuthentication != null) {
            UserDetails principal = (UserDetails) givenAuthentication.getPrincipal();

            Users loggedUsers = userRepository.findByUsername(principal.getUsername()).orElseThrow(() -> new RuntimeException("User not found"));
            String jwt = JWT.create()
                    .withSubject(loggedUsers.getEmail())
                    .withArrayClaim("AUTH", principal.getAuthorities().stream().map(GrantedAuthority::getAuthority).toArray(String[]::new))
                    .withExpiresAt(new Date(System.currentTimeMillis() + 7200000))
                    .withIssuer("universityTeam")
                    .sign(Algorithm.HMAC256("cbfb19aeab8b95b39eb3f190f6ce305445b1eaf0ea19c417ceae59f887b723cf"));
            System.out.println(jwt);
            response.setHeader("Bearer ", jwt);
        }

        filterChain.doFilter(request, response);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
        return !request.getServletPath().equals("/user/login");
    }
}