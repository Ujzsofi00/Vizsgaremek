package vizsgaremek.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.util.*;

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

    @OneToMany(mappedBy = "appointment", cascade = CascadeType.ALL)
    private List<User> users = new ArrayList<>();

    @OneToOne
    @JoinColumn(name = "worker_id")
    private Worker worker;
}
