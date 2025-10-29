package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.University;
import vizsgaremek.service.UniversityService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/universities")
@RequiredArgsConstructor
public class UniversityController {

    private final UniversityService universityService;

    @GetMapping
    public List<University> getAll() { return universityService.findAll(); }

    @GetMapping("/{id}")
    public Optional<University> getById(@PathVariable int id) { return universityService.findById(id); }

    @PostMapping
    public University create(@RequestBody University university) { return universityService.save(university); }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable int id) { universityService.deleteById(id); }
}
