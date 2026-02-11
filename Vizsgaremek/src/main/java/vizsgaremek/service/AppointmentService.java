package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vizsgaremek.entity.Appointment;
import vizsgaremek.repository.AppointmentRepository;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;

    public ResponseEntity<Object> getAllAppointment() {
        try {
            return ResponseEntity.ok(appointmentRepository.getAllAppointment());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

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

    public ResponseEntity<Object> bookAppointment(Integer appointmentId, Integer userId) {
        try {


            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }


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
}
