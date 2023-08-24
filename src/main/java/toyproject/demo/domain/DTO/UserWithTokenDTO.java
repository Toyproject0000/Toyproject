package toyproject.demo.domain.DTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserWithTokenDTO {
    String id;
    String password;
    String name;
    String info;
    String phoneNumber;
    String nickname;
    Boolean gender;
    String imgLocation;
    String token;
}
