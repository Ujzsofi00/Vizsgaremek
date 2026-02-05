package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vizsgaremek.dto.CalendarDayDto;
import vizsgaremek.entity.Appointment;
import vizsgaremek.entity.User;
import vizsgaremek.repository.AppointmentRepository;
import vizsgaremek.repository.UserRepository;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.*;

@Service
@RequiredArgsConstructor
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;
    private final UserRepository userRepository;

    public List<CalendarDayDto> getCalendarForMonth(int year, int month) {

        YearMonth yearMonth = YearMonth.of(year, month);
        LocalDate start = yearMonth.atDay(1);
        LocalDate end = yearMonth.atEndOfMonth();
        LocalDate today = LocalDate.now();

        List<Appointment> appointments =
                appointmentRepository.findByDateBetweenAndIsDeletedFalse(start, end);

        Map<LocalDate, Appointment> appointmentMap = new HashMap<>();
        for (Appointment appointment : appointments) {
            appointmentMap.put(appointment.getDate(), appointment);
        }

        List<CalendarDayDto> calendar = new ArrayList<>();

        for (int day = 1; day <= yearMonth.lengthOfMonth(); day++) {
            LocalDate date = yearMonth.atDay(day);

            Appointment appointment = appointmentMap.get(date);

            boolean isToday = date.equals(today);

            if (appointment == null) {
                calendar.add(new CalendarDayDto(
                        date,
                        isToday,
                        false,
                        false
                ));
            } else {
                boolean isFull = Boolean.TRUE.equals(appointment.getIsFull());
                boolean isBookable = !isFull && appointment.getCapacity() > 0;

                calendar.add(new CalendarDayDto(
                        date,
                        isToday,
                        isFull,
                        isBookable
                ));
            }
        }

        return calendar;
    }

    public List<Appointment> getAllAppointments() {
        return appointmentRepository.findAll();
    }

    public Optional<Appointment> getAppointmentById(Integer id) {
        return appointmentRepository.findById(id);
    }

    public Appointment saveAppointment(Appointment appointment) {
        return appointmentRepository.save(appointment);
    }

    public void deleteAppointment(Integer id) {
        appointmentRepository.deleteById(id);
    }

    @Transactional
    public void bookAppointment(Integer appointmentId, Integer userId) {

        Appointment appointment = appointmentRepository
                .findByAppointmentIdAndIsDeletedFalse(appointmentId)
                .orElseThrow(() -> new RuntimeException("Appointment not found"));

        if (Boolean.TRUE.equals(appointment.getIsFull())) {
            throw new RuntimeException("Appointment is already full");
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        boolean alreadyBooked = user.getAppointments().stream()
                .anyMatch(a -> a.getAppointmentId().equals(appointmentId));

        if (alreadyBooked) {
            throw new RuntimeException("User already booked this appointment");
        }

        user.getAppointments().add(appointment);
        appointment.getUsers().add(user);

        appointment.setCapacity(appointment.getCapacity() - 1);

        if (appointment.getCapacity() <= 0) {
            appointment.setIsFull(true);
        }

        appointmentRepository.save(appointment);
        userRepository.save(user);
    }

}
