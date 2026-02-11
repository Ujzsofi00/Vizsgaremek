package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.entity.University;
import vizsgaremek.service.UniversityService;

@RestController
@RequestMapping("/university")
@RequiredArgsConstructor
public class UniversityController {
    private final UniversityService universityService;

    @GetMapping("/{name}")
    private ResponseEntity<Object> getUniversityByName(@PathVariable("name") String wantedName) {
        return universityService.getUniversityByName(wantedName);
    }

    @GetMapping("")
    private ResponseEntity<Object> getAllUniversity() {
        return universityService.getAllUniversity();
    }

    @PostMapping("")
    private ResponseEntity<Object> addUniversity(@RequestBody University newUniversity) {
        return universityService.addUniversity(newUniversity);
    }

    @PutMapping("")
    private ResponseEntity<Object> updateUniversity(@RequestBody University updatedUniversity) {
        return universityService.updateUniversity(updatedUniversity);
    }

    @DeleteMapping("/{id}")
    private ResponseEntity<Object> deleteUniversity(@PathVariable("id") Integer id) {
        return universityService.deleteUniversity(id);
    }
}
