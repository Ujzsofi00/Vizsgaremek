package vizsgaremek.email;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring6.SpringTemplateEngine;
import vizsgaremek.entity.Appointment;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Component
@RequiredArgsConstructor
public class EmailSender {

    private final JavaMailSender mailSender;
    private final SpringTemplateEngine thymeleafTemplateEngine;
    private String email = "universitasSupport@gmail.com";

    public void sendEmailAfterRegistration(String to, String name) throws MessagingException {
        MimeMessage msg = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
        helper.setFrom(email);
        helper.setSubject("Sikeres regisztráció!");
        helper.setTo(to);

        Map<String, Object> emailObject = new HashMap<>();
        emailObject.put("name", name);
        emailObject.put("registerDate", LocalDateTime.now());
        helper.setText(createHtmlBody("RegistrationTemplate.html", emailObject), true);
        mailSender.send(msg);
    }

    public void sendEmailAfterReservation(String to, Appointment newAppointment, String name) throws MessagingException {
        MimeMessage msg = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
        helper.setFrom(email);
        helper.setSubject("Sikeres foglalás");
        helper.setTo(to);

        Map<String, Object> emailObject = new HashMap<>();
        emailObject.put("name", name);
        emailObject.put("appointmentDate", newAppointment.getDate());
        emailObject.put("start", newAppointment.getStart());
        emailObject.put("title", newAppointment.getTitle());
        helper.setText(createHtmlBody("ReservationTemplate.html", emailObject), true);
        mailSender.send(msg);
    }

    public void sendEmailAfterReservationCancelling(String to, Appointment cancelledAppointment, String name) throws MessagingException {
        MimeMessage msg = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
        helper.setFrom(email);
        helper.setSubject("Sikeres lemondás");
        helper.setTo(to);

        Map<String, Object> emailObject = new HashMap<>();
        emailObject.put("name", name);
        emailObject.put("appointmentDate", cancelledAppointment.getDate());
        emailObject.put("start", cancelledAppointment.getStart());
        emailObject.put("end", cancelledAppointment.getEnd());
        emailObject.put("title", cancelledAppointment.getTitle());
        helper.setText(createHtmlBody("ReservationCancelledTemplate.html", emailObject), true);
        mailSender.send(msg);
    }

    public void sendEmailAboutVerificationCode(String to, String name, String vCode) throws MessagingException {
        MimeMessage msg = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
        helper.setFrom(email);
        helper.setSubject("Biztonsági kód");
        helper.setTo(to);

        Map<String, Object> emailObject = new HashMap<>();
        emailObject.put("name", name);
        emailObject.put("vCode", vCode);
        emailObject.put("date", LocalDateTime.now());
        helper.setText(createHtmlBody("VCodeTemplate.html", emailObject), true);
        mailSender.send(msg);
    }

    private String createHtmlBody(String nameOfHtml, Map<String, Object> templateModel) {
        Context thymeleafContext = new Context();
        thymeleafContext.setVariables(templateModel);
        String htmlBody = thymeleafTemplateEngine.process(nameOfHtml, thymeleafContext);
        return htmlBody;
    }
}
