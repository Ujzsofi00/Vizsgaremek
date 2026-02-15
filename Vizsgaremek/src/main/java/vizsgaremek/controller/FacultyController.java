package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vizsgaremek.service.FacultyService;


@RestController
@RequestMapping("/faculty")
@RequiredArgsConstructor
public class FacultyController {
    private final FacultyService facultyService;


    @GetMapping("")
    private ResponseEntity<Object> getAllFaculty() {
        return facultyService.getAllFaculty();
    }
}
