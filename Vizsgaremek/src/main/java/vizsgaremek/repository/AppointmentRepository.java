package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vizsgaremek.entity.Appointment;

public interface AppointmentRepository extends JpaRepository<Appointment, Integer> {
}
