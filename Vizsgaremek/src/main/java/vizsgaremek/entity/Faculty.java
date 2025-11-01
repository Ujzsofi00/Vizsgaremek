package vizsgaremek.entity;

import jakarta.persistence.*;
import lombok.*;
import java.util.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "faculty")
public class Faculty {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;
    private String description;

    @OneToMany(mappedBy = "faculty", cascade = CascadeType.ALL)
    private List<Worker> workers = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "university_id")
    private University university;
}
