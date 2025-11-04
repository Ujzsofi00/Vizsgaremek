package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.University;
import vizsgaremek.repository.UniversityRepository;

import java.util.List;

@RestController
@RequestMapping("/universities")
@RequiredArgsConstructor
public class UniversityController {

    private final UniversityRepository universityRepository;

    @GetMapping
    public List<University> getAllUniversities() {
        return universityRepository.findAll();
    }

    @GetMapping("/{id}")
    public University getUniversity(@PathVariable Integer id) {
        return universityRepository.findById(id).orElse(null);
    }

    @PostMapping
    public University setUniversity(@RequestBody University university) {
        return universityRepository.save(university);
    }

    @DeleteMapping("/{id}")
    public void deleteUniversity(@PathVariable Integer id) {
        universityRepository.deleteById(id);
    }
}
