package toyproject.demo.Controller.완료;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import toyproject.demo.converter.UserConverter;
import toyproject.demo.domain.Authentication;
import toyproject.demo.domain.DTO.ProfileDTO;
import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.DTO.UserWithTokenDTO;
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
    private final JwtTokenUtil tokenUtil;
    private final UserConverter userConverter;

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

    @PostMapping(value = "/socialLogin", produces = "application/json;charset=UTF-8")
    public String socialLogin(@RequestBody User user){
        String token = tokenUtil.createToken(user.getId());
        String result = userService.socialLogin(user);
        if(result.equals("id 오류")||result.equals("닉네임 설정 안됨")) return result;

        return "{\"token\" : \"" + token+"\""+ result;
    }


//    @PostMapping(value = "/findId", produces = "application/json;charset=UTF-8")
//    public String findId(@RequestBody User user){
//        return userService.findId(user);
//    }

//    @PostMapping(value = "/findPassword/email", produces = "application/json;charset=UTF-8")
//    public Boolean findPasswordEmail(@RequestBody User user){
//        return userService.findEmail(user);
//    }
//
//    @PostMapping(value = "/findPassword/check", produces = "application/json;charset=UTF-8")
//    public String findPassword(@RequestBody User user){
//        return userService.findPassword(user);
//    }

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
    public String authentication(@RequestBody User user, HttpServletRequest request) {
        try {
            String id = user.getId();
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
    public Boolean authenticationCheck(@RequestBody Authentication data, HttpServletRequest request){
        try {
            String id = data.getId();
            String num = data.getNum();
            HttpSession session = request.getSession(false);
            String realNum = (String)session.getAttribute(id);
            if (realNum.equals(num)){
                session.invalidate();
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
                             @RequestParam String token,
                             @RequestParam(required = false, defaultValue = "false") String basicImage
                             ){
        try {
            tokenUtil.parseJwtToken(token);
        }catch (Exception e){
            return "잘못된 요청입니다.";
        }

        try {
            User user = new User();
            user.setId(userId);
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
            ProfileViewDTO profileView = userService.findUser(id).get(0);

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

        List<ProfileDTO> profile = userService.userProfile(id);

        profile.get(0).setPosts(postService.findByWriter(id));

        return profile;
    }

}