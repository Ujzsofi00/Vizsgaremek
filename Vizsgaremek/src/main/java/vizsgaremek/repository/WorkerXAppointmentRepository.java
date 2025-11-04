package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vizsgaremek.entity.WorkerXAppointment;

public interface WorkerXAppointmentRepository extends JpaRepository<WorkerXAppointment, Integer> {
}
