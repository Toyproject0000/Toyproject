package toyproject.demo.Controller.완료;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.converter.FollowConverter;
import toyproject.demo.converter.UserConverter;
import toyproject.demo.domain.DTO.FollowWithTokenDTO;
import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.DTO.UserWithTokenDTO;
import toyproject.demo.domain.Follow;
import toyproject.demo.domain.User;
import toyproject.demo.service.FollowService;
import toyproject.demo.service.JwtTokenUtil;

import java.util.List;

@RestController
@RequestMapping("/follow")
@RequiredArgsConstructor
public class FollowController {

    /*
    * 팔로우 추가
    * 언팔
    * 팔로워 보기
    * 팔로잉 보기
    * */
    private final FollowService followService;
    private final JwtTokenUtil tokenUtil;
    private final FollowConverter followConverter;
    private final UserConverter userConverter;

    @PostMapping("/add")
    public String add(@RequestBody FollowWithTokenDTO tokenFollow){
        try {
            tokenUtil.parseJwtToken(tokenFollow.getToken());
        }catch (Exception e){
            return "cancel";
        }
        Follow follow = followConverter.convert(tokenFollow);
        followService.add(follow);
        return "ok";
    }

    @PostMapping("/remove")
    public String remove(@RequestBody FollowWithTokenDTO tokenFollow){
        try {
            tokenUtil.parseJwtToken(tokenFollow.getToken());
        }catch (Exception e){
            return "cancel";
        }
        Follow follow = followConverter.convert(tokenFollow);
        followService.remove(follow);
        return "ok";
    }

    @PostMapping("/find-follower")
    public List<ProfileViewDTO> findFollower(@RequestBody UserWithTokenDTO tokenUser){
        try {
            tokenUtil.parseJwtToken(tokenUser.getToken());
        }catch (Exception e){
            return null;
        }
        User user = userConverter.convert(tokenUser);
        return followService.findFollower(user);
    }
    @PostMapping("/find-following")
    public List<ProfileViewDTO> findFollowing(@RequestBody UserWithTokenDTO tokenUser){
        try {
            tokenUtil.parseJwtToken(tokenUser.getToken());
        }catch (Exception e){
            return null;
        }
        User user = userConverter.convert(tokenUser);
        return followService.findFollowing(user);
    }
}
