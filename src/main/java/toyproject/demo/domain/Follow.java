package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
public class Follow {
    Long id;
    String followingUserId; //팔로잉하는사람
    String followedUserId; //팔로잉받는사람
    LocalDateTime day;
}
