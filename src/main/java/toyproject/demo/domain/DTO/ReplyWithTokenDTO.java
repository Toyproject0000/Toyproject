package toyproject.demo.domain.DTO;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ReplyWithTokenDTO {
    Long id;
    String userId;
    String nickname;
    String userRoot;
    String userImage;
    String postId;
    String contents;
    LocalDateTime date;
    String token;
}
