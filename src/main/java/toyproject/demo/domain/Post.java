package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Post {
    Long id;
    String userId;
    String contents;
}
