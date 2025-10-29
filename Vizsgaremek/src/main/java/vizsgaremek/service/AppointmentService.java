package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vizsgaremek.entity.Appointment;
import vizsgaremek.entity.User;
import vizsgaremek.repository.AppointmentRepository;
import vizsgaremek.repository.UserRepository;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;
    private final UserRepository userRepository;

    public List<Appointment> findAll() { return appointmentRepository.findAll(); }

    public Optional<Appointment> findById(int id) { return appointmentRepository.findById(id); }

    public Appointment save(Appointment appointment) { return appointmentRepository.save(appointment); }

    public void deleteById(int id) { appointmentRepository.deleteById(id); }
    @Transactional
    public Appointment createForUser(int userId, Appointment appointment) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found: " + userId));
        user.addAppointment(appointment);
        userRepository.save(user);
        return appointment;
    }
}
