package toyproject.demo.domain.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class ProfileViewDTO {
    String nickname;
    String info;
    String imgLocation;
    LocalDate birth;
    String follower;
    String following;
}
