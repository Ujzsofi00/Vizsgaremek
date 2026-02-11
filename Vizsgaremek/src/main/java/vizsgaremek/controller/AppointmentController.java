package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import tools.jackson.databind.JsonNode;
import vizsgaremek.service.AppointmentService;

@RestController
@RequestMapping("/appointment")
@RequiredArgsConstructor
public class AppointmentController {

    private final AppointmentService appointmentService;

    @GetMapping("")
    private ResponseEntity<Object> getAllAppointment() {
        return appointmentService.getAllAppointment();
    }

    @GetMapping("/{wantedDate}")
    private ResponseEntity<Object> getAppointmentByDate(@PathVariable("wantedDate") String wantedDate) {
        return appointmentService.getAppointmentByDate(wantedDate);
    }

    @PostMapping("/{id}/book")
    private ResponseEntity<Object> bookAppointment(@PathVariable("id") Integer appointmentId, @RequestBody JsonNode requestBody) {
        return appointmentService.bookAppointment(appointmentId, requestBody.get("userId").asInt());
    }

    @DeleteMapping("/{id}")
    private ResponseEntity<Object> deleteAppointment(@PathVariable("id") Integer id) {
        return appointmentService.deleteAppointment(id);
    }
}
