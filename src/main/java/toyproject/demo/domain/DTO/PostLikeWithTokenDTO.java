package toyproject.demo.domain.DTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostLikeWithTokenDTO {
    Long id;
    String postId;
    String userId;
    String userRoot;
    String token;
}
