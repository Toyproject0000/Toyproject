package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class Report {

    String reportingUserId;
    String reportedUserId;
    String reportedPostId;
    String reason;
    LocalDateTime date;

}
