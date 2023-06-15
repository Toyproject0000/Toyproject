package toyproject.demo.Controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.domain.User;
import toyproject.demo.service.UserService;

@RestController
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/join")
    public String join(User user){
        return userService.join(user);
    }

    @PostMapping("/login")
    public String login(String id, String password){
        return userService.login(id, password);
    }


    @PostMapping
    public String edid(User user){
        return userService.edit(user);
    }

}
