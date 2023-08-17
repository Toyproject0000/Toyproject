package toyproject.demo.Controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.service.*;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import java.util.*;

@RestController
@RequestMapping("/")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final SmsService smsService;
    private final MakeCertificationNumber makeCertificationNumber;
    private final ImgUploadService imgUploadService;

    private final PostService postService;

    @PostMapping(value = "/join", consumes = "application/json")
    public String join(@RequestBody User user){
        return userService.join(user);
    }

    @PostMapping(value = "/login", consumes = "application/json")
    public String login(@RequestBody User user, HttpServletRequest request){
        HttpSession session = request.getSession();
        session.setAttribute("SessionId", user.getId());
        String result = userService.login(user);
        if(!result.equals("ok")) return result;
        return session.getId();
    }

    @PostMapping("logout")
    public void logout(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        session.invalidate();
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
    public String editConfirm(@RequestBody User user, @SessionAttribute("SessionId") String userId){
        return userService.edit(user, userId);
    }
    @PostMapping(value = "/edit-user", consumes = "application/json")
    public String edit(@RequestBody User user, @SessionAttribute("SessionId") String userId) throws JsonProcessingException {
        if(user.getId()!=userId){
            return "잘못된 요청입니다.";
        }
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(userService.findUser(user));
    }

    @PostMapping(value = "/remove", consumes = "application/json")
    public String delete(@RequestBody User user, @SessionAttribute("SessionId") String userId){
        if(user.getId()!=userId){
            return "잘못된 요청입니다.";
        }

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

//    @PostMapping(value = "/authentication", consumes = "application/json")
//    public String authentication(@RequestBody User user) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException{
//        String phoneNumber = user.getPhoneNumber();
//        Random random = new Random();
//        String num = String.valueOf(random.nextInt(100000, 1000000));
//        String number = makeCertificationNumber.makeNumber(num);
//
//        smsService.sendSms(phoneNumber, num);
//
//        return number;
//    }
//
//    @PostMapping(value = "/authentication-check", consumes = "application/json")
//    public Boolean authenticationCheck(@RequestBody Map<String, String> request){
//        String rawNum = request.get("rawNum");
//        String num = request.get("num");
//        return makeCertificationNumber.match(rawNum, num);
//    }

    @PostMapping(value = "/profile/set")
    public String setProfile(@RequestParam(value = "file", required = false) MultipartFile file,
                             @RequestParam String userId,
                             @RequestParam(required = false) String info,
                             @RequestParam(required = false) String nickname,
                             @RequestParam(required = false) String password
                             ){
        try {
            User user = new User();
            user.setId(userId);
            user.setNickname(nickname);
            user.setInfo(info);
            user.setPassword(password);
            if (file!=null)
            {
                String imgUpload = imgUploadService.ProfileImgUpload(file, userId);
                user.setImgLocation(imgUpload);
            }
            userService.edit(user, userId);
        }catch (Exception e){
            System.out.println("e.getMessage() = " + e.getMessage());
            return "cancel";
        }
        return "ok";
    }

    @PostMapping(value = "/profile/view")
    public String ProfileView(@RequestBody User user){
        try {

        }catch (Exception e){
            System.out.println("e.getMessage() = " + e.getMessage());
            return "cancel";
        }
        return "ok";
    }

    @PostMapping("/profile")
    public List<Object> ViewProfile(@RequestBody User user) throws IOException {
        List<Object> result = new ArrayList<>();
        User findUser = userService.findUser(user).get(0);

        result.add(findUser);
        Post post = new Post();
        post.setUserId(user.getId());
        List<Post> posts = postService.search(post, null, null);
        posts.sort(Comparator.comparing(Post::getDate, Comparator.reverseOrder()));
        result.add(posts);

        return result;
    }

}
