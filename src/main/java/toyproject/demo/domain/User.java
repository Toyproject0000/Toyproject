package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;


@Getter
@Setter
public class User {
    String id;
    String root;
    String password = "소셜로그인회원";
    String name;
    LocalDate birth;
    String info;
    String phoneNumber;
    String nickname;
    Boolean gender;
    String imgLocation;
}