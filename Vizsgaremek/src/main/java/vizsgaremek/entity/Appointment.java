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
    private Integer id;

    private LocalDate date;
    private Integer capacity;
    private Boolean isFull;

    @ManyToMany(mappedBy = "appointments")
    @JsonIgnore
    private Set<User> users = new HashSet<>();

    @OneToOne
    @JoinColumn(name = "worker_id")
    private Worker worker;
}
