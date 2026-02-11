package vizsgaremek.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "username")
    private String username;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "is_deleted")
    private Boolean isDeleted = false;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;


    @ManyToOne(cascade = {})
    @JoinColumn(name = "role_id")
    private Role role;

    @ManyToMany()
    @JoinTable(
            name = "userxappointment",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "appointment_id")
    )
    @JsonIgnoreProperties({"reserverUsers"})
    private List<Appointment> bookedAppointments;

    @OneToMany(mappedBy = "worker")
    @JsonIgnoreProperties({"reserverUsers"})
    private List<Appointment> workAppointment;
}
