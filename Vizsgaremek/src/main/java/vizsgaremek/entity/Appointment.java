package vizsgaremek.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Getter
@Setter
@NoArgsConstructor
//@AllArgsConstructor
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

    @Column(name = "title")
    private String title;

    @Column(name = "date")
    private Date date;

    @Column(name = "start_time")
    private LocalTime start;

    @Column(name = "end_time")
    private LocalTime end;

    @Column(name = "is_online")
    private Boolean isOnline;

    @Column(name = "capacity")
    private Integer capacity;

    @Column(name = "is_full")
    private Boolean isFull = false;

    @Column(name = "is_deleted")
    private Boolean isDeleted = false;

    @Column(name = "deleted_at")
    private LocalDate deletedAt;

    @ManyToMany(mappedBy = "bookedAppointments")
    @JsonIgnoreProperties({"bookedAppointments", "workAppointment"})
    private List<Users> reserverUsers;

    @ManyToOne()
    @JoinColumn(name = "worker_id")
    @JsonIgnoreProperties({"bookedAppointments", "workAppointment"})
    private Users worker;

    public Appointment(Integer capacity, Boolean isOnline, LocalTime end, LocalTime start, Date date, String title, Users worker) {
        this.title = title;
        this.date = date;
        this.capacity = capacity;
        this.isOnline = isOnline;
        this.end = end;
        this.start = start;
        this.worker = worker;
    }
}
