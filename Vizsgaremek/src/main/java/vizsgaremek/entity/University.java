package vizsgaremek.entity;

import jakarta.persistence.*;
import lombok.*;
import java.util.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "university")
public class University {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;
    private String location;

    @OneToMany(mappedBy = "university", cascade = CascadeType.ALL)
    private List<Faculty> faculties = new ArrayList<>();
}
