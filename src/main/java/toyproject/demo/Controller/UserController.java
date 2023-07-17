package toyproject.demo.Controller;

import com.fasterxml.jackson.core.JsonProcessingException;
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
    @PostMapping("/nickname")
    public String duplicateNickname(@RequestBody User user){
        return userService.duplicateNick(user);
    }

    @PostMapping("/authentication")
    public String authentication(@RequestBody String phoneNumber) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        Random random = new Random();
        String num = String.valueOf(random.nextInt(100000, 1000000));
        String number = makeCertificationNumber.makeNumber(num);

        smsService.sendSms(phoneNumber, num);

        return "number";
    }

    @PostMapping("/authentication-check")
    public Boolean check(@RequestBody String rawNum, String num){
        return makeCertificationNumber.match(rawNum, num);
    }
}
