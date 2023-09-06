package toyproject.demo.domain.DTO;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class PostWithTokenDTO {
    Long id;
    String userId;
    String nickname;
    String root;
    String title;
    String contents;
    String imgLocation;
    String category;
    String disclosure;
    String possiblyReply;
    String visiblyLike;
    Integer likeCount;
    LocalDateTime date;
    String token;
}
