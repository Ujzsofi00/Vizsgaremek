package vizsgaremek.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "worker")
public class Worker {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String firstName;
    private String lastName;
    private String email;
    private String password;

    @Column(length = 20, nullable = false)
    private String role = "ROLE_WORKER";

    @ManyToOne
    @JoinColumn(name = "faculty_id")
    private Faculty faculty;

    @OneToOne(mappedBy = "worker", cascade = CascadeType.ALL)
    private Appointment appointment;
}
