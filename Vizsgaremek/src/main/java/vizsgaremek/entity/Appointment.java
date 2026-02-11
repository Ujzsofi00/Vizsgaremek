package vizsgaremek.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "appointment")
@NamedStoredProcedureQueries({
        @NamedStoredProcedureQuery(name = "getAppointmentByDate", procedureName = "getAppointmentByDate", parameters = {
                @StoredProcedureParameter(name = "dateIN", type = Date.class, mode = ParameterMode.IN)
        }, resultClasses = Appointment.class),

        @NamedStoredProcedureQuery(name = "getAllAppointment", procedureName = "getAllAppointment", resultClasses = Appointment.class),

        @NamedStoredProcedureQuery(name = "deleteAppointment", procedureName = "deleteAppointment", parameters = {
                @StoredProcedureParameter(name = "idIN", type = Integer.class, mode = ParameterMode.IN)
        }),
})
public class Appointment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "appointment_id")
    private Integer id;

    @Column(name = "date")
    private LocalDate date;

    @Column(name = "start_time")
    @Temporal(TemporalType.TIME)
    private Date start;

    @Column(name = "end_time")
    @Temporal(TemporalType.TIME)
    private Date end;

    @Column(name = "is_online")
    private Boolean isOnline;

    @Column(name = "capacity")
    private Integer capacity;

    @Column(name = "is_full")
    private Boolean isFull;

    @Column(name = "is_deleted")
    private Boolean isDeleted = false;

    @Column(name = "deleted_at")
    private LocalDate deletedAt;

    @ManyToMany(mappedBy = "bookedAppointments")
    @JsonIgnoreProperties({"bookedAppointments", "workAppointment"})
    private List<User> reserverUsers;

    @ManyToOne(cascade = {})
    @JoinColumn(name = "worker_id")
    @JsonIgnoreProperties({"bookedAppointments", "workAppointment"})
    private User worker;
}
