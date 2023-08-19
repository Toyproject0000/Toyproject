package toyproject.demo.Controller.완료;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.Report;
import toyproject.demo.domain.User;
import toyproject.demo.service.BlockService;

import java.util.List;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
public class BlockController {
    private final BlockService blockService;
    @PostMapping("/block/user")
    public String blockUser(@RequestBody Report report){
        return blockService.blockUser(report.getReportingUserId(), report.getReportedUserId());
    }

    @PostMapping("/block/post")
    public String blockPost(@RequestBody Report report){
        return blockService.blockPost(report.getReportingUserId(), report.getReportedPostId());
    }

    @PostMapping("/report/user")
    public String reportUser(@RequestBody User user, @RequestBody String reason, @RequestBody String blockingUser){
        return blockService.reportUser(blockingUser, user.getId(), reason);
    }

    @PostMapping("/report/post")
    public String reportPost(@RequestBody Post post, @RequestBody String reason, @RequestBody String blockingUser ){
        return blockService.reportPost(blockingUser, post, reason);
    }

    @PostMapping("/cancel/block/user")
    public String cancelBlockUser(@RequestBody User user, @RequestBody String blockingUser){
        return blockService.cancelBlockUser(blockingUser, user.getId());
    }

    @PostMapping("/cancel/report/user")
    public String cancelReportUser(@RequestBody User user, @RequestBody String blockingUser){
        return blockService.cancelReportUser(blockingUser, user.getId());
    }

    @PostMapping("/cancel/block/post")
    public String cancelBlockPost(@RequestBody Post post, @RequestBody String blockingUser){
        return blockService.cancelBlockPost(blockingUser, post.getId());
    }

    @PostMapping("/cancel/report/post")
    public String cancelReportPost(@RequestBody Post post, @RequestBody String blockingUser){
        return blockService.cancelReportPost(blockingUser, post.getId());
    }

    @PostMapping("/find/block/user")
    public Optional<List<User>> findBlockUser(@RequestBody String userId){
        return Optional.ofNullable(blockService.findBlockUser(userId));
    }

    @PostMapping("/find/block/post")
    public Optional<List<Post>> findBlockPost(@RequestBody String userId){
        return Optional.ofNullable(blockService.findBlockPost(userId));
    }

    @PostMapping("/find/report/user")
    public Optional<List<User>> findReportUser(@RequestBody String userId){
        return Optional.ofNullable(blockService.findReportUser(userId));
    }

    @PostMapping("/find/report/post")
    public Optional<List<Post>> findReportPost(@SessionAttribute("SessionId") String userId){
        return Optional.ofNullable(blockService.findReportPost(userId));
    }

}
