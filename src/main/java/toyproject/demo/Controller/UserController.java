package toyproject.demo.Controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.web.bind.annotation.*;
import toyproject.demo.domain.User;
import toyproject.demo.service.MakeCertificationNumber;
import toyproject.demo.service.SmsService;
import toyproject.demo.service.UserService;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;
import java.util.Random;

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
    private final MakeCertificationNumber makeCertificationNumber;

    public UserController(UserService userService, SmsService smsService, MakeCertificationNumber makeCertificationNumber) {
        this.userService = userService;
        this.smsService = smsService;
        this.makeCertificationNumber = makeCertificationNumber;
    }

    @PostMapping(value = "/join", consumes = "application/json")
    public String join(@RequestBody User user){
        return userService.join(user);
    }

    @PostMapping(value = "/login", consumes = "application/json")
    public String login(@RequestBody User user){
        return userService.login(user);
    }

    @PostMapping(value = "/findId", consumes = "application/json")
    public String findId(@RequestBody User user){
        return userService.findId(user);
    }

    @PostMapping(value = "/findPassword/email", consumes = "application/json")
    public Boolean findPasswordEmail(@RequestBody User user){
        return userService.findEmail(user);
    }

    @PostMapping(value = "/findPassword/check", consumes = "application/json")
    public String findPassword(@RequestBody User user){
        return userService.findPassword(user);
    }

    @PostMapping(value = "/setPassword", consumes = "application/json")
    public String setPassword(@RequestBody User user){
        return userService.setPassword(user);
    }

    @PostMapping(value = "/edit-user/confirm", consumes = "application/json")
    public String editConfirm(@RequestBody User user){
        return userService.edit(user);
    }
    @PostMapping(value = "/edit-user", consumes = "application/json")
    public String edit(@RequestBody User user) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(userService.findUser(user));
    }

    @PostMapping(value = "/remove", consumes = "application/json")
    public String delete(@RequestBody User user){
        String login = userService.login(user);
        if(login=="ok"){
        try {
            userService.delete(user);
            return "ok";
        }catch (Exception e){
            return "에러발생";
        }}
        else return login;
    }
    @PostMapping(value = "/nickname", consumes = "application/json")
    public String duplicateNickname(@RequestBody User user){
        return userService.duplicateNick(user);
    }

    @PostMapping(value = "/authentication", consumes = "application/json")
    public String authentication(@RequestBody User user) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException{
        String phoneNumber = user.getPhoneNumber();
        Random random = new Random();
        String num = String.valueOf(random.nextInt(100000, 1000000));
        String number = makeCertificationNumber.makeNumber(num);

        smsService.sendSms(phoneNumber, num);

        return number;
    }

    @PostMapping(value = "/authentication-check", consumes = "application/json")
    public Boolean check(@RequestBody Map<String, String> request){
        String rawNum = request.get("rawNum");
        String num = request.get("num");
        return makeCertificationNumber.match(rawNum, num);
    }


    @PostMapping(value = "/profile/{userId}", consumes = "application/json")
    public User profile(@PathVariable String userId){
        return null;
    }
}
