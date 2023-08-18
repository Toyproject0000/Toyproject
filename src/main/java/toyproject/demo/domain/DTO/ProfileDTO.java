package toyproject.demo.domain.DTO;

import lombok.Getter;
import lombok.Setter;
import toyproject.demo.domain.Post;

import java.util.List;

@Getter
@Setter
public class ProfileDTO {
    String id;
    String nickname;
    String imgLocation;
    List<Post> posts;
}
