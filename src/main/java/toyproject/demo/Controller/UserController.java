package toyproject.demo.Controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.domain.User;
import toyproject.demo.service.SmsService;
import toyproject.demo.service.UserService;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

@RestController("/")
public class UserController {
    private final UserService userService;
    private final SmsService smsService;

    public UserController(UserService userService, SmsService smsService) {
        this.userService = userService;
        this.smsService = smsService;
    }

    @PostMapping("/join")
    public String join(User user){
        return userService.join(user);
    }

    @PostMapping("/login")
    public String login(String id, String password){

        if (userService.loginId(id).equals("ID가 틀림")){
            return "ID가 틀림";
        }

        if (userService.loginPassword(password).equals("비번이 틀림")){
            return "비번이 틀림";
        }

        return "ok";
    }

    @PostMapping("/edit")
    public String edit(User user){
        return userService.edit(user);
    }

    @GetMapping("/authentication ")
    public String authentication(String phoneNumber) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {

        smsService.sendSms(phoneNumber);

        return "ok";
    }





}
