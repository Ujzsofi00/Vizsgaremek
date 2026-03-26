package vizsgaremek.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import vizsgaremek.dto.AppointmentDto;
import vizsgaremek.entity.Appointment;
import vizsgaremek.entity.Users;
import vizsgaremek.repository.AppointmentRepository;
import vizsgaremek.repository.UserRepository;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AppointmentServiceTest {

    @Mock
    private AppointmentRepository appointmentRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private AppointmentService appointmentService;

    private Users worker;
    private Appointment appointment;

    @BeforeEach
    void setUp() {
        worker = new Users();
        worker.setId(1);
        worker.setIsDeleted(false);
        worker.setBookedAppointments(new ArrayList<>());

        appointment = new Appointment(
                5,
                true,
                LocalTime.of(11, 0),
                LocalTime.of(10, 0),
                new Date(),
                "Consultation",
                worker
        );
        appointment.setId(1);
        appointment.setIsDeleted(false);
    }

    @Test
    void bookAppointment_WhenAppointmentNotFound_Returns404() {
        when(appointmentRepository.findById(1)).thenReturn(Optional.empty());
        when(userRepository.findById(1)).thenReturn(Optional.of(worker));

        ResponseEntity<Object> response = appointmentService.bookAppointment(1, 1);

        assertEquals(HttpStatus.NOT_FOUND, response.getStatusCode());
        assertEquals("appointmentNotFound", response.getBody());
    }

    @Test
    void addAppointment_ValidWorker_ReturnsOk() {
        AppointmentDto dto = new AppointmentDto(
                "New Appointment",
                "2026-04-10",
                "09:00",
                "10:00",
                true,
                10,
                1
        );

        when(userRepository.findById(1)).thenReturn(Optional.of(worker));
        when(appointmentRepository.save(any(Appointment.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        ResponseEntity<Object> response = appointmentService.addAppointment(dto);

        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
    }

    @Test
    void updateAppointment_WhenWorkerMissing_Returns404() {
        AppointmentDto dto = new AppointmentDto(
                "Updated",
                "2026-04-10",
                "09:00",
                "10:00",
                false,
                8,
                2
        );

        when(appointmentRepository.findById(1)).thenReturn(Optional.of(appointment));
        when(userRepository.findById(2)).thenReturn(Optional.empty());

        ResponseEntity<Object> response = appointmentService.updateAppointment(1, dto);

        assertEquals(HttpStatus.NOT_FOUND, response.getStatusCode());
        assertEquals("workerNotFound", response.getBody());
    }
}