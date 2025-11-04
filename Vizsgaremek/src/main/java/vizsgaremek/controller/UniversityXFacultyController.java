package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.UniversityXFaculty;
import vizsgaremek.repository.UniversityXFacultyRepository;

import java.util.List;

@RestController
@RequestMapping("/universitiesxfaculties")
@RequiredArgsConstructor
public class UniversityXFacultyController {

    private final UniversityXFacultyRepository repository;

    @GetMapping
    public List<UniversityXFaculty> getAll() {
        return repository.findAll();
    }

    @PostMapping
    public UniversityXFaculty create(@RequestBody UniversityXFaculty uxf) {
        return repository.save(uxf);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        repository.deleteById(id);
    }
}
