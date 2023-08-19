package toyproject.demo.Controller.완료;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import toyproject.demo.domain.DTO.ProfileDTO;
import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.User;
import toyproject.demo.service.*;


import java.io.IOException;
import java.util.*;

@RestController
@RequestMapping("/")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final MailService mailService;
    private final ImgUploadService imgUploadService;

    private final PostService postService;

    @PostMapping(value = "/join", produces = "application/json;charset=UTF-8")
    public String join(@RequestBody User user){
        return userService.join(user);
    }

    @PostMapping(value = "/login", produces = "application/json;charset=UTF-8")
    public String login(@RequestBody User user, HttpServletRequest request){
        HttpSession session = request.getSession();
        session.setAttribute("SessionId", user.getId());
        String result = userService.login(user);
        if(!result.equals("ok")) return result;
        return session.getId();
    }

    @PostMapping(value = "/findId", produces = "application/json;charset=UTF-8")
    public String findId(@RequestBody User user){
        return userService.findId(user);
    }

    @PostMapping(value = "/findPassword/email", produces = "application/json;charset=UTF-8")
    public Boolean findPasswordEmail(@RequestBody User user){
        return userService.findEmail(user);
    }

    @PostMapping(value = "/findPassword/check", produces = "application/json;charset=UTF-8")
    public String findPassword(@RequestBody User user){
        return userService.findPassword(user);
    }

    @PostMapping(value = "/remove", produces = "application/json;charset=UTF-8")
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
    @PostMapping(value = "/nickname", produces = "application/json;charset=UTF-8")
    public String duplicateNickname(@RequestBody User user){
        return userService.duplicateNick(user);
    }

    @PostMapping(value = "/authentication", produces = "application/json;charset=UTF-8")
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

    @PostMapping(value = "/authentication-check", produces = "application/json;charset=UTF-8")
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
    @PostMapping(value = "/profile/set", produces = "application/json;charset=UTF-8")
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
            if (file!=null&&!file.isEmpty())
            {
                String imgUpload = imgUploadService.ProfileImgUpload(file, userId);
                user.setImgLocation(imgUpload);
            }
            if (file.getSize()==0){
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
    public ProfileViewDTO ProfileView(@RequestBody User user){
        try {
            String id = user.getId();
            User findUser = userService.findUser(id).get(0);
            ProfileViewDTO profileView = new ProfileViewDTO(findUser.getNickname(), findUser.getInfo(), findUser.getImgLocation());

            return profileView;
        }catch (Exception e){
            System.out.println("e.getMessage() = " + e.getMessage());
        }
        return null;
    }

    @PostMapping(value = "/profile", produces = "application/json;charset=UTF-8")
    public List<ProfileDTO> ViewProfile(@RequestBody User user){
        String id = user.getId();

        List<ProfileDTO> profile = userService.userProfile(id);

        profile.get(0).setPosts(postService.findByWriter(id));

        return profile;
    }

}