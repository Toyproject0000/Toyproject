package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
public class Post {
    Long id;
    String userId;
    String contents;
    String title;
    String imgLocation;
    String category;
    Boolean Disclosure;
    LocalDateTime date;
}
