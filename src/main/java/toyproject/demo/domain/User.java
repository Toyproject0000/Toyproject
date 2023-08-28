package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class User {
    String id;
    String root;
    String password = "소셜로그인회원";
    String name;
    String info;
    String phoneNumber;
    String nickname;
    Boolean gender;
    String imgLocation;
}