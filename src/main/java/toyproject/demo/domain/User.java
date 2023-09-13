package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.UUID;


@Getter
@Setter
public class User {
    String id;
    String root;
    String password = String.valueOf(UUID.randomUUID());
    String name;
    LocalDate birth;
    String info;
    String phoneNumber;
    String nickname;
    Boolean gender;
    String imgLocation;
    String firebaseToken;
}