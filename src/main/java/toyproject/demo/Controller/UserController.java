package toyproject.demo.Controller;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.data.relational.core.sql.In;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import toyproject.demo.converter.UserConverter;
import toyproject.demo.domain.Authentication;
import toyproject.demo.domain.DTO.ProfileDTO;
import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.DTO.UserWithTokenDTO;
import toyproject.demo.domain.FCMNotificationRequestDto;
import toyproject.demo.domain.User;
import toyproject.demo.repositoryImpl.AuthenticationRepositoryImpl;
import toyproject.demo.service.*;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.util.*;

@RestController
@RequestMapping("/")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final MailService mailService;
    private final ImgUploadService imgUploadService;
    private final PostService postService;
    private final JwtTokenUtil tokenUtil;
    private final UserConverter userConverter;
    private final AuthenticationRepositoryImpl authenticationRepository;

    @PostMapping(value = "/join", produces = "application/json;charset=UTF-8")
    public String join(@RequestBody User user){
        return userService.join(user);
    }

    @PostMapping(value = "/login", produces = "application/json;charset=UTF-8")
    public String login(@RequestBody User user){
        String token = tokenUtil.createToken(user.getId());
        String result = userService.login(user);
        if(result.equals("id 오류")||result.equals("비번 오류")||result.equals("닉네임 설정 안됨")) return result;

        return "{\"token\" : \"" + token+"\""+ result;
    }

    @PostMapping(value = "/getToken", produces = "application/json;charset=UTF-8")
    public void getToken(@RequestBody FCMNotificationRequestDto fcm){
        userService.setToken(fcm);
    }

    @PostMapping(value = "/socialLogin", produces = "application/json;charset=UTF-8")
    public String socialLogin(@RequestBody User user){
        String token = tokenUtil.createToken(user.getId());
        String result = userService.socialLogin(user);
        if(result.equals("id 오류")||result.equals("닉네임 설정 안됨")) return result;

        return "{\"token\" : \"" + token+"\""+ result;
    }


    @PostMapping(value = "/findId", produces = "application/json;charset=UTF-8")
    public String findId(@RequestBody User user, HttpServletRequest request) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException {
        String random = String.valueOf(new Random().nextInt(100000,1000000));
        HttpSession session = request.getSession();
        session.setAttribute(user.getPhoneNumber(), random);
        return userService.findId(user, random);
    }

    @PostMapping(value = "/check-phone", produces = "application/json;charset=UTF-8")
    public String checkPhone(@RequestBody Data user, HttpServletRequest request){
        HttpSession session = request.getSession();
        String realNum = (String) session.getAttribute(user.getPhoneNumber());
        if (realNum.equals(user.getNum())){
            session.invalidate();
            return userService.findIdCheck(user.getPhoneNumber());
        }
        return "인증번호가 틀렸습니다.";
    }

    @Getter
    @Setter
    private static class Data{
        String phoneNumber;
        String num;
        String id;
    }

    @PostMapping(value = "/findPassword/email", produces = "application/json;charset=UTF-8")
    public Boolean findPasswordEmail(@RequestBody User user){
        return userService.findEmail(user);
    }
    @PostMapping(value = "/findPassword", produces = "application/json;charset=UTF-8")
    public Boolean findPassword(@RequestBody Data user){
        return userService.findPassword(user.getId(), user.getNum());
    }

    @PostMapping(value = "/setPassword", produces = "application/json;charset=UTF-8")
    public String setPassword(@RequestBody User user){
        return userService.setPassword(user);
    }

    @PostMapping(value = "/remove", produces = "application/json;charset=UTF-8")
    public String delete(@RequestBody UserWithTokenDTO tokenUser){
        try {
            tokenUtil.parseJwtToken(tokenUser.getToken());
        }catch (Exception e){
            return "잘못된 요청입니다.";
        }

        User user = userConverter.convert(tokenUser);

        try {
            userService.delete(user);
        }catch (Exception e){
            return "에러발생";
        }
        return "ok";
    }
    @PostMapping(value = "/nickname", produces = "application/json;charset=UTF-8")
    public String duplicateNickname(@RequestBody User user){
        return userService.duplicateNick(user);
    }

    @PostMapping(value = "/authentication", produces = "application/json;charset=UTF-8")
    public String authentication(@RequestBody User user) {
        try {
            String id = user.getId();
            String num = mailService.sendMail(id);
            authenticationRepository.insert(id, num);
            return "ok";
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return "cancel";
    }

    @PostMapping(value = "/authentication-check", produces = "application/json;charset=UTF-8")
    @Transactional
    public Boolean authenticationCheck(@RequestBody Authentication data){
        try {
            String id = data.getId();
            Integer num = data.getNum();
            Integer realNum = authenticationRepository.find(id);
            if (realNum.equals(num)){
                authenticationRepository.delete(id);
                return true;
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return false;
    }
    /**
     *
     */
    @PostMapping(value = "/profile/set", produces = "application/json;charset=UTF-8")
    public String setProfile(@RequestParam(value = "file", required = false) MultipartFile file,
                             @RequestParam String userId,
                             @RequestParam(required = false) String info,
                             @RequestParam(required = false) String nickname,
                             @RequestParam(required = false) String password,
                             @RequestParam(required = false) String name,
                             @RequestParam(required = false) LocalDate birth,
                             @RequestParam String token,
                             @RequestParam(required = false, defaultValue = "false") String basicImage
                             ){
        try {
            tokenUtil.parseJwtToken(token);
        }catch (Exception e){
            System.out.println(e.getMessage());
            return "잘못된 요청입니다.";
        }

        try {
            User user = new User();
            user.setId(userId);
            user.setBirth(birth);
            user.setNickname(nickname);
            user.setName(name);
            user.setInfo(info);
            user.setPassword(password);
            if (file!=null&&!file.isEmpty())
            {
                String imgUpload = imgUploadService.ProfileImgUpload(file, userId);
                user.setImgLocation(imgUpload);
            }
            if (basicImage.equals("true")){
                user.setImgLocation("");
            }
            userService.edit(user, userId);
        }catch (Exception e){
            System.out.println("e.getMessage() = " + e.getMessage());
            return "cancel";
        }
        return "ok";
    }

    @PostMapping(value = "/profile/view", produces = "application/json;charset=UTF-8")
    public ProfileViewDTO ProfileView(@RequestBody UserWithTokenDTO tokenUser){
        try {
            tokenUtil.parseJwtToken(tokenUser.getToken());
        }catch (Exception e){
            return null;
        }
        User user = userConverter.convert(tokenUser);
        try {
            String id = user.getId();
            ProfileViewDTO profileView = userService.findUser(id, user.getRoot()).get(0);

            return profileView;
        }catch (Exception e){
            System.out.println("e.getMessage() = " + e.getMessage());
        }
        return null;
    }

    @PostMapping(value = "/profile", produces = "application/json;charset=UTF-8")
    public List<ProfileDTO> ViewProfile(@RequestBody UserWithTokenDTO tokenUser){
        try {
            tokenUtil.parseJwtToken(tokenUser.getToken());
        }catch (Exception e){
            return null;
        }
        User user = userConverter.convert(tokenUser);

        String id = user.getId();

        List<ProfileDTO> profile = userService.userProfile(id, user.getRoot(), tokenUser.getLoginId(), tokenUser.getLoginRoot());

        profile.get(0).setPosts(postService.findByWriter(id, user.getRoot()));

        return profile;
    }

}