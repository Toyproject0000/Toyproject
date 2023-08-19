package toyproject.demo.Controller.완료;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import toyproject.demo.domain.DTO.ProfileDTO;
import toyproject.demo.domain.User;
import toyproject.demo.service.*;


import java.util.*;

@RestController
@RequestMapping("/")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final MailService mailService;
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
    public String authentication(@RequestParam String id, HttpServletRequest request) {
        try {
            String num = mailService.sendMail(id);
            HttpSession session = request.getSession();
            session.setAttribute(id, num);
            return "ok";
        }catch (Exception e){
            System.out.println(e.getMessage());
        }

        return "cancel";
    }

    @PostMapping(value = "/authentication-check", consumes = "application/json")
    public Boolean authenticationCheck(@RequestParam String id, String num, HttpServletRequest request){
        HttpSession session = request.getSession(false);
        String realNum = (String)session.getAttribute(id);
        if (realNum.equals(num)){
            session.invalidate();
            return true;
        }
        return false;
    }

    /**
     */
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
    public List<User> ProfileView(@RequestBody User user){
        try {
            String id = user.getId();
            List<User> findUser = userService.findUser(id);

            return findUser;
        }catch (Exception e){
            System.out.println("e.getMessage() = " + e.getMessage());
        }
        return null;
    }

    @PostMapping("/profile")
    public List<ProfileDTO> ViewProfile(@RequestBody User user){
        String id = user.getId();

        List<ProfileDTO> profile = userService.userProfile(id);

        profile.get(0).setPosts(postService.findByWriter(id));

        return profile;
    }

}