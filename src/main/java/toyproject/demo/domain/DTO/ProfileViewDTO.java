package toyproject.demo.domain.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProfileViewDTO {
    String nickname;
    String info;
    String imgLocation;
    String follower;
    String following;
}
