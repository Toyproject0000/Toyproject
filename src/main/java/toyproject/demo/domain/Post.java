package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class Post {
    Long id;
    String userId;
    String contents;
    LocalDate date;
}
