package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class Report {
    String reportingUserId;
    String reportedUserId;
    Long reportedPostId;
    String reason;
    LocalDateTime date;
}