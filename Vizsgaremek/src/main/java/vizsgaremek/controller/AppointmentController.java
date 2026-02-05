package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.dto.CalendarDayDto;
import vizsgaremek.entity.Appointment;
import vizsgaremek.service.AppointmentService;
import vizsgaremek.dto.BookingRequestDto;


import java.util.List;

@RestController
@RequestMapping("/appointments")
@RequiredArgsConstructor
public class AppointmentController {

    private final AppointmentService appointmentService;

    @GetMapping
    public List<Appointment> getAllAppointments() {
        return appointmentService.getAllAppointments();
    }

    @GetMapping("/{id}")
    public Appointment getAppointment(@PathVariable Integer id) {
        return appointmentService.getAppointmentById(id).orElse(null);
    }

    @PostMapping
    public Appointment setAppointment(@RequestBody Appointment appointment) {
        return appointmentService.saveAppointment(appointment);
    }

    @DeleteMapping("/{id}")
    public void deleteAppointment(@PathVariable Integer id) {
        appointmentService.deleteAppointment(id);
    }

    @GetMapping("/calendar")
    public List<CalendarDayDto> getCalendar(
            @RequestParam int year,
            @RequestParam int month
    ) {
        return appointmentService.getCalendarForMonth(year, month);
    }

    @PostMapping("/{appointmentId}/book")
    public String bookAppointment(
            @PathVariable Integer appointmentId,
            @RequestBody BookingRequestDto request
    ) {
        appointmentService.bookAppointment(
                appointmentId,
                request.getUserId()
        );
        return "Appointment booked successfully";
    }


}
