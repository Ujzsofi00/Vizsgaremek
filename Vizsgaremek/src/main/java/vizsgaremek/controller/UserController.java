package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import tools.jackson.databind.JsonNode;
import vizsgaremek.entity.Users;
import vizsgaremek.service.UserService;

@RequiredArgsConstructor
@RestController
@RequestMapping("/user")
public class UserController {
    private final UserService userService;

    @PostMapping("/register")
    public ResponseEntity<Object> registerUser(@RequestBody Users user) {
        return userService.register(user);
    }

    @PostMapping("/login")
    public ResponseEntity<Object> login(@RequestBody JsonNode requestBody) {
        return userService.login(requestBody.get("username").asString(null), requestBody.get("password").asText(null));
    }

    @GetMapping("")
    public ResponseEntity<Object> getAllUser() {
        return userService.getAllUser();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Object> deleteUser(@PathVariable("id") Integer id) {
        return userService.deleteUser(id);
    }

    @PatchMapping("/{id}")
    public ResponseEntity<Object> changeRoleOfUser(@PathVariable("id") Integer id) {
        return userService.changeRoleOfUser(id);
    }

    @GetMapping("/worker")
    public ResponseEntity<Object> getAllWorker() {
        return userService.getAllWorker();
    }
}
