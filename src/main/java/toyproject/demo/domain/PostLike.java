package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostLike {
    Long id;
    String postId;
    String userId;
}
