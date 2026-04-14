package vizsgaremek.email;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;
import org.thymeleaf.spring6.SpringTemplateEngine;

@Component
@RequiredArgsConstructor
public class EmailSender {

    private final JavaMailSender mailSender;
    private final SpringTemplateEngine thymeleafTemplateEngine;
    private String email = "";

    public void sendEmailAfterRegistration(String to) {

    }

    public void sendEmailAfterReservation(String to) {

    }

    public void sendEmailAfterReservationCancelling(String to) {

    }

    public void sendEmailAfterAccountDelete(String to) {

    }

    public void sendEmailAboutVerificationCode(String to, String vCode) {

    }
}
