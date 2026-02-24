package vizsgaremek.security;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import vizsgaremek.security.JWT.JwtAuthenticationFilter;
import vizsgaremek.security.JWT.JwtGeneratorFilter;

import java.util.Arrays;
import java.util.Collections;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(jsr250Enabled = true, securedEnabled = true)
@RequiredArgsConstructor
public class SecurityConfig {

    private final DbUserSetter userSetter;
    private final JwtAuthenticationFilter jwtAuthenticationFilter;
    private final JwtGeneratorFilter jwtGeneratorFilter;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        http
                .cors(cors -> cors.configurationSource(new CorsConfigurationSource() {
                    @Override
                    public CorsConfiguration getCorsConfiguration(HttpServletRequest request) {
                        CorsConfiguration config = new CorsConfiguration();
                        config.setAllowedOrigins(Collections.singletonList("http://localhost:4200"));
                        config.setAllowedMethods(Collections.singletonList("*"));
                        config.setAllowedHeaders(Collections.singletonList("*"));
                        config.setAllowCredentials(true);
                        config.setExposedHeaders(Arrays.asList("Authorization", "Bearer "));
                        config.setMaxAge(3600L);
                        return config;
                    }
                }))
                .csrf(csrf -> csrf.disable())
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests((request) -> request
                        .requestMatchers("/user/register", "/user/login").permitAll()
                        .requestMatchers("/user/worker").hasAnyRole("admin", "worker")
                        .requestMatchers("/user").hasRole("admin")
                        .requestMatchers(HttpMethod.DELETE, "/user/*").hasRole("admin")
                        .requestMatchers(HttpMethod.PATCH, "/user/*").hasRole("admin")
                        .requestMatchers(HttpMethod.GET, "/university/*").permitAll()
                        .requestMatchers("/university").hasRole("admin")
                        .requestMatchers("/university/*").hasRole("admin")
                        .requestMatchers("/faculty").hasRole("admin")
                        .requestMatchers(HttpMethod.GET, "/appointment/*").authenticated()
                        .requestMatchers("/appointment/*/book").authenticated()
                        .requestMatchers(HttpMethod.DELETE, "/appointment/*").hasAnyRole("admin", "worker")
                        .requestMatchers(HttpMethod.PUT, "/appointment/*").hasAnyRole("admin", "worker")
                        .requestMatchers(HttpMethod.POST, "/appointment").hasAnyRole("admin", "worker")
                )
                .addFilterBefore(jwtAuthenticationFilter, BasicAuthenticationFilter.class)
                .addFilterAfter(jwtGeneratorFilter, BasicAuthenticationFilter.class)
                .httpBasic(Customizer.withDefaults())
                //.formLogin(Customizer.withDefaults());
                .formLogin(f -> f.disable());
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    AuthenticationProvider authProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider(userSetter);
        authenticationProvider.setPasswordEncoder(passwordEncoder());
        return authenticationProvider;
    }
}
