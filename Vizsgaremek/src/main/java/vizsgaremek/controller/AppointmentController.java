package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import tools.jackson.databind.JsonNode;
import vizsgaremek.dto.AppointmentDto;
import vizsgaremek.service.AppointmentService;

@RestController
@RequestMapping("/appointment")
@RequiredArgsConstructor
public class AppointmentController {

    private final AppointmentService appointmentService;

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

    @PutMapping("/{id}")
    private ResponseEntity<Object> updateAppointment(@PathVariable("id") Integer id, @RequestBody AppointmentDto updatedAppointment) {
        return appointmentService.updateAppointment(id, updatedAppointment);
    }

    @PostMapping
    private ResponseEntity<Object> addAppointment(@RequestBody AppointmentDto newAppointment) {
        return appointmentService.addAppointment(newAppointment);
    }

    @GetMapping("/user/{id}")
    private ResponseEntity<Object> getAppointmentsByUser(@PathVariable Integer id) {
        return appointmentService.getAppointmentByUser(id);
    }
}
