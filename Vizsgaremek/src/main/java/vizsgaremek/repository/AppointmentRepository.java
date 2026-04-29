package vizsgaremek.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import vizsgaremek.entity.Appointment;

import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface AppointmentRepository extends JpaRepository<Appointment, Integer> {

    @Procedure(name = "getAppointmentByDate", procedureName = "getAppointmentByDate")
    Optional<Appointment> getAppointmentByDate(@Param("dateIN") Date date);

    @Procedure(name = "getAllAppointment", procedureName = "getAllAppointment")
    List<Appointment> getAllAppointment();

    @Procedure(name = "deleteAppointment", procedureName = "deleteAppointment")
    void deleteAppointment(@Param("idIN") Integer id);

    @Procedure(name = "cancelReservation", procedureName = "cancelReservation")
    void cancelReservation(@Param("userIdIN") Integer userId, @Param("appointmentIdIN") Integer appointmentId);
}
