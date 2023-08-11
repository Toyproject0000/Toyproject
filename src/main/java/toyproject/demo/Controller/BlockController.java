package toyproject.demo.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.service.BlockService;

import java.util.List;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
public class BlockController {
    private final BlockService blockService;
    @PostMapping("/block/user")
    public String blockUser(@SessionAttribute("SessionId") String userId,@RequestBody User user){
        return blockService.blockUser(userId, user.getId());
    }

    @PostMapping("/block/post")
    public String blockPost(@SessionAttribute("SessionId") String userId,@RequestBody Post post){
        return blockService.blockPost(userId, post);
    }

    @PostMapping("/report/user")
    public String reportUser(@SessionAttribute("SessionId") String userId,@RequestBody User user, @RequestBody String reason){
        return blockService.reportUser(userId, user.getId(), reason);
    }

    @PostMapping("/report/post")
    public String reportPost(@SessionAttribute("SessionId") String userId,@RequestBody Post post, @RequestBody String reason ){
        return blockService.reportPost(userId, post, reason);
    }

    @PostMapping("/cancel/block/user")
    public String cancelBlockUser(@SessionAttribute("SessionId") String userId,@RequestBody User user){
        return blockService.cancelBlockUser(userId, user.getId());
    }

    @PostMapping("/cancel/report/user")
    public String cancelReportUser(@SessionAttribute("SessionId") String userId,@RequestBody User user){
        return blockService.cancelReportUser(userId, user.getId());
    }

    @PostMapping("/cancel/block/post")
    public String cancelBlockPost(@SessionAttribute("SessionId") String userId,@RequestBody Post post){
        return blockService.cancelBlockPost(userId, post.getId());
    }

    @PostMapping("/cancel/report/post")
    public String cancelReportPost(@SessionAttribute("SessionId") String userId,@RequestBody Post post){
        return blockService.cancelReportPost(userId, post.getId());
    }

    @PostMapping("/find/block/user")
    public Optional<List<User>> findBlockUser(@SessionAttribute("SessionId") String userId){
        return Optional.ofNullable(blockService.findBlockUser(userId));
    }

    @PostMapping("/find/block/post")
    public Optional<List<Post>> findBlockPost(@SessionAttribute("SessionId") String userId){
        return Optional.ofNullable(blockService.findBlockPost(userId));
    }

    @PostMapping("/find/report/user")
    public Optional<List<User>> findReportUser(@SessionAttribute("SessionId") String userId){
        return Optional.ofNullable(blockService.findReportUser(userId));
    }

    @PostMapping("/find/report/post")
    public Optional<List<Post>> findReportPost(@SessionAttribute("SessionId") String userId){
        return Optional.ofNullable(blockService.findReportPost(userId));
    }

}
