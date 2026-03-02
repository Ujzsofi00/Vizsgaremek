package vizsgaremek.exception;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Map;

@RestControllerAdvice
public class ExceptionHandler {

    @org.springframework.web.bind.annotation.ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<Object> handleDataIntegrityViolation(DataIntegrityViolationException ex) {
        if (ex.getMessage().contains("for key 'Email'")) {
            return ResponseEntity.status(409).body(Map.of("statusText", "duplicateEmail"));
        } else if (ex.getMessage().contains("for key 'date'")) {
            return ResponseEntity.status(409).body(Map.of("statusText", "duplicateDate"));
        } else if (ex.getMessage().contains("for key 'UserName'")) {
            return ResponseEntity.status(409).body(Map.of("statusText", "duplicateUsername"));
        }
        return ResponseEntity.internalServerError().build();
    }
}
