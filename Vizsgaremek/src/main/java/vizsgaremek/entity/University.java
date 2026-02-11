package vizsgaremek.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "university")
@NamedStoredProcedureQueries({
        @NamedStoredProcedureQuery(name = "getUniversityByName", procedureName = "getUniversityByName", parameters = {
                @StoredProcedureParameter(name = "nameIN", mode = ParameterMode.IN, type = String.class),
        }, resultClasses = University.class),
        @NamedStoredProcedureQuery(name= "getAllUniversities", procedureName = "getAllUniversities", resultClasses = University.class),
        @NamedStoredProcedureQuery(name = "deleteUniversity", procedureName = "deleteUniversity", parameters = {
                @StoredProcedureParameter(name = "idIN", type = Integer.class, mode = ParameterMode.IN)
        })
})
public class University {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "university_id")
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "address")
    private String address;

    @Column(name = "google_maps_link")
    private String googleMapsLink;

    @Column(name = "is_deleted")
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;

    @ManyToMany()
    @JoinTable(
            name = "universityxfaculty",
            joinColumns = @JoinColumn(name = "university_id"),
            inverseJoinColumns = @JoinColumn(name = "faculty_id")
    )
    private List<Faculty> faculties;
}
