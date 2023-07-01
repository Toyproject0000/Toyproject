package toyproject.demo.Controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.web.bind.annotation.*;
import toyproject.demo.domain.User;
import toyproject.demo.service.SmsService;
import toyproject.demo.service.UserService;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

@RestController
@RequestMapping("/")
public class UserController {

    /*
    * 회원가입
    * 로그인
    * SMS 인증
    * 아이디찾기
    * 비번 찾기
    * 회원정보수정
    * 회원 탈퇴
    * */
    private final UserService userService;
    private final SmsService smsService;

    public UserController(UserService userService, SmsService smsService) {
        this.userService = userService;
        this.smsService = smsService;
    }

    @PostMapping("/join")
    public String join(@RequestBody User user){
        return userService.join(user);
    }

    @PostMapping("/login")
    public String login(@RequestBody User user){
        return userService.login(user);
    }

    @PostMapping("/findId")
    public String findId(@RequestBody User user){
        return userService.findId(user);
    }

    @PostMapping("/findPassword")
    public String findPassword(@RequestBody User user){
        return userService.findPassword(user);
    }

    @PostMapping("/edit-user")
    public String edit(@RequestBody User user){
        return userService.edit(user);
    }

    @PostMapping("/remove")
    public String delete(@RequestBody User user){
        try {
            userService.delete(user);
            return "ok";
        }catch (Exception e){
            return "에러발생";
        }
    }

    @GetMapping("/authentication ")
    public String authentication(@RequestBody String phoneNumber) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {

        smsService.sendSms(phoneNumber);

        return "ok";
    }
}
