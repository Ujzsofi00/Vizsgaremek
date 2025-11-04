package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.Faculty;
import vizsgaremek.repository.FacultyRepository;

import java.util.List;

@RestController
@RequestMapping("/faculties")
@RequiredArgsConstructor
public class FacultyController {

    private final FacultyRepository facultyRepository;

    @GetMapping
    public List<Faculty> getAllFaculties() {
        return facultyRepository.findAll();
    }

    @GetMapping("/{id}")
    public Faculty getFaculty(@PathVariable Integer id) {
        return facultyRepository.findById(id).orElse(null);
    }

    @PostMapping
    public Faculty setFaculty(@RequestBody Faculty faculty) {
        return facultyRepository.save(faculty);
    }

    @DeleteMapping("/{id}")
    public void deleteFaculty(@PathVariable Integer id) {
        facultyRepository.deleteById(id);
    }
}
