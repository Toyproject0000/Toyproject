package toyproject.demo.domain.DTO;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class UserWithTokenDTO {
    String id;
    String root;
    String password;
    String name;
    LocalDate birth;
    String info;
    String phoneNumber;
    String nickname;
    Boolean gender;
    String imgLocation;
    String token;
    String loginId;
    String loginRoot;
}
