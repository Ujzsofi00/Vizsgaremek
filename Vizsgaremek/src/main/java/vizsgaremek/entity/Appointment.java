package vizsgaremek.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "appointment")
public class Appointment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "appointment_id")
    private Integer appointmentId;

    @Column(name = "date")
    private LocalDate date;

    @Column(name = "capacity")
    private Integer capacity;

    @Column(name = "is_full")
    private Boolean isFull;

    @Column(name = "is_deleted")
    private Boolean isDeleted = false;

    @Column(name = "deleted_at")
    private LocalDate deletedAt;

    @ManyToMany(mappedBy = "appointments")
    @JsonIgnore
    private Set<User> users = new HashSet<>();

    @ManyToOne
    @JoinColumn(name = "worker_id")
    private Worker worker;
}
