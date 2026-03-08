package vizsgaremek;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

@SpringBootApplication
@EnableWebSecurity
@EnableMethodSecurity(jsr250Enabled = true)
public class VizsgaremekApplication {

    public static void main(String[] args) {
        SpringApplication.run(VizsgaremekApplication.class, args);
    }
}
