package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vizsgaremek.dto.AppointmentDto;
import vizsgaremek.entity.Appointment;
import vizsgaremek.entity.User;
import vizsgaremek.repository.AppointmentRepository;
import vizsgaremek.repository.UserRepository;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;
    private final UserRepository userRepository;
    private final DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.GERMAN);

    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Object> getAppointmentByDate(String date) {
        try {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.GERMAN);
            Date wantedDate = dateFormat.parse(date);

            try {
                Appointment searchedAppointment = appointmentRepository.getAppointmentByDate(wantedDate).orElse(null);
                return ResponseEntity.ok().body(searchedAppointment);
            } catch (EmptyResultDataAccessException erdae) {
                return ResponseEntity.ok(null);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Object> bookAppointment(Integer appointmentId, Integer userId) {
        try {
            Appointment searchedAppointment = appointmentRepository.findById(appointmentId).orElse(null);
            User searchedUser = userRepository.findById(userId).orElse(null);
            if (searchedAppointment == null || searchedAppointment.getIsDeleted()) {
                return ResponseEntity.status(404).body("appointmentNotFound");
            } else if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.status(404).body("userNotFound");
            }

            List<Appointment> appointmentList = searchedUser.getBookedAppointments();
            appointmentList.add(searchedAppointment);
            searchedUser.setBookedAppointments(appointmentList);
            userRepository.save(searchedUser);

            return ResponseEntity.ok().body(appointmentRepository.findById(appointmentId).get());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PreAuthorize("hasAnyRole('admin', 'worker')")
    public ResponseEntity<Object> deleteAppointment(Integer appointmentId) {
        try {
            Appointment searchedAppointment = appointmentRepository.findById(appointmentId).orElse(null);
            if (searchedAppointment == null || searchedAppointment.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            } else {
                appointmentRepository.deleteAppointment(appointmentId);
                return ResponseEntity.ok().build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PreAuthorize("hasAnyRole('admin', 'worker')")
    public ResponseEntity<Object> updateAppointment(Integer id, AppointmentDto updatedAppointment) {
        try {
            Appointment searchedAppointment = appointmentRepository.findById(id).orElse(null);
            if (searchedAppointment == null || searchedAppointment.getIsDeleted()) {
                return ResponseEntity.status(404).body("appointmentNotFound");
            }

            User worker = userRepository.findById(updatedAppointment.getWorkerId()).orElse(null);
            if (worker == null || worker.getIsDeleted()) {
                return ResponseEntity.status(404).body("workerNotFound");
            }

            searchedAppointment.setTitle(updatedAppointment.getTitle());
            searchedAppointment.setDate(this.dateFormat.parse(updatedAppointment.getDate()));
            searchedAppointment.setStart(LocalTime.parse(updatedAppointment.getStart()));
            searchedAppointment.setEnd(LocalTime.parse(updatedAppointment.getEnd()));
            searchedAppointment.setIsOnline(updatedAppointment.getIsOnline());
            searchedAppointment.setCapacity(updatedAppointment.getCapacity());
            searchedAppointment.setWorker(worker);

            return ResponseEntity.ok().body(appointmentRepository.save(searchedAppointment));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PreAuthorize("hasAnyRole('admin', 'worker')")
    public ResponseEntity<Object> addAppointment(AppointmentDto newAppointmentDto) {
        try {
            User worker = userRepository.findById(newAppointmentDto.getWorkerId()).orElse(null);
            if (worker == null || worker.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }

            Appointment newAppointment = new Appointment(
                    newAppointmentDto.getCapacity(),
                    newAppointmentDto.getIsOnline(),
                    LocalTime.parse(newAppointmentDto.getEnd()),
                    LocalTime.parse(newAppointmentDto.getStart()),
                    this.dateFormat.parse(newAppointmentDto.getDate()),
                    newAppointmentDto.getTitle(),
                    worker
            );

            try {
                Appointment appointmentAtSameDate = appointmentRepository.getAppointmentByDate(newAppointment.getDate()).orElse(null);
                return ResponseEntity.status(415).body("invalidDate");
            } catch (EmptyResultDataAccessException ex) {
                return ResponseEntity.ok().body(appointmentRepository.save(newAppointment));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
