package vizsgaremek.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import java.util.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "faculty")
@NamedStoredProcedureQueries({
        @NamedStoredProcedureQuery(name = "getAllFaculties", procedureName = "getAllFaculties", resultClasses = Faculty.class)
})
public class Faculty {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "faculty_id")
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @ManyToMany(mappedBy = "faculties")
    @JsonIgnore
    private List<University> universities;
}
