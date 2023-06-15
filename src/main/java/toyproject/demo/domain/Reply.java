package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Reply {
    Long id;
    String userId;
    String postId;
    String contents;
}
