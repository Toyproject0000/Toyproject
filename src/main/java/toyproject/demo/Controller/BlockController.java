package toyproject.demo.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.converter.ReportConverter;
import toyproject.demo.domain.DTO.BlockUserDTO;
import toyproject.demo.domain.DTO.ReportWithTokenDTO;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.Report;
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
    public String blockUser(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Report report = converter.convert(tokenReport);
        return blockService.blockUser(report.getReportingUserId(), report.getReportedUserId());
    }

    @PostMapping(value = "/block/post", produces = "application/json;charset=UTF-8")
    public String blockPost(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Report report = converter.convert(tokenReport);
        return blockService.blockPost(report.getReportingUserId(), report.getReportedPostId());
    }

    @PostMapping(value = "/report/user", produces = "application/json;charset=UTF-8")
    public String reportUser(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Report report = converter.convert(tokenReport);
        return blockService.reportUser(report.getReportingUserId(), report.getReportedUserId(), report.getReason());
    }

    @PostMapping(value = "/report/post", produces = "application/json;charset=UTF-8")
    public String reportPost(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Report report = converter.convert(tokenReport);
        return blockService.reportPost(report.getReportingUserId(), report.getReportedPostId(), report.getReason());
    }

    @PostMapping(value = "/cancel/block/user", produces = "application/json;charset=UTF-8")
    public String cancelBlockUser(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Report report = converter.convert(tokenReport);
        return blockService.cancelBlockUser(report.getReportingUserId(), report.getReportedUserId());
    }

    @PostMapping(value = "/cancel/report/user", produces = "application/json;charset=UTF-8")
    public String cancelReportUser(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Report report = converter.convert(tokenReport);
        return blockService.cancelReportUser(report.getReportingUserId(), report.getReportedUserId());
    }

    @PostMapping(value = "/cancel/block/post", produces = "application/json;charset=UTF-8")
    public String cancelBlockPost(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Report report = converter.convert(tokenReport);
        return blockService.cancelBlockPost(report.getReportingUserId(), report.getReportedPostId());
    }

    @PostMapping(value = "/cancel/report/post", produces = "application/json;charset=UTF-8")
    public String cancelReportPost(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Report report = converter.convert(tokenReport);
        return blockService.cancelReportPost(report.getReportingUserId(), report.getReportedPostId());
    }

    @PostMapping(value = "/find/block/user", produces = "application/json;charset=UTF-8")
    public Optional<List<BlockUserDTO>> findBlockUser(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return null;
        }
        Report report = converter.convert(tokenReport);
        return Optional.ofNullable(blockService.findBlockUser(report.getReportingUserId()));
    }

    @PostMapping(value = "/find/block/post", produces = "application/json;charset=UTF-8")
    public Optional<List<Post>> findBlockPost(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return null;
        }
        Report report = converter.convert(tokenReport);
        return Optional.ofNullable(blockService.findBlockPost(report.getReportingUserId()));
    }

    @PostMapping(value = "/find/report/user", produces = "application/json;charset=UTF-8")
    public Optional<List<BlockUserDTO>> findReportUser(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return null;
        }
        Report report = converter.convert(tokenReport);
        return Optional.ofNullable(blockService.findReportUser(report.getReportingUserId()));
    }

    @PostMapping(value = "/find/report/post", produces = "application/json;charset=UTF-8")
    public Optional<List<Post>> findReportPost(@RequestBody ReportWithTokenDTO tokenReport){
        try {
            tokenUtil.parseJwtToken(tokenReport.getToken());
        }catch (Exception e){
            return null;
        }
        Report report = converter.convert(tokenReport);
        return Optional.ofNullable(blockService.findReportPost(report.getReportingUserId()));
    }

}