package toyproject.demo.Controller.완료;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import toyproject.demo.domain.DTO.BlockUserDTO;
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
    public String reportUser(@RequestBody Report report){
        return blockService.reportUser(report.getReportingUserId(), report.getReportedUserId(), report.getReason());
    }

    @PostMapping("/report/post")
    public String reportPost(@RequestBody Report report){
        return blockService.reportPost(report.getReportingUserId(), report.getReportedPostId(), report.getReason());
    }

    @PostMapping("/cancel/block/user")
    public String cancelBlockUser(@RequestBody Report report){
        return blockService.cancelBlockUser(report.getReportingUserId(), report.getReportedUserId());
    }

    @PostMapping("/cancel/report/user")
    public String cancelReportUser(@RequestBody Report report){
        return blockService.cancelReportUser(report.getReportingUserId(), report.getReportedUserId());
    }

    @PostMapping("/cancel/block/post")
    public String cancelBlockPost(@RequestBody Report report){
        return blockService.cancelBlockPost(report.getReportingUserId(), report.getReportedPostId());
    }

    @PostMapping("/cancel/report/post")
    public String cancelReportPost(@RequestBody Report report){
        return blockService.cancelReportPost(report.getReportingUserId(), report.getReportedPostId());
    }

    @PostMapping("/find/block/user")
    public Optional<List<BlockUserDTO>> findBlockUser(@RequestBody Report report){
        return Optional.ofNullable(blockService.findBlockUser(report.getReportingUserId()));
    }

    @PostMapping("/find/block/post")
    public Optional<List<Post>> findBlockPost(@RequestBody Report report){
        return Optional.ofNullable(blockService.findBlockPost(report.getReportingUserId()));
    }

    @PostMapping("/find/report/user")
    public Optional<List<BlockUserDTO>> findReportUser(@RequestBody Report report){
        return Optional.ofNullable(blockService.findReportUser(report.getReportingUserId()));
    }

    @PostMapping("/find/report/post")
    public Optional<List<Post>> findReportPost(@RequestBody Report report){
        return Optional.ofNullable(blockService.findReportPost(report.getReportingUserId()));
    }

}