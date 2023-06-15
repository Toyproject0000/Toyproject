package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReplyLike {
    Long id;
    String replyId;
    String userId;
}
