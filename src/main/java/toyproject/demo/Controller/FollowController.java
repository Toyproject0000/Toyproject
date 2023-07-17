package toyproject.demo.Controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.domain.Follow;
import toyproject.demo.domain.User;
import toyproject.demo.service.FollowService;

@RestController
@RequestMapping("/follow")
public class FollowController {

    /*
    * 팔로우 추가
    * 언팔
    * 팔로워 보기
    * 팔로잉 보기
    * */
    private final FollowService followService;

    public FollowController(FollowService followService) {
        this.followService = followService;
    }

    @PostMapping("/add")
    public void add(@RequestBody Follow follow){
        followService.add(follow);
    }

    @PostMapping("/remove")
    public void remove(@RequestBody Follow follow){
        followService.remove(follow);
    }

    @PostMapping("/find-follower")
    public void findFollower(@RequestBody User user){
        followService.findFollower(user);
    }
    @PostMapping("/find-following")
    public void findFollowing(@RequestBody User user){
        followService.findFollowing(user);
    }
}
