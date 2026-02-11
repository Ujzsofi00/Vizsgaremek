package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import tools.jackson.databind.JsonNode;
import vizsgaremek.entity.User;
import vizsgaremek.service.UserService;

@RequiredArgsConstructor
@RestController
@RequestMapping("/user")
public class UserController {
    private final UserService userService;

    @PostMapping("/register")
    public ResponseEntity<Object> registerUser(@RequestBody User user) {
        System.out.println(user);
        return userService.register(user);
    }

    @PostMapping("/login")
    public ResponseEntity<Object> login(@RequestBody JsonNode requestBody) {
        return userService.login(requestBody.get("username").asText(null), requestBody.get("password").asText(null));
    }
}
