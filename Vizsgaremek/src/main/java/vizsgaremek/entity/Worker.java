package vizsgaremek.entity;

import jakarta.persistence.*;
import lombok.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "worker")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Worker {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String userName;
    private String firstName;
    private String lastName;

    @Column(unique = true)
    private String email;

    private String password;
    private String phone;

    @OneToMany(mappedBy = "worker", cascade = CascadeType.ALL)
    private List<Appointment> appointments = new ArrayList<>();
}
