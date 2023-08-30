package toyproject.demo.Controller.완료;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.converter.ReportConverter;
import toyproject.demo.domain.DTO.BlockUserDTO;
import toyproject.demo.domain.DTO.ReportWithTokenDTO;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.Report;
import toyproject.demo.domain.User;
import toyproject.demo.service.BlockService;
import toyproject.demo.service.JwtTokenUtil;

import java.util.List;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
public class BlockController {
    private final BlockService blockService;
    private final JwtTokenUtil tokenUtil;
    private final ReportConverter converter;
    @PostMapping(value = "/block/user", produces = "application/json;charset=UTF-8")
    public String blockUser(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        return blockService.blockUser(report.getReportingUserId(), report.getReportedUserId(), report.getReportingUserRoot(), report.getReportedUserRoot());
    }

    @PostMapping(value = "/block/post", produces = "application/json;charset=UTF-8")
    public String blockPost(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        return blockService.blockPost(report.getReportingUserId(), report.getReportedPostId(), report.getReportingUserRoot());
    }

    @PostMapping(value = "/report/user", produces = "application/json;charset=UTF-8")
    public String reportUser(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        return blockService.reportUser(report.getReportingUserId(), report.getReportedUserId(), report.getReason(), report.getReportingUserRoot(), report.getReportedUserRoot());
    }

    @PostMapping(value = "/report/post", produces = "application/json;charset=UTF-8")
    public String reportPost(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        return blockService.reportPost(report.getReportingUserId(), report.getReportedPostId(), report.getReason(), report.getReportingUserRoot());
    }

    @PostMapping(value = "/cancel/block/user", produces = "application/json;charset=UTF-8")
    public String cancelBlockUser(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        return blockService.cancelBlockUser(report.getReportingUserId(), report.getReportedUserId(), report.getReportingUserRoot(), report.getReportedUserRoot());
    }

    @PostMapping(value = "/cancel/report/user", produces = "application/json;charset=UTF-8")
    public String cancelReportUser(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        return blockService.cancelReportUser(report.getReportingUserId(), report.getReportedUserId(), report.getReportingUserRoot(), report.getReportedUserRoot());
    }

    @PostMapping(value = "/cancel/block/post", produces = "application/json;charset=UTF-8")
    public String cancelBlockPost(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            System.out.println(e.getMessage());
            return "잘못된 접근입니다.";
        }
        return blockService.cancelBlockPost(report.getReportingUserId(), report.getReportedPostId(), report.getReportingUserRoot());
    }

    @PostMapping(value = "/cancel/report/post", produces = "application/json;charset=UTF-8")
    public String cancelReportPost(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        return blockService.cancelReportPost(report.getReportingUserId(), report.getReportedPostId(), report.getReportingUserRoot());
    }

    @PostMapping(value = "/find/block/user", produces = "application/json;charset=UTF-8")
    public Optional<List<User>> findBlockUser(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            return null;
        }
        return Optional.ofNullable(blockService.findBlockUser(report.getReportingUserId(), report.getReportingUserRoot()));
    }

    @PostMapping(value = "/find/block/post", produces = "application/json;charset=UTF-8")
    public Optional<List<Post>> findBlockPost(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            return null;
        }
        return Optional.ofNullable(blockService.findBlockPost(report.getReportingUserId(), report.getReportingUserRoot()));
    }

    @PostMapping(value = "/find/report/user", produces = "application/json;charset=UTF-8")
    public Optional<List<User>> findReportUser(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            return null;
        }
        return Optional.ofNullable(blockService.findReportUser(report.getReportingUserId(), report.getReportingUserRoot()));
    }

    @PostMapping(value = "/find/report/post", produces = "application/json;charset=UTF-8")
    public Optional<List<Post>> findReportPost(@RequestBody ReportWithTokenDTO report){
        try {
            tokenUtil.parseJwtToken(report.getToken());
        }catch (Exception e){
            return null;
        }
        return Optional.ofNullable(blockService.findReportPost(report.getReportingUserId(), report.getReportingUserRoot()));
    }

}