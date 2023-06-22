package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Component
public class Reply {
    Long id;
    String userId;
    String postId;
    String contents;
}
