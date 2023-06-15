package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class Follow {
    Long id;
    String followingUserId;
    String followedUserId;
    LocalDate day;
}
