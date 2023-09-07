package toyproject.demo.domain.DTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReplyLikeWithTokenDTO {
    Long id;
    String replyId;
    String userId;
    String token;
    String userRoot;
}
