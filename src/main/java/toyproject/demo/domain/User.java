package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class User {
    String id;
    String password;
    String name;
    String info;
    String phoneNumber;
    String nickname;
    Boolean gender;
    String imgLocation;
}
