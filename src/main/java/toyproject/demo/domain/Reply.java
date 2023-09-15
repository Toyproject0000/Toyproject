package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Getter
@Setter
@Component
public class Reply {
    Long id;
    String userId;
    String postId;
    String nickname;
    String userImage;
    String contents;
    String userRoot;
    LocalDateTime date;
}
