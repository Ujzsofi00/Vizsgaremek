package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import vizsgaremek.entity.Appointment;
import vizsgaremek.repository.AppointmentRepository;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;

    public List<Appointment> findAll() {
        return appointmentRepository.findAll();
    }

    public Optional<Appointment> findById(int id) {
        return appointmentRepository.findById(id);
    }

    public Appointment save(Appointment appointment) {
        return appointmentRepository.save(appointment);
    }

    public void deleteById(int id) {
        appointmentRepository.deleteById(id);
    }
}
