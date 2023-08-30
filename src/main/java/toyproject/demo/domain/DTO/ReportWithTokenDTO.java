package toyproject.demo.domain.DTO;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ReportWithTokenDTO {
    String reportingUserId;
    String reportedUserId;
    String reportingUserRoot;
    String reportedUserRoot;
    Long reportedPostId;
    String reason;
    LocalDateTime date;
    String token;
}
