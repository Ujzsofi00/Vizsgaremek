package vizsgaremek.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vizsgaremek.entity.Appointment;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface AppointmentRepository extends JpaRepository<Appointment, Integer> {

    List<Appointment> findByDateBetweenAndIsDeletedFalse(
            LocalDate start,
            LocalDate end
    );

    boolean existsByDateAndIsDeletedFalse(LocalDate date);

    Optional<Appointment> findByIdAndIsDeletedFalse(Integer id);
}
