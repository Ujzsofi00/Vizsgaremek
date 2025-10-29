package vizsgaremek.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "worker")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Worker {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer workerId;

    @Column(length = 50, nullable = false)
    private String userName;

    @Column(length = 50, nullable = false)
    private String firstName;

    @Column(length = 50, nullable = false)
    private String lastName;

    @Column(length = 50, nullable = false, unique = true)
    private String email;

    @Column(length = 20, nullable = false)
    private String password;

    @Column(length = 15)
    private String phone;
}
