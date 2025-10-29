package vizsgaremek.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import vizsgaremek.entity.University;
import vizsgaremek.repository.UniversityRepository;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UniversityService {
    private final UniversityRepository universityRepository;

    public List<University> findAll() { return universityRepository.findAll(); }

    public Optional<University> findById(int id) { return universityRepository.findById(id); }

    public University save(University university) { return universityRepository.save(university); }

    public void deleteById(int id) { universityRepository.deleteById(id); }
}
