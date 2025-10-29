package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.Faculty;
import vizsgaremek.service.FacultyService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/faculties")
@RequiredArgsConstructor
public class FacultyController {

    private final FacultyService facultyService;

    @GetMapping
    public List<Faculty> getAll() {
        return facultyService.findAll();
    }

    @GetMapping("/{id}")
    public Optional<Faculty> getById(@PathVariable int id) {
        return facultyService.findById(id);
    }

    @PostMapping
    public Faculty create(@RequestBody Faculty faculty) {
        return facultyService.save(faculty);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable int id) {
        facultyService.deleteById(id);
    }
}
