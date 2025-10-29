package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import vizsgaremek.entity.Faculty;
import vizsgaremek.repository.FacultyRepository;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class FacultyService {
    private final FacultyRepository facultyRepository;

    public List<Faculty> findAll() { return facultyRepository.findAll(); }

    public Optional<Faculty> findById(int id) { return facultyRepository.findById(id); }

    public Faculty save(Faculty faculty) { return facultyRepository.save(faculty); }

    public void deleteById(int id) { facultyRepository.deleteById(id); }
}
