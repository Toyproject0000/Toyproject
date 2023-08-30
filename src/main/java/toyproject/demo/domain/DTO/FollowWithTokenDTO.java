package toyproject.demo.domain.DTO;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class FollowWithTokenDTO {
    Long id;
    String followingUserId; //팔로잉하는사람
    String followedUserId; //팔로잉받는사람
    LocalDateTime date;
    String token;
    String followingUserRoot; //팔로잉하는사람
    String followedUserRoot;
}
