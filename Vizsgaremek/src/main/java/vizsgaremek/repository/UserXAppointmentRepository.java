package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vizsgaremek.entity.UserXAppointment;

public interface UserXAppointmentRepository extends JpaRepository<UserXAppointment, Integer> {
}
