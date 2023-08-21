package toyproject.demo.Controller.완료;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.domain.DTO.BlockUserDTO;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.Report;
import toyproject.demo.service.BlockService;

import java.util.List;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
public class BlockController {
    private final BlockService blockService;
    @PostMapping(value = "/block/user", produces = "application/json;charset=UTF-8")
    public String blockUser(@RequestBody Report report){
        return blockService.blockUser(report.getReportingUserId(), report.getReportedUserId());
    }

    @PostMapping(value = "/block/post", produces = "application/json;charset=UTF-8")
    public String blockPost(@RequestBody Report report){
        return blockService.blockPost(report.getReportingUserId(), report.getReportedPostId());
    }

    @PostMapping(value = "/report/user", produces = "application/json;charset=UTF-8")
    public String reportUser(@RequestBody Report report){
        return blockService.reportUser(report.getReportingUserId(), report.getReportedUserId(), report.getReason());
    }

    @PostMapping(value = "/report/post", produces = "application/json;charset=UTF-8")
    public String reportPost(@RequestBody Report report){
        return blockService.reportPost(report.getReportingUserId(), report.getReportedPostId(), report.getReason());
    }

    @PostMapping(value = "/cancel/block/user", produces = "application/json;charset=UTF-8")
    public String cancelBlockUser(@RequestBody Report report){
        return blockService.cancelBlockUser(report.getReportingUserId(), report.getReportedUserId());
    }

    @PostMapping(value = "/cancel/report/user", produces = "application/json;charset=UTF-8")
    public String cancelReportUser(@RequestBody Report report){
        return blockService.cancelReportUser(report.getReportingUserId(), report.getReportedUserId());
    }

    @PostMapping(value = "/cancel/block/post", produces = "application/json;charset=UTF-8")
    public String cancelBlockPost(@RequestBody Report report){
        return blockService.cancelBlockPost(report.getReportingUserId(), report.getReportedPostId());
    }

    @PostMapping(value = "/cancel/report/post", produces = "application/json;charset=UTF-8")
    public String cancelReportPost(@RequestBody Report report){
        return blockService.cancelReportPost(report.getReportingUserId(), report.getReportedPostId());
    }

    @PostMapping(value = "/find/block/user", produces = "application/json;charset=UTF-8")
    public Optional<List<BlockUserDTO>> findBlockUser(@RequestBody Report report){
        return Optional.ofNullable(blockService.findBlockUser(report.getReportingUserId()));
    }

    @PostMapping(value = "/find/block/post", produces = "application/json;charset=UTF-8")
    public Optional<List<Post>> findBlockPost(@RequestBody Report report){
        return Optional.ofNullable(blockService.findBlockPost(report.getReportingUserId()));
    }

    @PostMapping(value = "/find/report/user", produces = "application/json;charset=UTF-8")
    public Optional<List<BlockUserDTO>> findReportUser(@RequestBody Report report){
        return Optional.ofNullable(blockService.findReportUser(report.getReportingUserId()));
    }

    @PostMapping(value = "/find/report/post", produces = "application/json;charset=UTF-8")
    public Optional<List<Post>> findReportPost(@RequestBody Report report){
        return Optional.ofNullable(blockService.findReportPost(report.getReportingUserId()));
    }

}