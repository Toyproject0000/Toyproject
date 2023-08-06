package toyproject.demo.domain;

import com.google.gson.Gson;
import lombok.Getter;
import lombok.Setter;

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
    String Disclosure;
    LocalDateTime date;
    String img;
}
